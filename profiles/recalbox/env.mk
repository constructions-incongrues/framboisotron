IMAGE=images/recalbox-pi3.img.xz
ROMS_DIR=$(HOME)/Games/Emulation/roms
BIOS_DIR=$(HOME)/Games/Emulation/bios
ROMS_EXCLUDE_SYSTEMS=

env-install:
	sudo rsync -avzrltD --stats --human-readable --exclude $(ROMS_EXCLUDE_SYSTEMS) $(ROMS_DIR)/ /media/$(USER)/SHARE/roms
	sudo rsync -avzrltD --stats --human-readable $(BIOS_DIR)/ /media/$(USER)/SHARE/bios