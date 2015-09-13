//
//  MBStatisticsModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/5.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBStatisticsModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"

@implementation MBStatisticsModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _wake = [reader readInt:4];
        _vibrate = [reader readInt:4];
        _light = [reader readInt:4];
        _conn = [reader readInt:4];
        _adv = [reader readInt:4];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeInt:_wake bytesCount:4];
    [builder writeInt:_vibrate bytesCount:4];
    [builder writeInt:_light bytesCount:4];
    [builder writeInt:_conn bytesCount:4];
    [builder writeInt:_adv bytesCount:4];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, wake = %tu(%tu) ms, vibrate = %tu ms, light = %tu ms, conn = %tu ms, adv = %tu ms>",[self class], self, (NSUInteger)(_wake / 1.6), _wake, _vibrate, _light, _conn, _adv];
}

@end
