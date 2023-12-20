FROM postgres:alpine

WORKDIR /app
COPY package.json .
COPY pnpm-lock.yaml .
COPY pnpm-workspace.yaml .
COPY .eslintrc.js .
COPY turbo.json .

RUN apk add nodejs npm
RUN npm install -g pnpm
COPY apps apps
COPY packages packages

RUN pnpm install

ENV POSTGRES_DB=db
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_ROOT_PASSWORD=password
ENV DATABASE_URL="postgres://admin:password@localhost:5432/db"

WORKDIR /app/packages/database
RUN pnpm run db:generate

WORKDIR /app/apps/frontend
RUN pnpm run build

WORKDIR /app

COPY run.sh .
RUN chmod +x run.sh
CMD ["./run.sh"]
EXPOSE 5173
