#!/bin/bash

yum install -y epel-release vim unzip wget python3
pip3 install noipy --upgrade
noipy -u gilesdj@gmail.com -p Snoopy*13 -n saltdemo.sytes.net --provider noip
