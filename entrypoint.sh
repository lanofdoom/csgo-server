#!/bin/bash -ue

if [ ! -e /opt/game/srcds_run ]
then
    tar -xf csgo.tar.xz
    tar -xf configuration.tar.gz
fi

[ -z "${CSGO_ADMIN}" ] || echo "${CSGO_ADMIN} \"99:z\"" > /opt/game/csgo/addons/sourcemod/configs/admins_simple.ini

[ -z "${CSGO_MOTD}" ] || echo "${CSGO_MOTD}" > /opt/game/csgo/motd.txt

# Call srcds_linux instead of srcds_run to avoid restart logic
LD_LIBRARY_PATH="/opt/game:/opt/game/bin:${LD_LIBRARY_PATH:-}" /opt/game/srcds_linux \
    -game csgo \
    -tickrate "$CSGO_TICKRATE" \
    -port "$CSGO_PORT" \
    -strictbindport \
    -console \
    -usercon \
    -authkey "$STEAM_API_KEY" \
    +ip 0.0.0.0 \
    +host_workshop_collection "$CSGO_MAP_COLLECTION" \
    +hostname "$CSGO_HOSTNAME" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$CSGO_PASSWORD" \
    +sv_setsteamaccount "$STEAM_SERVER_ACCOUNT" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"
