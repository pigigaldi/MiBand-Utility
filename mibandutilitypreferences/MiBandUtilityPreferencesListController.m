//
//  MiBandUtilityPreferencesListController.m
//  MiBandUtilityPreferences
//
//  Created by Pigi Galdi on 21.05.2015.
//  Copyright (c) 2015 Pigi Galdi. All rights reserved.
//
#include <execinfo.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "MiBandUtilityPreferencesListController.h"
#import "Preferences/PSSpecifier.h"

@implementation MiBandUtilityPreferencesListController
- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"MiBandUtilityPreferences" target:self];
	}
	return _specifiers;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 	if (section == 0){
 		// title.
 		UILabel *_vestigoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,1.5,tableView.frame.size.width,60)];
		_vestigoLabel.text = @"MiBand Utility";
		_vestigoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:42];;
		_vestigoLabel.numberOfLines = 1;
		_vestigoLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
		_vestigoLabel.adjustsFontSizeToFitWidth = YES;
		_vestigoLabel.minimumScaleFactor = 10.0f/12.0f;
		_vestigoLabel.clipsToBounds = YES;
		_vestigoLabel.backgroundColor = [UIColor clearColor];
		_vestigoLabel.textColor = [UIColor darkGrayColor];
		_vestigoLabel.textAlignment = NSTextAlignmentCenter;

		// thanks.
 		UILabel *_wifiManagerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_vestigoLabel.frame.size.height+5,tableView.frame.size.width,60)];
		_wifiManagerLabel.text = @"Thanks to \"tracy-e\" and \"stormluke\" \n\n https://github.com/tracy-e/MiBand-API \n https://github.com/stormluke/Mili-iOS";
		_wifiManagerLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];;
		_wifiManagerLabel.numberOfLines = 4;
		_wifiManagerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
		_wifiManagerLabel.adjustsFontSizeToFitWidth = YES;
		_wifiManagerLabel.minimumScaleFactor = 10.0f/12.0f;
		_wifiManagerLabel.clipsToBounds = YES;
		_wifiManagerLabel.backgroundColor = [UIColor clearColor];
		_wifiManagerLabel.textColor = [UIColor darkGrayColor];
		_wifiManagerLabel.textAlignment = NSTextAlignmentCenter;

		// Init main (clear) view.
 		UIView *_clearBackView = [[UIView alloc] initWithFrame:CGRectMake(0,10,tableView.frame.size.width,320)];
 		[_clearBackView setBackgroundColor:[UIColor clearColor]];

		// Adding.
		[_clearBackView addSubview:_vestigoLabel];
		[_clearBackView addSubview:_wifiManagerLabel];

 		// Setting the main (clear) view.
 		return _clearBackView;
 	}
 	return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 	if (section == 0){
 		return 140.f;
 	}
 	return 0.f;
}
- (void)rebootMiBand:(PSSpecifier *)specifier {
	// reboot.
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.pigigaldi.mibandutilitypreferences.reboot"), NULL, NULL, true);
}
- (void)factoryResetMiBand:(PSSpecifier *)specifier {
	// factory reset.
	UIAlertView *factoryAlert = [[UIAlertView alloc] initWithTitle:@"MiBand Utility" message:@"\nThis will remove bonding information from your MiBand.\n\nBefore you connect next time you have to remove your MiBand via\n\n\"Settings > Bluetooth.\"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
	factoryAlert.tag = 8;
	[factoryAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 8) {
        if (buttonIndex != 0){
        	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.pigigaldi.mibandutilitypreferences.factoryreset"), NULL, NULL, true);
        }
    }
}
@end
