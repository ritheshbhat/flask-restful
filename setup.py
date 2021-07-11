from __future__ import print_function

from os import path

from setuptools import find_namespace_packages, setup

here = path.abspath(path.dirname(__file__))
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

with open(path.join(here, 'src/wisecoder/version.txt'), encoding='utf-8') as f:
    version = f.read()

with open('requirements.txt') as f:
    required = f.read().splitlines()

setup(
    name = 'wisecoder',
    version = version,
    description = long_description,
    python_requires = '>=3.6, <4',
    package_dir = {"": "src"},
    packages = find_namespace_packages(where = "src"),
    install_requires = required
)
