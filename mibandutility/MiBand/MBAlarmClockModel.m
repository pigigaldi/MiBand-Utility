//
//  MBAlarmClockModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBAlarmClockModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"
#import "MBPeripheral.h"

@implementation MBAlarmClockModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _index = [[reader rePos:1] readInt:1];
        _enabled = [reader readInt:1];
        _date = [reader readDate];
        _smartWakeupDuration = [reader readInt:1];
        _days = [reader readInt:1];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeInt:MBControlPointTimer bytesCount:1];
    [builder writeInt:_index bytesCount:1];
    [builder writeInt:_enabled bytesCount:1];
    [builder writeDate:_date];
    [builder writeInt:_smartWakeupDuration bytesCount:1];
    [builder writeInt:_days bytesCount:1];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, index = %tu, enable = %d, date = %@, smartWakeupDuration = %tu, days = %tu>", [self class], self, _index, _enabled, _date, _smartWakeupDuration, _days];
}

@end
