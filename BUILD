load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@com_github_lanofdoom_steamcmd//:defs.bzl", "steam_depot_layer")

#
# Counter-Strike: Global Offensive Layer
#

steam_depot_layer(
    name = "counter_strike_global_offensive",
    app = "740",
    directory = "/opt/game",
)

#
# Maps Layer
#

container_layer(
    name = "maps",
    directory = "/opt/game/csgo",
    tars = [
        "@maps//file",
        "@maps_bz2//file",
    ],
)

#
# MetaMod Layer
#

container_layer(
    name = "metamod",
    directory = "/opt/game/csgo",
    tars = [
        "@metamod//file",
    ],
)

#
# SourceMod Layer
#

container_layer(
    name = "sourcemod",
    directory = "/opt/game/csgo",
    tars = [
        "@sourcemod//file",
    ],
)

#
# Authorization Layer
#

container_layer(
    name = "authorization",
    directory = "/opt/game/csgo",
    tars = [
        "@auth_by_steam_group//file",
    ],
)

#
# Plugins Layers
#

container_layer(
    name = "plugins",
    directory = "/opt/game/csgo",
    tars = [
        "@map_settings//file",
    ],
)

#
# Workshop Layer
#

container_layer(
    name = "workshop",
    directory = "/opt/game/csgo",
    files = [
        ":subscribed_file_ids.txt",
    ],
)

#
# Game Mode Config Layer
#

container_layer(
    name = "gamemode_configs",
    directory = "/opt/game/csgo/cfg",
    files = [
        ":cfg/gamemode_armsrace_server.cfg",
        ":cfg/gamemode_casual_server.cfg",
        ":cfg/gamemode_cooperative_server.cfg",
        ":cfg/gamemode_demolition_server.cfg",
        ":cfg/gamemode_survival_server.cfg",
    ],
)

#
# Server Config Layer
#

container_layer(
    name = "server_config",
    directory = "/opt/game/csgo/cfg/templates",
    files = [
        ":cfg/server.cfg",
    ],
)

#
# Base Image
#

download_pkgs(
    name = "server_deps",
    image_tar = "@base_image//image",
    packages = [
        "ca-certificates",
        "libcurl4",
    ],
)

install_pkgs(
    name = "server_base",
    image_tar = "@base_image//image",
    installables_tar = ":server_deps.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "server_base",
)

#
# Final Image
#

container_image(
    name = "server_image",
    base = ":server_base",
    entrypoint = ["/entrypoint.sh"],
    env = {
        "CSGO_ADMIN": "",
        "CSGO_HOSTNAME": "",
        "CSGO_MAP": "de_dust2",
        "CSGO_MOTD": "",
        "CSGO_PASSWORD": "",
        "CSGO_PORT": "27015",
        "RCON_PASSWORD": "",
        "STEAM_API_KEY": "",
        "STEAM_GROUP_ID": "",
        "STEAM_SERVER_ACCOUNT": "",
    },
    files = [
        ":entrypoint.sh",
    ],
    layers = [
        ":counter_strike_global_offensive",
        ":maps",
        ":metamod",
        ":sourcemod",
        ":authorization",
        ":plugins",
        ":workshop",
        ":gamemode_configs",
        ":server_config",
    ],
    symlinks = {
        "/root/.steam/sdk32/steamclient.so": "/opt/game/bin/steamclient.so"
    },
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/csgo-server",
    tag = "latest",
)
