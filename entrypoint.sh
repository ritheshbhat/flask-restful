#!/bin/sh

PYENV="${1:-/opt/venv/bin}"
SERVER_PORT="${SERVER_PORT:-9095}"

. $PYENV/activate
exec gunicorn --bind="0.0.0.0:$SERVER_PORT" --workers=2 --threads=4 --worker-class=gthread --worker-tmp-dir=/dev/shm wisecoder.main:app
