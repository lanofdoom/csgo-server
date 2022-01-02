# LAN of DOOM Counter-Strike: Global Offensive Server
Docker image for a private, preconfigured private Counter-Strike: Global
Offensive server as used by the LAN of DOOM.

# Installation
Run ``docker pull ghcr.io/lanofdoom/csgo-server:latest``

# Environmental Variables
``CSGO_HOSTNAME`` The name of the server as listed in Valve's server browser.

``CSGO_PASSWORD`` The password users must enter in order to join the server.

``CSGO_MAP_COLLECTION`` The workshop map collection to host on the server.
``2704056164`` by default.

``CSGO_MOTD`` The MOTD to use for the server. Should be a URL to use for the
server website link displayed in-game.

``CSGO_PORT`` The port to use for the server. ``27015`` by default.

``CSGO_TICKRATE`` The tickrate to use for the server. ``128`` by default.

``RCON_PASSWORD`` The rcon password for the server.

``STEAM_GROUP_ID`` The Steam group to use for the allowlist of users joining the
server.

``STEAM_API_KEY`` The [Steam API key](https://steamcommunity.com/dev/apikey) to
use for the group membership checks with the Steam's Web API.

``STEAM_SERVER_ACCOUNT`` The
[Steam server account](https://steamcommunity.com/dev/managegameservers) to
associate with the server.

# Note
The server binaries inside the image are packaged inside a compressed archive
that is unpacked the first time the image is run. This means that it will take
around 30 minutes after the first run of the image before the server is usable.
