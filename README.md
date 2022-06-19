Docker Dynamic DNS Client
=====

Docker Hub: https://hub.docker.com/r/skymoore/docker-cname-dynamic-dns/

GitHub: https://github.com/mskymoore/docker-cname-dynamic-dns

Dynamic DNS services have been around since the early days of the internet. Generally speaking, internet service providers (ISP's) will reassign an IP address to a subscriber after some period of time or if the user reconnects his or her connection. Traditional DNS services, however, relied on IP addresses staying the same. DynDNS developed an HTTP-based protocol for updating DNS records on Dynamic DNS services that has been copied for a number of platforms.  One of the real advantages of Dynamic DNS nowadays is that HTTPS can now be bound to a domain name instead of an IP. Likewise, a domain name (ie. subdomain.example.com) can be bound to a dynamic DNS name in a DNS record via a CNAME. So even if one is using a Dynamic DNS, traffic can still be secured using HTTPS. However, one cannot apply a CNAME record to the root of a domain.  To solve the case where I needed a CNAME for an amazon elb dns name attached to the root of my domain, without migrating the domain into aws, I've added the CNAME option, which will dig a name and use the first record to update the dynamic dns.

To build the Docker image, simply run Docker build

```
docker build --no-cache --tag docker-cname-dynamic-dns .
```

Or you can pull it:

```
docker pull skymoore/docker-cname-dynamic-dns
```

To use the image, use Docker run.

```
docker run -it --rm --name no-ip1 -e USER=username -e PASSWORD=yourpassword -e SERVICE=duckdns -e HOSTNAME=example.com -e DETECTIP=1 -e CNAME=some.url.com -e INTERVAL=1 skymoore/docker-cname-dynamic-dns
```

The environment variables are as follows:

* **USER**: the username for the service.

* **PASSWORD**: the password or token for the service.

* **HOSTNAME**: The host name that you are updating. ie. example.com

* **DETECTIP**: If this is set to 1, then the script will detect the external IP of the service on which the container is running, such as the external IP of your DSL or cable modem.
  
* **CNAME**: If DETECTIP is set to 1 and this is set to a dns name, digs the record and sets IP to first available.

* **IP**: if DETECTIP is not set, you can specify an IP address.

* **UPDATEIPV6**: If this is set to 1, then the script will detect the external IPv6 address of the service on which the container is running.

* **INTERVAL**: How often the script should call the update services in minutes.

* **SERVICE**: The service you are using. Currently, the script is setup to use Google Domains (google), DuckDNS (duckdns), DynDNS (dyndns), and NO-IP (noip). Set the service to the value in parenthesis.

 That's it. Please comment below if there are other services using the DynDNS protocol you would like me to add.
