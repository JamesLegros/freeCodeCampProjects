#!/bin/bash
#Dump worldcup DB

pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
