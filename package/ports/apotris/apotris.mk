################################################################################
#
# apotris
#
################################################################################

APOTRIS_VERSION        = v4.1.0
APOTRIS_SITE           = https://gitea.com/akouzoukos/apotris.git
APOTRIS_SITE_METHOD    = git
APOTRIS_GIT_SUBMODULES = YES
APOTRIS_LICENSE        = AGPL-3.0
APOTRIS_LICENSE_FILE   = LICENSE.txt

APOTRIS_DEPENDENCIES = host-python3 host-xxd host-pkgconf \
                       opus libogg libzlib sdl2 sdl2_mixer libgles

APOTRIS_CONF_OPTS = --datadir=share/apotris \
                    -Dportmaster=true -DSoLoud:portmaster=true

APOTRIS_DATAINIT_DIR = $(TARGET_DIR)/usr/share/knulli/datainit/roms/apotris
define APOTRIS_DATAINIT
	mkdir -p $(APOTRIS_DATAINIT_DIR)
	ln -snf /usr/share/apotris/assets $(APOTRIS_DATAINIT_DIR)/assets
	touch $(APOTRIS_DATAINIT_DIR)/Apotris.game
endef

define APOTRIS_EVMAPY
	install -Dm 644 -t $(TARGET_DIR)/usr/share/evmapy \
	        $(BR2_EXTERNAL_KNULLI_PATH)/package/ports/apotris/apotris.keys
endef

APOTRIS_POST_INSTALL_TARGET_HOOKS = APOTRIS_DATAINIT APOTRIS_EVMAPY

$(eval $(meson-package))
