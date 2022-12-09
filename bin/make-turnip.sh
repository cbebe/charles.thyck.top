#!/bin/sh

sed "1 r turnip/index.html" $1 >$2
