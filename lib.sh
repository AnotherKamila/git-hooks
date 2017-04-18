# Utility functions for Kamila's Git hooks (https://github.com/anotherkamila/git-hooks).

set -e  # fail on error

clone_to_tmp() {
  GIT_REPO="$(readlink -f "$GIT_DIR")"
  REPO_NAME="$(basename "$GIT_REPO")"
  TMP_GIT_CLONE="/tmp/builddir-$REPO_NAME"

  [ -d "$TMP_GIT_CLONE" ] || git clone "$GIT_REPO" "$TMP_GIT_CLONE" >&2
  cd "$TMP_GIT_CLONE"
  GIT_DIR=".git" git pull --recurse-submodules >&2  # update in case it is stale -- from a previous clone
  echo "$TMP_GIT_CLONE"
}
