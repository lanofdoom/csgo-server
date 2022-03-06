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
# MetaMod Layer
#

container_layer(
    name = "metamod",
    directory = "/opt/game/cstrike",
    tars = [
        "@metamod//file",
    ],
)

#
# SourceMod Layer
#

container_layer(
    name = "sourcemod",
    directory = "/opt/game/cstrike",
    tars = [
        "@sourcemod//file",
    ],
)

#
# Authorization Layer
#

container_layer(
    name = "authorization",
    directory = "/opt/game/cstrike",
    tars = [
        "@auth_by_steam_group//file",
    ],
)

#
# Build configuration layer
#

container_layer(
    name = "configuration",
    directory = "/opt/game/csgo/cfg",
    files = [
        ":cfg/gamemode_armsrace_server.cfg",
        ":cfg/gamemode_casual_server.cfg",
        ":cfg/gamemode_demolition_server.cfg",
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
        "CSGO_MAP_COLLECTION": "2704056164",
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
        ":metamod",
        ":sourcemod",
        ":authorization",
        ":configuration",
    ],
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/csgo-server",
    tag = "latest",
)
