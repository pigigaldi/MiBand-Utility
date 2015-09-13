//
//  MBDeviceInfoModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBDeviceInfoModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"
#import "MBHelper.h"

@implementation MBDeviceInfoModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _deviceID = @"";
        for (NSUInteger i = 0; i < 8; i++) {
            Byte byte = [reader readInt:1];
            _deviceID = [_deviceID stringByAppendingString:[MBHelper byte2HexString:byte]];
        }
        _mac = [[reader rePos:3] readInt:1];
        _mac16 = [[reader rePos:2] readIntReverse:2];
        _appearence = [[reader rePos:6] readInt:1];
        _feature = [reader readInt:1];

        _profileVersion = [reader readVersionString];
        _firmwareVersion = [reader readVersionString];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeString:_deviceID bytesCount:8];
    [builder writeVersionString:_profileVersion];
    [builder writeVersionString:_firmwareVersion];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, deviceID = %@, feature = %tu, appearence = %tu,  profileVersion = %@, firmwareVersion = %@, mac = %tu, mac16 = %tu>", [self class], self, _deviceID, _feature, _appearence, _profileVersion, _firmwareVersion, _mac, _mac16];
}

@end
