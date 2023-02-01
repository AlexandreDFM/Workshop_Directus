#!/bin/bash
# EPITECH PROJECT, 2023
# Workshop_Directus
# File description:
# restore.sh
#

if [ -z "$BASH" ]
then
    "Error: You need to execute this script with bash"
    exit -1
fi

# MySQL
MYSQL_USER=root
MYSQL_PASSWORD=1234567890
DB_NAME=workshop_directus

echo "Creating database ${DB_NAME} if it doesn't exist.."

docker exec -i $(docker-compose ps -q mysql)                                   \
    mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e                              \
    "CREATE DATABASE IF NOT EXISTS ${DB_NAME}"

echo "Restore ${DB_NAME} data."

docker exec -i $(docker-compose ps -q mysql)                                   \
    mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${DB_NAME}                      \
    < ../database/${DB_NAME}.sql
