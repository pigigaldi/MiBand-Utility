ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:8.0

THEOS_BUILD_DIR = Packages
THEOS_DEVICE_IP = 192.168.0.203

include theos/makefiles/common.mk

TWEAK_NAME = MiBandUtilityInternal
MiBandUtilityInternal_CFLAGS = -fobjc-arc
MiBandUtilityInternal_FILES = MiBandUtilityInternal.xm
MiBandUtilityInternal_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

pub:
	make
	make package install
	deviceconsole | grep 'MiBand Utility'

dylib:
	make
	scp -r $(THEOS_PROJECT_DIR)/$(TWEAK_NAME).plist root@$(THEOS_DEVICE_IP):/Library/MobileSubstrate/DynamicLibraries/
	scp -r $(THEOS_BUILD_DIR)/$(THEOS_OBJ_DIR_NAME)/$(TWEAK_NAME).dylib root@$(THEOS_DEVICE_IP):/Library/MobileSubstrate/DynamicLibraries/
	ssh root@$(THEOS_DEVICE_IP) 'killall backboardd'

after-install::
	install.exec "killall -9 backboardd"
