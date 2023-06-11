# Homelab Ansible
Stores Ansible config for `subract`'s homelab, to simplify management and enable easier service deployment.
Currently managing the following:

- A Proxmox VE server providing VM hosting
	- Using [ZFS](https://openzfs.org/wiki/Main_Page) and [automated snapshots](roles/syncoid_sanoid/tasks/main.yml) with Sanoid for [functional immortality](https://github.com/jimsalterjrs/sanoid)
	- [Automated backups](roles/backblaze/tasks/main.yml) to Backblaze B2 for disaster recovery
	- [Remotely decryptable](roles/remote_decrypt/tasks/main.yml) full-disk encryption
- A flotilla of applications deployed with Docker, split across a handful of VMs
	- A primary application server [hosting the following](templates/apps)
		- [Traefik](https://traefik.io/traefik/) - a reverse proxy managing access to all web services. 
			- Providing SSL termination and automated certificates with [Let's Encrypt](https://letsencrypt.org/)
		- [Nextcloud](https://nextcloud.com/) - file storage and synchronization
		- [Gitea](https://gitea.io/en-us/) - lightweight Git hosting
		- [Drone](https://www.drone.io/) - continuous integration platform
		- [Home Assistant](https://www.home-assistant.io/) - smart home management
			- Supported by [Zigbee2MQTT](https://www.zigbee2mqtt.io) and [Mosquitto](https://mosquitto.org/)
		- [Node-RED](https://nodered.org/) - smart home automation with visual scripting
		- [CyberChef](https://github.com/gchq/CyberChef) - "Cyber Swiss Army Knife" - handy for random operations
		- [OctoPrint](https://octoprint.org/) - 3D printer management
	- A DMZ application server hosting [public services](templates/dmz-apps) to the Internet
		- [Minecraft servers](https://github.com/itzg/docker-minecraft-server) - a few different worlds for friends and family
		- [Factorio server](https://github.com/factoriotools/factorio-docker) - the definitive automation game
		- [Keycloak](https://www.keycloak.org/) - identity and access management, providing single sign-on services
		- [HedgeDoc](https://hedgedoc.org/) - collaborative Markdown editor
- A couple of Arch workstations
	- Managing [packages](roles/arch_workstation/tasks/packages.yaml), services, and [sundry other configuration](roles/arch_workstation/tasks/main.yml)
	- Using [secure boot](roles/arch_secureboot/tasks/main.yml) for boot integrity with full-disk encryption

This is a living repo, evolving as I add and manage additional services. There's a few ancillary services in my homelab that I'm not yet managing with Ansible, like my [OPNsense](https://opnsense.org/) router hosting a [Wireguard](https://www.wireguard.com/) VPN for remote access. As I tackle the challenges of managing additional systems, I'll expand this repo to include them.