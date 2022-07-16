'''A simple linter for Duet/RepRapFirmware GCode.'''

import argparse
import os
import pathlib
import re
from typing import List, Tuple, Iterator


def find_matches(file: pathlib.Path, regex: str) -> Iterator[Tuple[pathlib.Path, int, str]]:
    '''Find all lines matching a regex.
    
    Returns a tuple with: (path, line_number, line)
    '''

    exp = re.compile(regex)

    f = open(file, "r")
    for idx, line in enumerate(f):
        line_no = idx + 1
        match = exp.search(line)
        if match:
            yield (file, line.strip(), line_no)
    f.close()

# TODO: "unknown value" linter. find references to variables that aren't defined
# it shouldn't be *too* hard

# TODO: check for infinite while loops
# either while trues with no break
# or a while where the variable isn't modified in the body

# TODO: check for macro call stack overflow
# RRF < 3.4 can only do 7 nested calls
# RRF 3.4 can do 10
# I've definitely run into this limitation before, and I think we could check it statically

# TODO: comments between if/elif/else blocks
# example: something like this will not work:
# if something
#     do stuff here
# ; A BAD COMMENT
# elif another_thing
#     ; AN OKAY COMMENT
#     do other stuff here

# TODO: Check for G0/G1 moves without explicit feedrate?
# sometimes it implicitly uses the last set feedrate, which could be very slow if we just probed

# TODO: creating vars in if/elif/else blocks
# I've found that it destroys the vars at the end of the if block
# So you need to create first and then modify in an if

def lint_line_length(file: pathlib.Path):
    '''Find any commands that are > 160 chars.
    Duet currently cannot handle longer lines.
    '''
    with open(file, "r") as f:
        for idx, line in enumerate(f.readlines()):
            line_no = idx + 1
            if len(line) > 160:
                print(f"Line {line_no} - Command too long. Max length is 160 chars")
                print(">\t" + line)


def lint_m98_no_p(file: pathlib.Path):
    '''Find M98 commands without a P argument.
    I often do M98 "macro_file.g" instead of M98 P"macro_file.g"
    '''
    m98_matches = find_matches(file, r"M98")
    for path, line, line_no in m98_matches:
        cmd_args = line.split(" ")[1:]
        missing_p_arg = not any([arg.startswith("P") for arg in cmd_args])
        if missing_p_arg:
            print(f"Line {line_no} - Missing P-argument for M98 command")
            print(">\t" + line)


def lint_m98_bad_path(file: pathlib.Path, root: pathlib.Path):
    '''Find M98 commands with an invalid path.'''
    m98_matches = find_matches(file, r"M98")
    for path, line, line_no in m98_matches:
        match = re.search(r'P"(\S+)"', line)
        if match:
            macro_path = match.groups()[0]
            # rebase macro path
            macro_path_relative = pathlib.Path(str(macro_path)[1:])  # chop off the /, hacky
            macro_path_full = root / macro_path_relative
            if not macro_path_full.exists():
                print(f"Line {line_no} - Macro path does not exist: {macro_path_full}")
                print(">\t" + line)


def lint_move_no_coordinate_setup(file: pathlib.Path):
    '''Find files with moves (G0, G1, etc) but no preceding G90/G91
    
    Implicitly defining the coordinate system can result in weird problems.
    Macros can also override the coordinate system and not fix it up, but we dont check for that.
    '''
    move_matches = find_matches(file, r"G0 |G1 |G2 |G3 ")
    coordinate_matches = find_matches(file, "G90|G91")
    coordinate_line_numbers = [x[2] for x in coordinate_matches]
    try:
        first_coordinate = min(coordinate_line_numbers)
    except:
        first_coordinate = None  # idk, some big number

    for f, line, line_no in move_matches:
        if first_coordinate is None:  # no G90/G91 at all
            print(f"Line {line_no} - Move command but no G90/G91")
            print(">\t" + line)
        elif line_no < first_coordinate:  # move appears before G90/G91
            print(f"Line {line_no} - Move with no preceding G90/G91.")
            print(">\t" + line)
        else:  # should be okay
            pass


def lint_bad_param_name(file: pathlib.Path):
    matches = find_matches(file, r"param\.G|param\.M|param\.N|param\.T")
    for f, line, line_no in matches:
        print(f"Line {line_no} - Bad macro parameter name. G, M, N, and T are not allowed.")
        print(">\t" + line)


def lint_incorrect_parameter_multiple_values(file: pathlib.Path):
    matches = find_matches(file, r"\}:\{")
    for f, line, line_no in matches:
        print(f"Line {line_no} - Deprecated syntax for multiple values in parameter. This can cause weird issues." + "Use P{var1, var2, var3} instead.")
        print(">\t" + line)


def lint_empty_file(file: pathlib.Path):
    size = file.stat().st_size
    if size < 1:
        print("File is empty")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("path", help="Path to gcode codebase.",
                        type=pathlib.Path)
    parser.add_argument("-i", "--ignore", help="Comma separate list of checks to ignore",
                        default="")
    args = parser.parse_args()

    src_path = args.path
    ignore_list = args.ignore.split(",")
    all_gcode_files = list(src_path.glob("**/*.g"))

    for file in all_gcode_files:
        print(file)

        lint_line_length(file)
        lint_m98_no_p(file)
        lint_m98_bad_path(file, root=src_path)
        lint_move_no_coordinate_setup(file)
        lint_bad_param_name(file)
        lint_incorrect_parameter_multiple_values(file)
        lint_empty_file(file)

        print("-" * 80)


if __name__ == "__main__":
    main()