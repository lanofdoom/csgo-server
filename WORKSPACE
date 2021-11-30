load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

git_repository(
    name = "io_bazel_rules_docker",
    commit = "2b35b2dd56f0be6cc6b8df957332a31435f6b3ce",
    remote = "https://github.com/bazelbuild/rules_docker.git",
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

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

container_pull(
    name = "server_base",
    registry = "ghcr.io",
    repository = "lanofdoom/csgo-base/csgo-base",
    tag = "latest",
    timeout = 10000,
)

container_pull(
    name = "ubuntu",
    registry = "index.docker.io",
    repository = "library/ubuntu",
    tag = "focal",
)