PACKAGE_VERSION = 1.3
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BetterCCXIWeatherFix

BetterCCXIWeatherFix_FILES = Tweak.xm
BetterCCXIWeatherFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
