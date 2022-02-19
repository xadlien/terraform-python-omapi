#!/usr/bin/env python

from distutils.core import setup

setup(name='python_omapi_provider',
    version='1.0',
    description='Python OMAPI DHCP Terraform provider for address reservations.',
    author='Daniel Martin',
    url='https://github.com/xadlien/terraform-python-omapi',
    packages=['python_omapi_provider'],
    install_requires=[
        'pypureomapi==0.8'
    ],
    entry_points={
        'console_scripts': ['python-omapi-provider=python_omapi_provider.__main__:main']
    }
)
