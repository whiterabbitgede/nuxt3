FROM node:20-alpine  AS build

#ENV http_proxy=http://10.190.21.24:3128
#ENV https_proxy=http://10.190.21.24:3128
#ENV no_proxy=localhost,127.0.0.1,.example.com
#ENV HTTP_PROXY=http://10.190.21.24:3128
#ENV HTTPS_PROXY=http://10.190.21.24:3128
#ENV NO_PROXY=localhost,127.0.0.1,.example.com

WORKDIR /app

#COPY ./.app ./.app
#COPY ./layers ./layers
#COPY ./patches ./patches
COPY package.json .
COPY package-lock.json .
# COPY pnpm-lock.yaml .
#COPY pnpm-workspace.yaml .
COPY tsconfig.json .
# COPY .app/.env.example .env
# COPY package.json .
# COPY package-lock.json .
# COPY package-lock.json .
# COPY pnpm-lock.yaml .

RUN npm install

# RUN npm install -g pnpm
# RUN pnpm install
# RUN pnpm install --frozen-lockfile


# build as mjs (run with node)
RUN npm run build
# RUN pnpm run build

# build as static
# RUN pnpm run generate



FROM node:20-alpine AS runner

WORKDIR /app
RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot
USER nonroot
# copy build as mjs file
COPY --from=build /app/.output ./


EXPOSE 3000
CMD ["node", "server/index.mjs"] 


# docker build -t nuxt3:dev-v0.0.1 .



