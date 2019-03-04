# Stage 1 - Download Latest binary
##################################
FROM alpine:latest AS builder

# Download and extract Caddy binary
RUN apk add --update --no-cache wget
RUN wget "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" -O caddy.tar.gz
RUN tar -xvf caddy.tar.gz


# Stage 2 - Image
#################
FROM scratch

# Copy binary from previous stage
COPY --from=builder /caddy /caddy

# Volume for files
VOLUME /data

# Port to serve from
EXPOSE 8000

# Caddy Entrypoint
ENTRYPOINT ["/caddy", "-host", "0.0.0.0", "-port", "8000"]

# Default options
CMD ["-root", "/data"]
