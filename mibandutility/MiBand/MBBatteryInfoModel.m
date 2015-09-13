//
//  MBBatteryInfoModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBBatteryInfoModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"

@implementation MBBatteryInfoModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _level = [reader readInt:1];
        _lastCharge = [reader readDate];
        _chargesCount = [reader readInt:2];
        _status = [reader readInt:1];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeInt:_level bytesCount:1];
    [builder writeDate:_lastCharge];
    [builder writeInt:_chargesCount bytesCount:1];
    [builder writeInt:_status bytesCount:1];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"level = %tu%%, lastCharge = %@, chargesCount = %tu, status = %tx", _level, _lastCharge, _chargesCount, _status];
}

@end
