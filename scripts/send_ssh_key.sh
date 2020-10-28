#!/bin/bash -
#===============================================================================
#
#          FILE: send_ssh_key.sh
#
#         USAGE: ./send_ssh_key.sh
#
#   DESCRIPTION: Script to send ssh key to a list of servers.
#                This needs `sshpass` in order to ask for the password a single time.
#
#                Password will be prompt.
#
#                Parameters:
#                  - Username for the ssh connection
#                  - key location (default: ~/.ssh/id_rsa.pub)
#
#       OPTIONS: ---
#  REQUIREMENTS: sshpass
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Axel Fahy (axel@fahy.net),
#  ORGANIZATION:
#       CREATED: 28. 10. 20 13:27
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

declare -r -a SERVERS=("")                  # Complete the list of servers (separated by space)
declare -r USERNAME=${1:-$USER}
declare -r KEY_PATH=${2:-$HOME/.ssh/id_rsa.pub}
read -s -p "Password: " password

for server in ${SERVERS[@]};
do
    sshpass -p $password ssh-copy-id -i $KEY_PATH $USERNAME@$server
done

