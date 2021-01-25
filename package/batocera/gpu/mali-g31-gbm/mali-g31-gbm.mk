################################################################################
#
# mali-g31-gbm
#
################################################################################
# Version.: Commits on Jan 19, 2021
MALI_G31_GBM_VERSION = 55b5d650efc98db2ce2e7a170111a71cf0e2c239
MALI_G31_GBM_SITE = $(call github,rockchip-linux,libmali,$(MALI_G31_GBM_VERSION))

MALI_G31_GBM_INSTALL_STAGING = YES
MALI_G31_GBM_PROVIDES = libegl libgles

MALI_G31_GBM_CONF_OPTS = \
	-Dplatform=gbm \
	-Dgpu=bifrost-g31 \
	-Dversion=rxp0

ifneq ($(BR2_PACKAGE_MESA3D),y)
# See https://github.com/rockchip-linux/libmali/issues/66
define MALI_G31_GBM_COPY_KHRPLATFORM_STAGING
	cp $(STAGING_DIR)/usr/include/KHR/mali_khrplatform.h \
		$(STAGING_DIR)/usr/include/KHR/khrplatform.h
endef
MALI_G31_GBM_POST_INSTALL_STAGING_HOOKS += MALI_G31_GBM_COPY_KHRPLATFORM_STAGING
endif

$(eval $(meson-package))
