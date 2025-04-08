#!/usr/bin/env bash

echo `brightnessctl | grep -o "(.*" | tr -d "()"`
