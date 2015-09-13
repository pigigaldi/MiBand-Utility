//
//  MPCatergorys.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/6.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBUUID (MBUUIDString)

- (NSString *)stringValue;

@end

@interface CBPeripheral (MBIdentifier)

- (NSString *)peripheralIdentifier;

@end