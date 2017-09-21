# gdyazo

Take and share screenshots with Google Drive.

### Instalattion using Docker Compose
```shell
git clone https://github.com/atpons/gdyazo
cd gdyazo
sh install.sh
```
`install.sh` is the installation script for your macOS to setup the following steps:
1. Create `~/.config/gdyazo/config.json`
2. Ask your `client_id` and `client_secret`
3. Run `gdyazo-init` container and get credentials with the prompt.
4. Run `gdyazo-app` container and this container runs when it turns on your machine.

### Usage
`ruby client.rb` and take a screenshot and auto-upload to your Google Drive.

### Requirements
* Docker for Mac
* macOS (checked on v 10.12 Sierra)

### LICENSE
GPL
