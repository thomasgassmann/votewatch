#!/bin/bash

nohup /usr/local/bin/docker-entrypoint.sh postgres & sleep 5

cd /app/apps/frontend
pnpm run start
