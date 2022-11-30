#!/usr/bin/env python

from setuptools import setup, find_packages
import os.path


def read_version():
    """Read the library version"""
    path = os.path.join(
        os.path.abspath(os.path.dirname(__file__)), "code_advent", "_version.py"
    )
    with open(path) as f:
        exec(f.read())
        return locals()["__version__"]


if __name__ == "__main__":
    setup(
        name="code_advent",
        version=read_version(),
        description="Advent of Code Challenges",
        author="fdm1",
        url="https://github.com/fdm1/code_advent",
        packages=find_packages(
            exclude="tests",
        ),
    )
