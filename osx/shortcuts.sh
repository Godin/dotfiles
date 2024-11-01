#!/bin/sh

plutil -convert xml1 -o - shortcuts.json | defaults import pbs -
