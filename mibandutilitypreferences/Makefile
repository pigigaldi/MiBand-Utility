ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:8.1

THEOS_BUILD_DIR = Packages
THEOS_DEVICE_IP = 192.168.0.203

include theos/makefiles/common.mk

BUNDLE_NAME = MiBandUtilityPreferences
MiBandUtilityPreferences_CFLAGS = -fobjc-arc
MiBandUtilityPreferences_FILES = MiBandUtilityPreferencesListController.m
MiBandUtilityPreferences_INSTALL_PATH = /Library/PreferenceBundles
MiBandUtilityPreferences_FRAMEWORKS = Foundation UIKit
MiBandUtilityPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MiBandUtilityPreferences.plist$(ECHO_END)
