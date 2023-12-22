FROM postgres:alpine

WORKDIR /app
COPY package.json .
COPY pnpm-lock.yaml .
COPY pnpm-workspace.yaml .
COPY .eslintrc.js .
COPY turbo.json .

ENV NVM_DIR=/usr/local/nvm

RUN apk add curl nodejs npm
RUN npm config delete prefix
RUN npm config set prefix $NVM_DIR/versions/node/v20.10.0
RUN mkdir -p $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
RUN . $NVM_DIR/nvm.sh && nvm install 20.10.0 && nvm use 20.10.0

RUN npm install -g pnpm
COPY apps apps
COPY packages packages

RUN . $NVM_DIR/nvm.sh && pnpm install

ENV POSTGRES_DB=db
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_ROOT_PASSWORD=password
ENV DATABASE_URL="postgres://admin:password@localhost:5432/db?pgbouncer=true&connect_timeout=15"

WORKDIR /app/packages/database
RUN . $NVM_DIR/nvm.sh && pnpm run db:generate

WORKDIR /app/apps/frontend
RUN . $NVM_DIR/nvm.sh && pnpm run build

COPY db_dump.sql /docker-entrypoint-initdb.d/db_dump.sql

WORKDIR /app

COPY run.sh .
RUN chmod +x run.sh
CMD ["./run.sh"]
EXPOSE 5173
