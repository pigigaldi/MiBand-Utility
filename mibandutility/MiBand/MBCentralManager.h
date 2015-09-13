//
//  MBCentralManager.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBCentralManager, MBPeripheral;

typedef NS_ENUM(int, MBServiceType) {
    MBServiceTypeDefault = 0xFEE0
};

typedef void(^MBStateUpdatedBlock)(MBCentralManager *manager);
typedef void(^MBConnectResultBlock)(MBPeripheral *peripheral, NSError *error);
typedef void(^MBDiscoverPeripheralBlock)(MBPeripheral *miband, NSNumber *RSSI, NSError *error);

@interface MBCentralManager : NSObject

@property (nonatomic, getter=isScanning, readonly) BOOL scanning;
@property (nonatomic, strong, readonly) NSArray *peripherals;
@property (nonatomic, copy) MBStateUpdatedBlock poweredOnBlock;
@property (nonatomic, copy) MBStateUpdatedBlock poweredOffBlock;
@property (nonatomic, copy) MBConnectResultBlock disconnectedBlock;

+ (instancetype)sharedCentralManager;
- (void)scanForMiBandWithBlock:(MBDiscoverPeripheralBlock)discoverPeripheralBlock;
- (void)connectPeripheral:(MBPeripheral *)peripheral withResultBlock:(MBConnectResultBlock)resultBlock;
- (void)stopScan;

@end
