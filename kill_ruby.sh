#!/bin/bash

ps -A | grep ruby | awk '{ system("kill -9 "$1)};'
