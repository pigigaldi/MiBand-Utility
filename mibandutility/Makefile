ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:8.1

THEOS_BUILD_DIR = Packages
THEOS_DEVICE_IP = 192.168.0.203

include theos/makefiles/common.mk

TWEAK_NAME = MiBandUtility
MiBandUtility_CFLAGS = -fobjc-arc
MiBandUtility_FILES = MiBandUtility.xm DKMiBandController.m MiBand/MBActivityDataFragmentModel.m MiBand/MBActivityDataModel.m MiBand/MBActivityDataReader.m MiBand/MBAlarmClockModel.m MiBand/MBBatteryInfoModel.m MiBand/MBCategorys.m MiBand/MBCentralManager.m MiBand/MBDataBuilder.m MiBand/MBDataReader.m MiBand/MBDateTimeModel.m MiBand/MBDeviceInfoModel.m MiBand/MBHelper.m MiBand/MBLEParamsModel.m MiBand/MBPeripheral.m MiBand/MBStatisticsModel.m MiBand/MBUserInfoModel.m
MiBandUtility_FRAMEWORKS = Foundation UIKit CoreBluetooth

SUBPROJECTS = ../mibandutilityinternal ../mibandutilitypreferences

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

dev:
	make
	make package install
	deviceconsole | grep 'MiBand Utility'

pub:
	make clean
	make
	make package

dylib:
	make
	make package install
	deviceconsole | grep '$(TWEAK_NAME)-Internal:'

log:
	make
	make package install
	deviceconsole

after-install::
	install.exec "killall -9 backboardd"
