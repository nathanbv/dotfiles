#!/bin/bash

ACTION="${1}"


if [ "${ACTION}" == "add" ]; then
    echo ADD
elif [ "${ACTION}" == "remove" ]; then
    echo REMOVE
else
    echo SOMETHING ELSE
fi
