################################################################################
#
# qt6tools
#
################################################################################

QT6TOOLS_VERSION = $(QT6_VERSION)
QT6TOOLS_SITE = $(QT6_SITE)
QT6TOOLS_SOURCE = qttools-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6TOOLS_VERSION).tar.xz
QT6TOOLS_DEPENDENCIES = \
	double-conversion \
	host-ninja \
	host-qt6base \
	host-qt6tools \
	libb2 \
	pcre2 \
	zlib

# qtdiag requires glibc 2.36
QT6TOOLS_CONF_OPTS = \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DQT_FEATURE_linguist=ON \
    -DQT_FEATURE_qdbus=ON \
    -DQT_FEATURE_qtattributionsscanner=ON \
    -DQT_FEATURE_qtdiag=OFF \
    -DQT_FEATURE_qtplugininfo=ON

define QT6TOOLS_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(BR2_CMAKE) --build $(QT6TOOLS_BUILDDIR)
endef

define QT6TOOLS_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(BR2_CMAKE) --install $(QT6TOOLS_BUILDDIR) --prefix $(STAGING_DIR)/usr
endef

define QT6TOOLS_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(BR2_CMAKE) --install $(QT6TOOLS_BUILDDIR) --prefix $(TARGET_DIR)/usr
endef

HOST_QT6TOOLS_DEPENDENCIES = \
    host-ninja \
    host-qt6base \
    qt6base \
    host-double-conversion \
    host-libb2 \
    host-pcre2 \
    host-zlib

# qtdiag requires glibc 2.36
HOST_QT6TOOLS_CONF_OPTS = \
    -GNinja \
    -DCMAKE_PREFIX_PATH=$(STAGING_DIR)/usr \
    -DQT_FEATURE_linguist=ON \
    -DQT_FEATURE_qdbus=ON \
    -DQT_FEATURE_qtattributionsscanner=ON \
    -DQT_FEATURE_qtdiag=OFF \
    -DQT_FEATURE_qtplugininfo=ON

define HOST_QT6TOOLS_BUILD_CMDS
    $(HOST_MAKE_ENV) $(BR2_CMAKE) --build $(HOST_QT6TOOLS_BUILDDIR)
endef

define HOST_QT6TOOLS_INSTALL_CMDS
    $(HOST_MAKE_ENV) $(BR2_CMAKE) --install $(HOST_QT6TOOLS_BUILDDIR)
endef

$(eval $(cmake-package))
$(eval $(host-cmake-package))
