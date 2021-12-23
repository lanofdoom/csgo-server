#!/bin/bash -ue

if [ ! -e /opt/game/srcds_run ]
then
    tar -xf csgo.tar.xz
    tar -xf configuration.tar.gz
fi

[ -z "${CSGO_ADMIN}" ] || echo "${CSGO_ADMIN} \"99:z\"" > /opt/game/csgo/addons/sourcemod/configs/admins_simple.ini

[ -z "${CSGO_MOTD}" ] || echo "${CSGO_MOTD}" > /opt/game/csgo/motd.txt

/opt/game/srcds_run \
    -game csgo \
    -tickrate "$CSGO_TICKRATE" \
    -port "$CSGO_PORT" \
    -strictbindport \
    -console \
    -usercon \
    -authkey "$STEAM_API_KEY" \
    +exec start_armsrace \
    +ip 0.0.0.0 \
    +map ar_baggage \
    +hostname "$CSGO_HOSTNAME" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$CSGO_PASSWORD" \
    +sv_setsteamaccount "$STEAM_SERVER_ACCOUNT" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"