# # FROM node:18-alpine AS base
# # FROM base AS builder
# # # Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
# # RUN apk add --no-cache libc6-compat
# # RUN apk update
# # # Set working directory
# # WORKDIR /app
# # RUN yarn global add turbo
# # COPY . .
# # RUN turbo prune @votewatch/data-fetcher --docker

# # # Add lockfile and package.json's of isolated subworkspace
# # FROM base AS installer
# # RUN apk add --no-cache libc6-compat
# # RUN apk update
# # WORKDIR /app

# # # First install dependencies (as they change less often)
# # COPY .gitignore .gitignore
# # COPY --from=builder /app/out/json/ .
# # COPY --from=builder /app/out/yarn.lock ./yarn.lock
# # RUN yarn install

# # # Build the project and its dependencies
# # COPY --from=builder /app/out/full/ .
# # COPY turbo.json turbo.json

# # # Uncomment and use build args to enable remote caching
# # # ARG TURBO_TEAM
# # # ENV TURBO_TEAM=$TURBO_TEAM

# # # ARG TURBO_TOKEN
# # # ENV TURBO_TOKEN=$TURBO_TOKEN

# # RUN yarn turbo build --filter=fetcher...

# # FROM base AS runner
# # WORKDIR /app

# # # Don't run production as root
# # RUN addgroup --system --gid 1001 nodejs
# # RUN adduser --system --uid 1001 nodejs
# # USER nodejs
# # COPY --from=installer /app .

# # CMD node apps/fetcher/dist/index.js



# # Base image with Node.js
# ARG NODE_VERSION=18.18.0
# # Use a specific version of the Node.js Alpine image as the base. Alpine images are minimal and lightweight.
# FROM node:${NODE_VERSION}-alpine AS base
# # Update the package list and install libc6-compat. This package is often required for binary Node.js modules.
# RUN apk update && apk add --no-cache libc6-compat

# # Setup pnpm and turbo
# # Start a new stage based on the base image for setting up pnpm (a package manager) and turbo (for monorepo management).
# FROM base as setup
# # Install pnpm and turbo globally using npm.
# RUN npm install -g pnpm turbo
# # Configure pnpm to use a specific directory for storing its package cache.
# RUN pnpm config set store-dir ~/.pnpm-store

# # Build argument for specifying the project
# # Introduce a build argument 'PROJECT' to specify which project in the monorepo to build.
# ARG PROJECT=fetcher

# # Install all dependencies in the monorepo
# # Start a new stage for handling dependencies. This stage uses the previously setup image with pnpm and turbo installed.
# FROM setup AS dependencies
# WORKDIR /app
# # Copy the essential configuration files and the specific project's files into the Docker image.
# COPY packages/ ./packages/
# COPY turbo.json ./
# COPY package.json turbo.json packages ./
# COPY apps/${PROJECT} ./apps/${PROJECT}
# COPY pnpm-lock.yaml pnpm-workspace.yaml ./
# # Install dependencies as per the lockfile to ensure consistent dependency resolution.
# RUN pnpm install --frozen-lockfile

# # Prune projects to focus on the specified project scope
# # Start a new stage to prune the monorepo, focusing only on the necessary parts for the specified project.
# FROM dependencies AS pruner
# RUN turbo prune --scope=@votewatch/data-fetcher --docker
# # Remove all empty node_modules folders. This is a cleanup step to remove unnecessary directories and reduce image size.
# RUN rm -rf /app/out/full/*/*/node_modules

# # Build the project using turbo
# # Start a new stage for building the project. This stage will compile and prepare the project for production.
# FROM pruner AS builder
# WORKDIR /app

# # Copy pruned lockfile and package.json files
# # This ensures that the builder stage has the exact dependencies needed for the project.
# COPY --from=pruner /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
# COPY --from=pruner /app/out/pnpm-workspace.yaml ./pnpm-workspace.yaml
# COPY --from=pruner /app/out/json/ .

# # Install dependencies for the pruned project
# # Utilize BuildKit's cache to speed up the dependency installation process.
# RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm install --frozen-lockfile

# # Copy pruned source code
# # Bring in the necessary source code to the builder stage for compilation.
# COPY --from=pruner /app/out/full/ .

# # Build with turbo and prune dev dependencies
# # Use turbo to build the project, followed by pruning development dependencies to minimize the final image size.
# RUN turbo build --filter=${PROJECT}...
# RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm prune --prod --no-optional
# # Remove source files to further reduce the image size, keeping only the compiled output and necessary runtime files.
# RUN rm -rf ./**/*/src

# # Final production image
# # Start the final stage for the production-ready image.
# FROM base AS runner
# # Create a non-root user and group for better security.
# RUN addgroup --system --gid 1001 nodejs
# RUN adduser --system --uid 1001 nodejs
# # Switch to the non-root user.
# USER nodejs

# WORKDIR /app
# # Copy the entire app directory, including node_modules and built code. This includes all necessary runtime files.
# COPY --from=builder --chown=nodejs:nodejs /app .

# WORKDIR /app/apps/${PROJECT}
# # Specify the command to run the application. Adjust the path as needed for your project's start script.
# CMD ["npm", "run", "start"]




ARG NODE_VERSION=18.18.0

# Alpine image
FROM node:${NODE_VERSION}-alpine AS alpine
RUN apk update
RUN apk add --no-cache libc6-compat

# Setup pnpm and turbo on the alpine base
FROM alpine as base
RUN npm install pnpm turbo --global
RUN pnpm config set store-dir ~/.pnpm-store

# Prune projects
FROM base AS pruner

WORKDIR /app
COPY . .
RUN turbo prune --scope=@votewatch/data-fetcher --docker

# Build the project
FROM base AS builder

WORKDIR /app

# Copy lockfile and package.json's of isolated subworkspace
COPY --from=pruner /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=pruner /app/out/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=pruner /app/out/json/ .

# First install the dependencies (as they change less often)
RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm install --frozen-lockfile

# Copy source code of isolated subworkspace
COPY --from=pruner /app/out/full/ .

RUN turbo build --filter=@votewatch/data-fetcher
RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm prune --prod --no-optional
#RUN rm -rf ./**/*/src

# Final image
FROM alpine AS runner

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs
USER nodejs

WORKDIR /app
COPY --from=builder --chown=nodejs:nodejs /app .
WORKDIR /app/apps/fetcher

ARG PORT=8080
ENV PORT=${PORT}
ENV NODE_ENV=production
EXPOSE ${PORT}

CMD npm run start
#CMD ["node", "index.ts"]


