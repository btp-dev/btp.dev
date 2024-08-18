FROM docker.io/rust:1-slim-bookworm AS build

ARG env=debug

WORKDIR /build

COPY . .

RUN --mount=type=cache,target=/build/target \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/local/cargo/git \
    set -exu; \
    cargo build; \
    objcopy target/debug/btp-dev ./main

FROM docker.io/debian:bookworm-slim

WORKDIR /app

COPY --from=build /build/main ./
COPY --from=build /build/stati[c] ./static
COPY --from=build /build/Rocket.tom[l] ./static/
COPY --from=build /build/template[s] ./templates

CMD ./main
