.PHONY=configure etcher flash install mount umount ssh

# Paramètres
DEVICE=/dev/mmcblk0
ETCHER_HOME=./vendor/balena-etcher-cli-1.4.9-linux-x64-dist
ETCHER_URL=https://github.com/balena-io/etcher/releases/download/v1.4.9/balena-etcher-cli-1.4.9-linux-x64.tar.gz
IMAGE=images/2018-11-13-raspbian-stretch-lite.zip
PI_HOSTNAME=raspberrypi
PROFILE=raspbian-lite
WIFI_COUNTRY=FR
WIFI_PASSWD=
WIFI_SSID=

# Paramètres du profile
include ./profiles/$(PROFILE)/env.mk

# TODO : Permettre de configurer le nom d'hôte
configure: mount
	WIFI_COUNTRY="$(WIFI_COUNTRY)" WIFI_PASSWD="$(WIFI_PASSWD)" WIFI_SSID="$(WIFI_SSID)" envsubst < ./wpa_supplicant.conf.dist > /media/$(USER)/boot/wpa_supplicant.conf	
	cat /media/$(USER)/boot/wpa_supplicant.conf
	touch /media/$(USER)/boot/ssh
	sed -i "s/127.0.1.1	raspberry/127.0.1.1	$(PI_HOSTNAME)" /etc/resolv.conf
	echo "$(PI_HOSTNAME)" > /etc/hostname

etcher:
	if [ ! -d "$(ETCHER_HOME)" ]; then \
		mkdir $(ETCHER_HOME); \
		curl -fL# $(ETCHER_URL) | tar xz --strip 1 -C $(ETCHER_HOME); \
	fi

flash: etcher
	sudo $(ETCHER_HOME)/balena-etcher --drive $(DEVICE) --check --unmount --yes $(IMAGE)

install: mount
	$(MAKE) -f ./profiles/$(PROFILE)/env.mk env-install

mount:
	-udisksctl mount --block-device $(DEVICE)p1

unmount:
	-udisksctl unmount --block-device $(DEVICE)p1

ssh:
	ssh-copy-id pi@$(PI_HOSTNAME)
	ssh pi@$(PI_HOSTNAME)
