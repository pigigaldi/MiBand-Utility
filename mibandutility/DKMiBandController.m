//
//  DKMiBandController.m
//  MiBandUtility
//
//  Created by Pigi Galdi on 21.05.2015.
//  Copyright (c) 2015 Pigi Galdi. All rights reserved.
//
//	-> DK.
#import "DKMiBandController.h"

@interface DKMiBandController ()
@property (nonatomic) MBPeripheral *myPeripheral;
@end

static __weak __typeof(MBCentralManager *) centralManager;

@implementation DKMiBandController
+ (DKMiBandController *)mibandSharedInstance {
	static DKMiBandController *wSharedInstance;
    if (wSharedInstance == nil){
        @synchronized(self){
            if (wSharedInstance == nil){
                wSharedInstance = [self new];
                return wSharedInstance;
            }
        }
    }
    return wSharedInstance;
}
- (void)loadCentralManager {
	// create centralManager.
	centralManager = [MBCentralManager sharedCentralManager];
	// get peripheral on powern on, after scan.
    [centralManager setPoweredOnBlock:^(MBCentralManager *manager) {
        [self scanForMiBand];
    }];
    [centralManager setPoweredOffBlock:^(MBCentralManager *manager) {
        [manager stopScan];
    }];
    [centralManager setDisconnectedBlock:^(MBPeripheral *peripheral, NSError *error) {
        // null.
    }];
}
- (void)scanForMiBand {
    // get peripheral after scan.
    [centralManager scanForMiBandWithBlock:^(MBPeripheral *miband, NSNumber *RSSI, NSError *error) {
        [centralManager stopScan];
        NSLog(@"MiBand Utility: [DKMiBandController] scanWithCentralManager -> %@ forMiBand -> %@", centralManager, miband);
        self->_myPeripheral = centralManager.peripherals[0];
        [centralManager connectPeripheral:_myPeripheral withResultBlock:^(MBPeripheral *peripheral, NSError *error) {
            if (error) {
                //return [[[UIAlertView alloc] initWithTitle:@"MiBand Utility" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show]; 
                return NSLog(@"MiBand Utility: [DKMiBandController] ERROR -> %@", [error localizedDescription]);
            }
        }];
    }];
}
- (MBPeripheral *)dkPeripheral {
	return _myPeripheral;
}
- (NSString *)deviceName {
    return _myPeripheral.name;
}
@end