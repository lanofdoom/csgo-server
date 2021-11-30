load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")

#
# Build plugin layer
#

container_layer(
    name = "customvotes_config",
    directory = "/opt/game/csgo/addons/sourcemod/configs",
    files = [
        "customvotes.cfg",
    ],
)

container_layer(
    name = "customvotes_plugin",
    directory = "/opt/game/csgo/addons/sourcemod/plugins/",
    files = [
        "@customvotes_nativevotes//file",
    ],
)

container_layer(
    name = "customvotes_phrases",
    directory = "/opt/game/csgo/addons/sourcemod/translations/",
    files = [
        "@customvotes_phrases//file",
    ],
)

container_image(
    name = "plugin_image",
    base = "@ubuntu//image",
    directory = "/opt/game/csgo",
    layers = [
        ":customvotes_config",
        ":customvotes_plugin",
        ":customvotes_phrases",
    ],
    tars = [
        "@auth_by_steam_group//file",
        "@metamod//file",
        "@sourcemod//file",
    ],
)

container_run_and_extract(
    name = "plugins",
    commands = [
        "cd /opt/game/csgo/addons/sourcemod/plugins",
        "mv basevotes.smx disabled/basevotes.smx",
        "mv funcommands.smx disabled/funcommands.smx",
        "mv funvotes.smx disabled/funvotes.smx",
        "mv playercommands.smx disabled/playercommands.smx",
        "mv disabled/mapchooser.smx mapchooser.smx",
        "mv disabled/rockthevote.smx rockthevote.smx",
        "mv disabled/nominations.smx nominations.smx",
        "chown -R nobody:root /opt",
        "tar -cf /archive.tar /opt",
    ],
    extract_file = "/archive.tar",
    image = ":plugin_image.tar",
)

container_layer(
    name = "plugin_layer",
    tars = [
        ":plugins/archive.tar",
    ],
)

#
# Build configuration layer
#

container_layer(
    name = "root_config",
    directory = "/opt/game/csgo",
    files = [
        ":GameModes_Server.txt",
        ":subscribed_file_ids.txt",
    ],
)

container_layer(
    name = "cfg_config",
    directory = "/opt/game/csgo/cfg",
    files = [
        ":cfg/gamemode_armsrace_server.cfg",
        ":cfg/gamemode_casual_server.cfg",
        ":cfg/gamemode_demolition_server.cfg",
        ":cfg/server.cfg",
        ":cfg/start_armsrace.cfg",
        ":cfg/start_casual.cfg",
        ":cfg/start_casual_custom.cfg",
        ":cfg/start_casual_small.cfg",
        ":cfg/start_demolition.cfg",
        ":cfg/start_flyingscoutsman.cfg",
    ],
)

container_image(
    name = "configuration_image",
    base = "@ubuntu//image",
    layers = [
        ":cfg_config",
        ":root_config",
    ],
)

container_run_and_extract(
    name = "configuration",
    commands = [
        "chown -R nobody:root /opt",
        "tar --mtime=1970-01-01 --sort=name -czf /configuration.tar.gz opt",
    ],
    extract_file = "/configuration.tar.gz",
    image = ":configuration_image.tar",
)

#
# Build Final Image and Push
#

container_image(
    name = "server_image",
    base = "@server_base//image",
    entrypoint = ["/entrypoint.sh"],
    env = {
        "CSGO_ADMIN": "",
        "CSGO_HOSTNAME": "",
        "CSGO_MOTD": "",
        "CSGO_PASSWORD": "",
        "CSGO_PORT": "27015",
        "CSGO_TICKRATE": "128",
        "RCON_PASSWORD": "",
        "STEAM_API_KEY": "",
        "STEAM_GROUP_ID": "",
        "STEAM_SERVER_ACCOUNT": "",
        "SV_LAN": "0",
        "TZ": "America/Chicago",
    },
    files = [
        ":configuration/configuration.tar.gz",
        ":entrypoint.sh",
    ],
    layers = [":plugin_layer"],
    user = "nobody",
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/csgo-server/csgo-server",
    tag = "latest",
)
