#!/bin/bash

# Use it like this:
#   /path/to/this/script  EMACS_USER_DIRECTORY  [OTHER EMACS ARGS]

# You can never be too careful
set -e

# First arg = emacs user directory
#   (get a canonical, absolute path)
EMACS_USER_DIRECTORY=$(readlink -f "$1")
shift
if [ ! -d "${EMACS_USER_DIRECTORY}" ]; then
    echo "Non-existent directory: '${EMACS_USER_DIRECTORY}'"
    exit 1
fi

# Bootstrap directory
BOOTSTRAP=$(mktemp --directory --tmpdir .emacs-bootstrap.XXXXXX)
mkdir "${BOOTSTRAP}/.emacs.d"

# Bootstrap init file
cat >"${BOOTSTRAP}/.emacs.d/init.el" <<EOF
  ;; # Correctly set-up emacs-user-directory
  (setq user-emacs-directory "${EMACS_USER_DIRECTORY}/")
  (setq user-init-file (concat user-emacs-directory "init.el"))

  ;; # Reset the HOME environment variable
  (setenv "HOME" "${HOME}")

  ;; # Load the real init file and clean-up afterwards
  (unwind-protect (load user-init-file)
    (delete-directory "${BOOTSTRAP}" :recursive))
EOF

# Forward remaining arguments to emacs
exec env HOME="${BOOTSTRAP}" emacs "$@"
