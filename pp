#!/bin/bash

gprof nek5000 gmon.out > report.txt
gprof2dot report.txt > report.dot
dot -Tpdf -oreport.pdf report.dot
