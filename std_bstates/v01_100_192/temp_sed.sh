#!/bin/bash

bstate=$1

sed -i "s/BSTATE/${bstate}/g" *.slurm
