'''Sync local files to Duet via HTTP API.

python ./util/duet_fw_upload.py 192.168.1.137 . / -w
'''


import argparse
from pathlib import Path, PurePath, PurePosixPath
import os
import time

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


def delete_file(printer, file_path: Path):
    if str(file_path).startswith("/"):  # we can't append two paths starting with /
        file_path = PurePosixPath(str(file_path)[1:])
    
    file_dir = file_path.parent
    file_name = file_path.name
    #print(f"Deleting {file_name} from {file_dir}")
    printer.delete_file(filename=file_name, directory=file_dir)


def delete_empty_dirs(printer, dir_path: Path):
    while True:
        listing = printer.get_directory(str(dir_path))
        for entry in listing:
            if entry["type"] == "d":
                delete_empty_dirs(printer, dir_path / PurePosixPath(entry["name"]))
            elif entry["type"] == "f":  # left over file i guess
                delete_file(printer, dir_path / PurePosixPath(entry["name"]))

        if not listing:  # we found an empty dir!
            # to delete /macros/wipe/scripts:
            # printer.delete_file(filename="scripts", directory="macros/wipe")
            dir = dir_path.parent
            dir_name = dir_path.name
            #print(f"deleting empty dir: {dir} / {dir_name}")
            printer.delete_file(filename=dir_name, directory=dir)
            break



def upload_file(printer, file_path: Path, file_content: bytes):
    if str(file_path).startswith("/"):  # we can't append two paths starting with /
        file_path = PurePosixPath(str(file_path)[1:])
    
    file_dir = file_path.parent
    if file_dir == PurePosixPath("./"):
        file_dir = PurePosixPath("/")
    file_name = file_path.name
    
    # create parent dirs
    for dir in file_dir.parts:
        if dir == "\\" or dir == "/":
            pass
        else:
            #print(f"Creating {dir}")
            printer.create_directory(dir)

    #print(f"Uploading {file_dir} / {file_name}")
    out = printer.upload_file(file=file_content, filename=file_name, directory=file_dir)


def create_directories(printer, local_path: Path, dest_root: PurePosixPath):
    '''Create empty directories reflecting local directories.
    These will later be uploaded to.
    '''
    for child_dir in local_path.iterdir():
        if child_dir.is_dir():
            new_dir = dest_root / child_dir
            #print(f"Creating {new_dir}")
            printer.create_directory(dest_root / child_dir)
            create_directories(printer, child_dir, dest_root)


def upload_directory(printer, local_path: Path, dest_root: PurePosixPath):
    '''upload contents of local directory to duet'''
    
    # create empty dirs first
    #create_directories(printer, local_path, dest_root)

    
    # filter out things we don't want to upload (.git, util)
    all_files = list(local_path.rglob("*"))
    filtered_files = []
    for p in all_files:
        if ".git" in p.parts:
            pass
        elif p.parts[0] == "util":
            pass
        else:
            filtered_files.append(p)

    # now upload the files
    for child in tqdm(filtered_files):
        if ".git" in child.parts:
            continue
        elif not child.is_dir():
            with open(child, "rb") as f:
                p =  PurePosixPath(child)
                upload_file(printer, p, f.read())



def wipe_old_gcode(printer, files, allowed_dirs=None):
    '''Delete any old gcode config files.
    This simply deletes any .g in /sys, /macros, etc.
    Allowed dirs must not have the / prefix
    '''

    if not allowed_dirs:
        allowed_dirs = ["macros", "sys"]

    for f in files:
        top_dir = f.parts[1]
        extension = f.suffix
        if top_dir in allowed_dirs and extension == ".g":
            delete_file(printer, f)

    # delete leftover empty dirs in macros
    delete_empty_dirs(printer, PurePosixPath("macros"))    


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("host", help="Printer host IP")
    parser.add_argument("src", help="Local directory", type=Path)
    parser.add_argument("dest", help="Destination directory")
    parser.add_argument("-p", "--password", help="Optional Duet password")
    parser.add_argument("-i", "--ignore", help="Directories to ignore")
    parser.add_argument("-w", "--wipe", action="store_true", help="Delete old config gcode first. BACKUP FIRST!!!")
    args = parser.parse_args()

    if not args.password:
        password = ""
    else:
        password = args.password

    printer = DuetWebAPI(f"http://{args.host}")
    printer.connect(password=password)

    if args.wipe:
        all_files = find_all_child_files(printer, PurePosixPath(args.dest), ignore_jobs=True)
        wipe_old_gcode(printer, all_files)

    upload_directory(printer, args.src, PurePosixPath(args.dest))

    time.sleep(5)

    printer.send_code("M999")  # restart the board


if __name__ == "__main__":
    main()
