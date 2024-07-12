#!/bin/bash -ec

password_aux="${MARIADB_ROOT_PASSWORD:-}"
if [[ -f "${MARIADB_ROOT_PASSWORD_FILE:-}" ]]; then
    password_aux=$(cat "$MARIADB_ROOT_PASSWORD_FILE")
fi
mysqladmin status -uroot -p"${password_aux}"