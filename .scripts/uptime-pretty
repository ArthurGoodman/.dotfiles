#!/bin/sh

uptime --pretty | \
    sed 's/\ years\?,/y/' | \
    sed 's/\ days\?,/d/' | \
    sed 's/\ hours\?,\?/h/' | \
    sed 's/\ minutes\?/m/'
