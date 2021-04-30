#/bin/env python3

import sys
import shutil
import glob
from os import path
from typing import List

def file_size(f: str) -> int:
    return path.getsize(f)

def largest_sub(subs: List[str]) -> str:
    subs.sort(key=file_size)
    return subs[-1]

def cp(file: str) -> None:
    if not path.isfile(file):
        print('{} not a vid file'.format(file))
    else:
        file_dir = path.split(file)[0]
        file_no_ext = path.splitext(path.basename(file))[0]
        sub_dir = path.join(file_dir, 'Subs', file_no_ext)
        eng_subs = glob.glob(sub_dir + '/*English.srt')

        new_sub = path.splitext(file)[0] + '.srt'
        shutil.copy(largest_sub(eng_subs), new_sub)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Invalid number of arguments, expected 1')
    else:
        cp(sys.argv[1])


