#!/bin/bash

set -e

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

user_specified_file="$1"
user_specified_site="$2"

if [ -z "$user_specified_file" ]; then
  user_specified_file="$DIR/*.req"
fi

if [ -n "$user_specified_site" ]; then
  echo "Generating new $user_specified_file passphrases for '$user_specified_site'."
  echo 'Continue? (y/n)'
  read answer
  if [ "$answer" != 'y' ]; then
    echo "Exiting without generating passphrases."
    exit 1
  fi
  site_list="$user_specified_site"
else
  site_list="$(ls "$DIR/../site")"
fi

for site in $site_list; do
  site_dir="$DIR/../site/$site"
  mkdir -p "$site_dir/secrets/passphrases"
  IFS=$'\n'
  for p in $(cat $user_specified_file); do
    export PP_NAME="$(echo $p | cut -d' ' -f1)"
    generate_secret="$(echo $p | cut -d' ' -f2)"
    if [ ! -f "$DIR/../site/$site/secrets/passphrases/${PP_NAME}.yaml" ] ||
       [ -n "$user_specified_site" ]; then
      pass=$(openssl rand -hex 10)
      secrets_file="$DIR/../site/$site/secrets/passphrases/${PP_NAME}.yaml"
      if [ "$generate_secret" = 'do_not_generate' ]; then
        echo "Enter the '$PP_NAME' password for site $site:"
        read USER_SUPPLIED_PASSWD
        export PP_VALUE=$USER_SUPPLIED_PASSWD
        envsubst < passphrase.sub > "$secrets_file"
      elif  [ "$generate_secret" = 'linux-crypt-sha-512' ]; then
        # Generate linux crypt passwd for /etc/shadow
        export PP_VALUE="$(python3 -c "from crypt import *; print(crypt('$pass', METHOD_SHA512))" | tail -1)"
        envsubst < passphrase.sub > "$secrets_file"
        sed -i "10i# Pass: $pass" "$secrets_file"
      else
        export PP_VALUE=$pass
        envsubst < passphrase.sub > "$secrets_file"
      fi
    fi
  done
done
