//
//  DKMiBandController.h
//  MiBandUtility
//
//  Created by Pigi Galdi on 21.05.2015.
//  Copyright (c) 2015 Pigi Galdi. All rights reserved.
//
//	-> Apple.
#import <UIKit/UIKit.h>
// MiBand-API - (https://github.com/tracy-e/MiBand-API/).
#import "MiBand/MiBand.h"

@interface DKMiBandController : NSObject
+ (DKMiBandController *)mibandSharedInstance;
- (void)loadCentralManager;
- (void)scanForMiBand;
- (MBPeripheral *)dkPeripheral;
- (NSString *)deviceName;
@end