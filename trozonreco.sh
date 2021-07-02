#!/bin/bash

cd ~/
mkdir trozonrecon
mkdir ~/trozonreco/$1
dir=~/trozonreco/$1

cd $dir
trozonreco $1 $1_tz $2
