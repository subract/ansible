# Homelab Ansible
Stores Ansible config for `subract`'s homelab, to simplify management and enable easier service deployment.
Currently managing the following:

- A primary application server
	- Using [ZFS](https://openzfs.org/wiki/Main_Page) and [automated snapshots](roles/syncoid_sanoid/tasks/main.yml) with Sanoid for [functional immortality](https://github.com/jimsalterjrs/sanoid)
	- [Automated backups](roles/backblaze/tasks/main.yml) to Backblaze B2 for disaster recovery
	- ZFS-based full-disk encryption
	- Docker [hosting the following](templates/app01)
		- [Traefik](https://traefik.io/traefik/) - a reverse proxy managing access to all web services. 
			- Providing SSL termination and automated certificates with [Let's Encrypt](https://letsencrypt.org/)
		- [Authelia](https://www.authelia.com/) - an authentication and authorization server providing SSO
		- [Nextcloud](https://nextcloud.com/) - file storage and synchronization
		- [Immich](https://immich.app/) - Google Photos replacement for backups
		- [Gitea](https://gitea.io/en-us/) - lightweight Git hosting
		- [Drone](https://www.drone.io/) - continuous integration platform handling deployments
		- [Home Assistant](https://www.home-assistant.io/) - smart home management
			- Supported by [Zigbee2MQTT](https://www.zigbee2mqtt.io) and [Mosquitto](https://mosquitto.org/)
		- [CyberChef](https://github.com/gchq/CyberChef) - "Cyber Swiss Army Knife" - handy for random operations
		- [Miniflux](https://miniflux.app/) - a minimalist RSS feed reader
		- [Paperless-ngx](https://docs.paperless-ngx.com/) - a document management system to digitize documents
		- [Changedetection.io](https://changedetection.io/) - monitor web pages for changes
- A cloud VPS hosting [public services](templates/web01) to the Internet
	- [Minecraft servers](https://github.com/itzg/docker-minecraft-server) - a few different worlds for friends and family
	- [Peertube](https://joinpeertube.org/en_US) - a YouTube alternative platform that supports ActivityPub federation
	- A personal blog
- A couple of Arch workstations
	- Managing [packages](roles/arch_workstation/tasks/packages.yaml), services, and [sundry other configuration](roles/arch_workstation/tasks/main.yml)
	- Using [secure boot](roles/arch_secureboot/tasks/main.yml) for boot integrity with full-disk encryption

This is a living repo, evolving as I add and manage additional services. As I tackle the challenges of managing additional systems, I'll expand this repo to include them.