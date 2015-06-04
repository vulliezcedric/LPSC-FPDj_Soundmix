@echo off
title run simulation

REM -- set path to Questa
REM    this line will be replaced with something like this: 
REM    set simulator_path=C:\eda\mentor\questasim64_10.1a\win64\
set simulator=G:\questasim10d\win32
REM -- start main menu with optional argument.
start %simulator%\questasim.exe -do sim.do

