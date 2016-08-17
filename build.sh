#!/bin/bash
VERSION=`cat version`
IMAGENAME="eyevinntechnology/toolbelt"

docker build -t $IMAGENAME:$VERSION .
