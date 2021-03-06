#!/bin/bash -
#===============================================================================
#
#          FILE: sync_owncloud.sh
#
#         USAGE: ./sync_owncloud.sh
#
#   DESCRIPTION: Script to sync owncloud folder on a server.
#
#                This script is intended to be used as a cron task.
#
#                For example to sync owncloud every hour (crontab -e):
#
#                0 * * * * /bin/bash /path/to/sync_owncloud.sh
#
#                Warning: the password is stored in clear in the file...
#                Partial solution: encrypt the password inside a file,
#                then read and decrypt the file when needed.
#
#                Example:
#                echo 'mysecretpassword' | openssl enc -base64 -e -aes-256-cbc -nosalt
#                                          --pbkdf2 -pass pass:garbageKey  > .secret.lck
#
#                And set `PASSWORD` to:
#                `cat .secret.lck | openssl enc -base64 -d -aes-256-cbc -nosalt
#                --pbkdf2 -pass pass:garbageKey`
#
#       OPTIONS: ---
#  REQUIREMENTS: owncloudcmd-client>=2.4.1
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Axel Fahy (axel@fahy.net),
#  ORGANIZATION:
#       CREATED: 05.01.2019 09:19
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error.

# Credentials
readonly USER=TO_COMPLETE
readonly PASSWORD=TO_COMPLETE
# Webdav URL, might need https and `@` should be replaced by `%40` WITH ending slash.
readonly WEBDAV_URL=TO_COMPLETE
# Full path to the folder to sync WITHOUT the ending slash.
readonly PATH_FOLDER=TO_COMPLETE

export OWNCLOUD_CHUNKING_NG=0

# Split path of FOLDER to get the last item.
/usr/bin/owncloudcmd --user $USER --password $PASSWORD $PATH_FOLDER $WEBDAV_URL${PATH_FOLDER##*/}

