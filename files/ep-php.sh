#!/bin/bash

a2enmod rewrite expires

exec "$@"

