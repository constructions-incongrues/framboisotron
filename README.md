# Framboisotron

## Installation

Installation des dépendances :

```sh
sudo apt install curl git make openssh-client rsync 
```

Récupérer les sources :

```sh
git clone https://github.com/constructions-incongrues/framboisotron
```

## Utilisation

Paramètres globaux :

- `PROFILE=raspbian-lite` : Nom du profil du dossier [`profiles`](profiles) à utiliser

### Flashage

Paramètres :

- `DEVICE=/dev/mmcblk0` : Périphérique correspondant à la carte SD
- `ETCHER_HOME=./vendor/balena-etcher-cli-1.4.9-linux-x64-dist` : Chemin vers les sources de Etcher
- `IMAGE=./2018-11-13-raspbian-stretch-lite.zip` : Image à utiliser. Cette valeur est généralement surchargée dans la configuration du profil.

```sh
make flash PROFILE=... <PARAMÈTRES OPTIONNELS>
```

### Configuration

Paramètres :

- `MOUNTPOINT=/media/$(USER)`
- `WIFI_COUNTRY=FR`
- `WIFI_PASSWD=`
- `WIFI_SSID=`

```sh
make configure PROFILE=... WIFI_PASSWD=... WIFI_SSID=... <PARAMÈTRES OPTIONNELS>
```

### Installation

Paramètres :

- `PI_HOSTNAME=raspberrypi`

```sh
make install PROFILE=... <PARAMÈTRES OPTIONNELS>
```

### Connexion au Raspberry PI

- `PI_HOSTNAME=raspberrypi`

```sh
make ssh PROFILE=... <PARAMÈTRES OPTIONNELS>
```
