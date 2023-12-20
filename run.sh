#!/bin/bash

nohup /usr/local/bin/docker-entrypoint.sh postgres & sleep 5

cd /app/packages/database
pnpm run db:push

cd /app/apps/fetcher
pnpm run start

cd /app/apps/frontend
pnpm run start
