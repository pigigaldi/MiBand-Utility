//
//  MiBandUtility.xm
//  MiBandUtility
//
//  Created by Pigi Galdi on 21.05.2015.
//  Copyright (c) 2015 Pigi Galdi. All rights reserved.
//
//	
//	+ Define.
#define kPreferenceFile "com.pigigaldi.mibandutilitypreferences"
#define kPreferenceDictionary [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.pigigaldi.mibandutilitypreferences.plist"]
#define kPreferenceChangedNotification "com.pigigaldi.mibandutilitypreferences.prefchanged"
#define kPreferenceChangedThemeColor "com.pigigaldi.mibandutilitypreferences.themecolorchanged"
#define kConnectingToMiBandFromMiFit "com.pigigaldi.mibandutilitypreferences.connectingfrommifit"
#define kRebootFromPreferences "com.pigigaldi.mibandutilitypreferences.reboot"
#define kFactoryResetFromPreferences "com.pigigaldi.mibandutilitypreferences.factoryreset"

#define kCASE(str)                       if ([__s__ isEqualToString:(str)]) 
#define kSWITCH(s)                       for (NSString *__s__ = (s); ; )
#define kDEFAULT 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>
// DK.
#import "DKMiBandController.h"

static NSUInteger kTRedColor;
static NSUInteger kTGreenColor;
static NSUInteger kTBlueColor;

#define kMibandController [DKMiBandController mibandSharedInstance]
static BOOL doNotDisturbEnabled;
static BOOL mibanduDoNotDisturb;

static void mibandutilityLoadPreferences() {
CFPreferencesAppSynchronize(CFSTR(kPreferenceFile));
	// DO NOT DISTURB.
	mibanduDoNotDisturb = !CFPreferencesCopyAppValue(CFSTR("mibanduDoNotDisturb"), CFSTR(kPreferenceFile)) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("mibanduDoNotDisturb"), CFSTR(kPreferenceFile))) boolValue];
	// THEME COLOR.
	NSString *themeColor = (id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("mibanduDefaultThemeColor"), CFSTR(kPreferenceFile)));
	/* colors. 
	RED      = (6, 0, 0)
	GREEN    = (0, 6, 0)
	BLUE     = (0, 0, 6)
	ORANGE   = (6, 3, 0)
	PURPLE 	 = (3, 0, 3)
    AQUA     = (0, 6, 6)
    FUCHSIA  = (6, 0, 6)
    YELLOW   = (6, 6, 0)
    BROWN 	 = (4, 2, 1)
    GRAY     = (3, 3, 3)
    WHITE    = (6, 6, 6)
	*/
	// switch.
	kSWITCH (themeColor){
		kCASE (@"red") {
			kTRedColor = 6;
			kTGreenColor = 0;
			kTBlueColor = 0;
			break;
		}
		kCASE (@"green") {
			kTRedColor = 0;
			kTGreenColor = 6;
			kTBlueColor = 0;
			break;
		}
		kCASE (@"blue") {
			kTRedColor = 0;
			kTGreenColor = 0;
			kTBlueColor = 6;
			break;
		}
		kCASE (@"orange") {
			kTRedColor = 6;
			kTGreenColor = 2;
			kTBlueColor = 0;
			break;
		}
		kCASE (@"purple") {
			kTRedColor = 2;
			kTGreenColor = 0;
			kTBlueColor = 2;
			break;
		}
		kCASE (@"aqua") {
			kTRedColor = 0;
			kTGreenColor = 6;
			kTBlueColor = 6;
			break;
		}
		kCASE (@"fuxia") {
			kTRedColor = 6;
			kTGreenColor = 0;
			kTBlueColor = 6;
			break;
		}
		kCASE (@"yellow") {
			kTRedColor = 6;
			kTGreenColor = 6;
			kTBlueColor = 0;
			break;
		}
		kCASE (@"brown") {
			kTRedColor = 4;
			kTGreenColor = 2;
			kTBlueColor = 1;
			break;
		}
		kCASE (@"gray") {
			kTRedColor = 1;
			kTGreenColor = 1;
			kTBlueColor = 1;
			break;
		}
		kCASE (@"white") {
			kTRedColor = 6;
			kTGreenColor = 6;
			kTBlueColor = 6;
			break;
		}
		kDEFAULT {
			break;
		}
	}
}

static void mibandutilityChangeThemeColor() {
	// sync preferences.
	mibandutilityLoadPreferences();
	// change theme color.
	[[kMibandController dkPeripheral] setColorWithRed:kTRedColor green:kTGreenColor blue:kTBlueColor blink:YES withBlock:^(NSError *error) { }];
}

