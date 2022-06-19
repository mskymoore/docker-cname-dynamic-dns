FROM alpine:latest
RUN apk update && apk add bash wget bind-tools
COPY no-ip.sh /no-ip.sh
CMD /bin/bash /no-ip.sh