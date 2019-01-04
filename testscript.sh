#!/bin/bash
a=509
if [[ "$a" =~ 5{00..10} ]]
then
echo "Hi"
else
echo "Hello"
fi
