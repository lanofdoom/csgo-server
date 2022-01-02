load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit", "container_run_and_commit_layer", "container_run_and_extract")

#
# Build Server Base Image
#

container_run_and_extract(
    name = "enable_i386_sources",
    commands = [
        "dpkg --add-architecture i386",
    ],
    extract_file = "/var/lib/dpkg/arch",
    image = "@container_base//image",
)

container_image(
    name = "container_base_with_i386_packages",
    base = "@container_base//image",
    directory = "/var/lib/dpkg",
    files = [
        ":enable_i386_sources/var/lib/dpkg/arch",
    ],
)

download_pkgs(
    name = "server_deps",
    image_tar = ":container_base_with_i386_packages.tar",
    packages = [
        "ca-certificates:i386",
        "lib32gcc-s1",
        "libcurl4:i386",
        "libstdc++6:i386", # Unique dependency for CS:GO Metamod
    ],
)

install_pkgs(
    name = "server_base",
    image_tar = ":container_base_with_i386_packages.tar",
    installables_tar = ":server_deps.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "server_base",
)

#
# Build Counter-Strike: Source Layer
#

container_run_and_commit(
    name = "prepare_steamcmd_repo",
    commands = [
        "sed -i -e's/ main/ main non-free/g' /etc/apt/sources.list",
        "echo steam steam/question select 'I AGREE' | debconf-set-selections",
        "echo steam steam/license note '' | debconf-set-selections",
    ],
    image = ":server_base.tar",
)

download_pkgs(
    name = "steamcmd_deps",
    image_tar = ":prepare_steamcmd_repo_commit.tar",
    packages = [
        "steamcmd:i386",
        "xz-utils",
    ],
)

install_pkgs(
    name = "steamcmd_base",
    image_tar = ":prepare_steamcmd_repo_commit.tar",
    installables_tar = ":steamcmd_deps.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "steamcmd_base",
)

container_run_and_extract(
    name = "download_counter_strike_global_offensive",
    commands = [
        "/usr/games/steamcmd +login anonymous +force_install_dir /opt/game +app_update 740 validate +quit",
        "rm -rf /opt/game/steamapps",
        "chown -R nobody:root /opt/game",
        "tar --remove-files --use-compress-program='xz -9T0' --mtime='1970-01-01' -cvf /csgo.tar.xz opt/game/",
    ],
    extract_file = "/csgo.tar.xz",
    image = ":steamcmd_base.tar",
)

container_layer(
    name = "counter_strike_global_offensive",
    files = [
        ":download_counter_strike_global_offensive/csgo.tar.xz",
    ],
)

#
# Set permissions in /opt
#

container_run_and_commit_layer(
    name = "permissions_layer",
    commands = [
        "mkdir /opt/game",
        "chown -R nobody:root /opt",
    ],
    image = "@container_base//image",
)

#
# Build plugin layer
#

container_image(
    name = "plugin_image",
    base = "@container_base//image",
    directory = "/opt/game/csgo",
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
        "mv nextmap.smx disabled/nextmap.smx",
        "mv playercommands.smx disabled/playercommands.smx",
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
    name = "cfg_config",
    directory = "/opt/game/csgo/cfg",
    files = [
        ":cfg/gamemode_armsrace_server.cfg",
        ":cfg/gamemode_casual_server.cfg",
        ":cfg/gamemode_demolition_server.cfg",
        ":cfg/server.cfg",
    ],
)

container_image(
    name = "configuration_image",
    base = "@container_base//image",
    layers = [
        ":cfg_config",
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
    base = ":server_base",
    entrypoint = ["/entrypoint.sh"],
    env = {
        "CSGO_ADMIN": "",
        "CSGO_HOSTNAME": "",
        "CSGO_MAP_COLLECTION": "2704056164",
        "CSGO_MOTD": "",
        "CSGO_PASSWORD": "",
        "CSGO_PORT": "27015",
        "CSGO_TICKRATE": "128",
        "RCON_PASSWORD": "",
        "STEAM_API_KEY": "",
        "STEAM_GROUP_ID": "",
        "STEAM_SERVER_ACCOUNT": "",
    },
    files = [
        ":configuration/configuration.tar.gz",
        ":entrypoint.sh",
    ],
    layers = [
        ":permissions_layer",
        ":counter_strike_global_offensive",
        ":plugin_layer",
    ],
    user = "nobody",
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/csgo-server",
    tag = "latest",
)
