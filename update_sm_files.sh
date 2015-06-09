#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DB_HOST=${DB_HOST:-127.0.0.1}
DB_USER=${DB_USER:-admin}
DB_PASS=${DB_PASS:-pass}

for file in `find $DIR/config/projects -type f | grep -v orig`
do
    sed 's/###DB_HOST###/'$DB_HOST'/g;s/###DB_USER###/'$DB_USER'/g;s/###DB_PASS###/'$DB_PASS'/g' < ${file}.orig > ${file}
done
