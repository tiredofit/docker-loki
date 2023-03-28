# github.com/tiredofit/docker-loki

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-loki?style=flat-square)](https://github.com/tiredofit/docker-loki/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-loki/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-loki/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/loki.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/loki/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/loki.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/loki/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

* * *
## About

This will build a docker image for [loki](https://grafana.com/oss/loki/) a log aggregation system..

* Sane defaults to have a working solution by just running the image
* Automatically generates configuration files on startup, or option to use your own
* Choice of Logging (Console, File, Syslog)

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [REST Settings](#rest-settings)
    - [Portal Settings](#portal-settings)
    - [Handler Settings](#handler-settings)
    - [Manager Options](#manager-options)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)


## Installation

### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/loki)

```bash
docker pull docker.io/tiredofdit/loki:(imagetag)
```

Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-loki/pkgs/container/docker-loki) 
 
```
docker pull ghcr.io/tiredofit/docker-loki:(imagetag)
``` 

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Version | Container OS | Tag          |
| ------- | ------------ | ------------ |
| latest  | Alpine       | `:latest`    |


## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

### Persistent Storage

The following directories should be mapped for persistent storage in order to utilize the container effectively.

| Folder                            | Description                                                                          |
| --------------------------------- | ------------------------------------------------------------------------------------ |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`, `nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)    | Nginx webserver                        |


There are a huge amount of configuration variables and it is recommended that you get comfortable for a few hours with the [loki::NG Documentation](https://loki-ng.org/documentation/2.0/start)

You will eventually based on your usage case switch over to `SETUP_TYPE=MANUAL` and edit your own `loki-ng.ini`. While I've tried to make this as easy to use as possible, once in production you'll find much better success with large implementations with this approach.

By Default this image is ready to run out of the box, without having to alter any of the settings with the exception of the `_HOSTNAME` vars. You can also change the majority of these settings from within the Manager. There are instances where these variables would want to be set if you are running multiple handlers or need to enforce a Global Setting for one specific installation.

| Parameter          | Description                                                                                    | Default   |
| ------------------ | ---------------------------------------------------------------------------------------------- | --------- |
| `SETUP_TYPE`       | `AUTO` to auto generate loki-ng.ini on bootup, otherwise let admin control configuration. | `AUTO`    |

### Networking

The following ports are exposed.

| Port   | Description  |
| ------ | ------------ |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* https://grafana.com/docs/loki/latest/
