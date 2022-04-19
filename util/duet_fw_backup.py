'''Backup Duet files via HTTP API

To backup the entire SD to current working directory:
`python duet_fw_backup.py $PRINTER_IP / .`
'''


import argparse
from pathlib import Path, PurePath, PurePosixPath
import os

from duetwebapi import DuetWebAPI # pip install duetwebapi
from tqdm import tqdm  # pip install tqdm


def find_all_child_files(printer, dir_path: PurePosixPath, ignore_jobs=False):
    '''Recursively list all directories from a given root path.
    Return relative paths for all files contained.
    '''
    files = []
    top_listing = printer.get_directory(str(dir_path))
    for entry in top_listing:
        if entry["name"] == "System Volume Information":  # dont care
            continue
        elif ignore_jobs and entry["name"] == "gcodes":
            continue
        elif entry["type"] == "d":  # directory, recurse
            child_dir_path = dir_path / PurePosixPath(entry["name"])
            child_files = find_all_child_files(printer, child_dir_path)
            files += child_files
        elif entry["type"] == "f":  # file, just add to the list
            file_path = dir_path / PurePosixPath(entry["name"])
            files += [file_path]
        else:
            print(f"Unknown dir entry type \"{entry['type']}\" for {entry['name']}")
    return files


def download_file(printer, file_path: PurePosixPath, dest_dir: Path):
    if str(file_path).startswith("/"):  # we can't append two paths starting with /
        file_path = PurePosixPath(str(file_path)[1:])

    dest_path = dest_dir / file_path
    os.makedirs(dest_path.parent, exist_ok=True)  # create dest dir
    
    file_dir = file_path.parent
    file_name = file_path.name
    #print(f"downloading {str(file_path)} to: {dest_path}")
    file_content = printer.get_file(file_name, directory=file_dir, binary=True)
    #file_content = printer.get_file(str(file_path), directory=".")
    if not file_content:
        print(f"error getting file: {file_path}")
    else:
        with open(dest_path, "wb") as f:
            f.write(file_content)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("host", help="Printer host IP")
    parser.add_argument("src", help="Remote directory")
    parser.add_argument("dest", help="Destination local directory")
    parser.add_argument("--no-jobs", action="store_true", help="Ignore gcode jobs dir.")
    parser.add_argument("-p", "--password", help="Optional Duet password")
    args = parser.parse_args()

    if not args.password:
        password = ""
    else:
        password = args.password

    dest_dir = Path(args.dest)

    printer = DuetWebAPI(f"http://{args.host}")
    printer.connect(password=password)

    all_files = find_all_child_files(printer, PurePosixPath(args.src), ignore_jobs=args.no_jobs)
    for file_path in tqdm(all_files):
        download_file(printer, file_path, dest_dir)


if __name__ == "__main__":
    main()
