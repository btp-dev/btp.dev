FROM caddy:builder as builder

WORKDIR /

RUN xcaddy build \
--with github.com/baddy-dns/namecheap

FROM caddy

COPY --from=builder /caddy /usr/bin/caddy
