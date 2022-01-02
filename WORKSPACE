load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59536e6ae64359b716ba9c46c39183403b01eabfbd57578e84398b4829ca499a",
    strip_prefix = "rules_docker-0.22.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.22.0/rules_docker-v0.22.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

#
# Container Base Image
#

container_pull(
    name = "container_base",
    registry = "index.docker.io",
    repository = "library/debian",
    tag = "bullseye",
)

#
# Server Dependencies
#

http_file(
    name = "auth_by_steam_group",
    downloaded_file_path = "auth_by_steam_group.tar.gz",
    sha256 = "563b4f508373494ab3b26acccc9c9fcbd11b168ed85b7ee7447a5603627350a9",
    urls = ["https://lanofdoom.github.io/auth-by-steam-group/releases/v2.1.2/auth_by_steam_group.tar.gz"],
)

http_file(
    name = "sourcemod",
    downloaded_file_path = "sourcemod.tar.gz",
    urls = ["https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6502-linux.tar.gz"],
)

http_file(
    name = "metamod",
    downloaded_file_path = "metamod.tar.gz",
    sha256 = "2794c0e747b5e751a4335c8be8dce2e87907a1a3aa5313505ae7944c51630884",
    urls = ["https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1143-linux.tar.gz"],
)
