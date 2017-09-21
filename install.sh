#!/bin/bash

echo "gdyazo installer"
echo "1) Please get your credentials from Google."
echo "Visit here: https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md"
eval open https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md

echo "client_id (for user default, enter)"
read clientId
echo "client_secret (for use default, enter)"
read clientSecret

if [ "${clientId}" = "" ] && [ "${clientSecret}" = "" ]; then
  echo "for use default "
else
  cat << EOT > ~/.config/gdyazo/config.json
{
  "client_id": "$clientId",
  "client_secret": "$clientSecret"
}
EOT
fi

echo "2) Please get API key from Google"
eval docker-compose -f docker-compose.init.yml run gdyazo-init

echo "3) Running the container..."
eval docker-compose up -d
