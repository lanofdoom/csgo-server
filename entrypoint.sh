#!/bin/bash -ue

[ -z "${CSGO_MOTD}" ] || echo "${CSGO_MOTD}" > /opt/game/csgo/motd.txt

# Generate mapcycle here to cut down on image build time and space usage.
TMP_MAPCYCLE=$(mktemp)
ls /opt/game/csgo/maps/*.bsp | grep -v -e training1 -e lobby_mapveto -e gd_ | sed -e 's/.*\/\([^\/]*\).bsp/\1/' > $TMP_MAPCYCLE
echo "aim_deagle7k" >> $TMP_MAPCYCLE
echo "fy_iceworld" >> $TMP_MAPCYCLE
echo "fy_pool_day" >> $TMP_MAPCYCLE
echo "scoutzknivez" >> $TMP_MAPCYCLE
sort $TMP_MAPCYCLE > /opt/game/csgo/mapcycle.txt

# Touch this file to workaround an issue in sourcemod
touch /opt/game/csgo/addons/sourcemod/configs/maplists.cfg

# Touch these files to prevent sourcemod from creating them and overriding
# values sent in server.cfg
touch /opt/game/csgo/cfg/sourcemod/mapchooser.cfg
touch /opt/game/csgo/cfg/sourcemod/rtv.cfg

# Call srcds_linux instead of srcds_run to avoid restart logic
LD_LIBRARY_PATH="/opt/game:/opt/game/bin:${LD_LIBRARY_PATH:-}" /opt/game/srcds_linux \
    -game csgo \
    -tickrate 128 \
    -port "$CSGO_PORT" \
    -strictbindport \
    -console \
    -usercon \
    -authkey "$STEAM_API_KEY" \
    +ip 0.0.0.0 \
    +hostname "$CSGO_HOSTNAME" \
    +map "$CSGO_MAP" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$CSGO_PASSWORD" \
    +sv_setsteamaccount "$STEAM_SERVER_ACCOUNT" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"