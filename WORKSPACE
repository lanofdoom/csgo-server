load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

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
    sha256 = "b01386378d9a1e4507e7f6e5ee8cfaf78f98d51c842181ba59aef63bac31d699",
    urls = ["https://lanofdoom.github.io/auth-by-steam-group/releases/v2.1.0/auth_by_steam_group.tar.gz"],
)

http_file(
    name = "customvotes_nativevotes",
    downloaded_file_path = "customvotes-nativevotes.smx",
    sha256 = "500d4c441359cdd84cda3630d120c5679ec81753e15a411ba45ed0b96b17ffbb",
    urls = ["https://forums.alliedmods.net/attachment.php?attachmentid=146725&d=1437545320"],
)

http_file(
    name = "customvotes_phrases",
    downloaded_file_path = "customvotes.phrases.txt",
    sha256 = "8069fbe453319167c9c4e76d27320f05c148c1861e9fda4e89168e832a52a84d",
    urls = ["https://forums.alliedmods.net/attachment.php?attachmentid=130686&d=1393706892"],
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