static void mibandutilityConnectingFromMiFitApplication() {
	// check if is already connected.
	if ([[kMibandController dkPeripheral] isConnected]){
		NSLog(@"MiBand Utility: [MiFit] Band is already connected: %@", [kMibandController dkPeripheral]);
	}else {
		[kMibandController scanForMiBand];
		NSLog(@"MiBand Utility: [MiFit] Connecting to MiBand: %@", [kMibandController dkPeripheral]);
	}
}

static void mibandutilityRebootFromPreferences() {
	// check if is already connected.
	if ([[kMibandController dkPeripheral] isConnected]){
		[[kMibandController dkPeripheral] rebootBandWithBlock:^(NSError *error) { }];
	}else {
		[[[UIAlertView alloc] initWithTitle:@"MiBand Utility" message:@"No MiBand found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}
}

static void mibandutilityFactoryResetFromPreferences() {
	// check if is already connected.
	if ([[kMibandController dkPeripheral] isConnected]){
		[[kMibandController dkPeripheral] factoryResetBandWithBlock:^(NSError *error) { }];
	}else {
		[[[UIAlertView alloc] initWithTitle:@"MiBand Utility" message:@"No MiBand found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
	}
}

%hook SBCCDoNotDisturbSetting
-(void)_setDNDEnabled:(BOOL)arg1 updateServer:(BOOL)arg2 source:(unsigned long long)arg3 {
	doNotDisturbEnabled = arg1;
	%orig();
}
%end

%hook BBServer
- (void)_publishBulletinRequest:(id)request forSectionID:(NSString *)sectionID forDestinations:(unsigned long long)destination alwaysToLockScreen:(_Bool)onLockscreen {
	// show banner on device.
	%orig();

	// sync preferences.
	mibandutilityLoadPreferences();

	// create string.
	NSString *preferencesString = [@"DKEnableColor-" stringByAppendingString:sectionID];
	CFNumberRef _colorValue = (__bridge CFNumberRef)CFBridgingRelease(CFPreferencesCopyAppValue((__bridge CFStringRef)preferencesString, CFSTR(kPreferenceFile)));
    NSNumber *enabledForNotificatedApp = (__bridge NSNumber *)_colorValue;

	// check for do not disturb function.
	if (mibanduDoNotDisturb && doNotDisturbEnabled){
		NSLog(@"MiBand Utility: DND is enabled. Notification will not be send to MiBand.");
	}else {
		// intercept enabled apps (sort of white list).
		switch ([enabledForNotificatedApp intValue]){
			case 0:
				// No Notification.
				break;
			case 1:
				// RED.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:6 green:0 blue:0 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 2:
				// GREEN.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:0 green:6 blue:0 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 3:
				// BLUE.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:0 green:0 blue:6 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 4:
				// ORANGE.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:6 green:2 blue:0 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 5:
				// PURPLE.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:2 green:0 blue:2 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 6:
				// AQUA.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:0 green:6 blue:6 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 7:
				// FUXIA.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:6 green:0 blue:6 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 8:
				// YELLOW.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:6 green:6 blue:0 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 9:
				// BROWN.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:4 green:2 blue:1 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 10:
				// GRAY.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:1 green:1 blue:1 blink:YES withBlock:^(NSError *error) { }];
				break;
			case 11:
				// WHITE.
				[[kMibandController dkPeripheral] makeBandVibrateWithBlock:^(NSError *error) { }];
				[[kMibandController dkPeripheral] setColorWithRed:6 green:6 blue:6 blink:YES withBlock:^(NSError *error) { }];
				break;
			default:
				// No Notification.
				break;
		}
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5f * NSEC_PER_SEC), dispatch_get_main_queue(),^{
			// [[kMibandController dkPeripheral] stopNotificationWithBlock:^(NSError *error) { }];
			[[kMibandController dkPeripheral] setColorWithRed:kTRedColor green:kTGreenColor blue:kTBlueColor blink:NO withBlock:^(NSError *error) { }];
		});
	}
}
%end
//	+ Load at system start-up.
%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)mibandutilityLoadPreferences,
                                    CFSTR(kPreferenceChangedNotification),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)mibandutilityChangeThemeColor,
                                    CFSTR(kPreferenceChangedThemeColor),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)mibandutilityConnectingFromMiFitApplication,
                                    CFSTR(kConnectingToMiBandFromMiFit),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)mibandutilityRebootFromPreferences,
                                    CFSTR(kRebootFromPreferences),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)mibandutilityFactoryResetFromPreferences,
                                    CFSTR(kFactoryResetFromPreferences),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	// Internal Logging.
    NSLog(@"MiBand Utility: Notification System Loaded!");
    // Load Preferences.
    mibandutilityLoadPreferences();
    // Load MBCentralManager.
	[kMibandController loadCentralManager];
}