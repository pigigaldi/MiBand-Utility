//
//  MBHelper.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef void (^MBCounter)();

@interface MBHelper : NSObject

+ (NSUInteger)hexString2Int:(NSString *)value;
+ (NSString *)byte2HexString:(Byte)value;
+ (NSUInteger)CRC8WithBytes:(Byte *)bytes length:(NSUInteger)length;
+ (MBCounter)counter:(NSUInteger)count withBlock:(void (^)())counterCallback;

@end