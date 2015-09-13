//
//  MBLEParamsModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBLEParamsModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"

@implementation MBLEParamsModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _connIntMin = [reader readInt:2];
        _connIntMax = [reader readInt:2];
        _latency = [reader readInt:2];
        _timeout = [reader readInt:2];
        _connInt = [reader readInt:2];
        _advInt = [reader readInt:2];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeInt:_connIntMin bytesCount:2];
    [builder writeInt:_connIntMax bytesCount:2];
    [builder writeInt:_latency bytesCount:2];
    [builder writeInt:_timeout bytesCount:2];
    [builder writeInt:_connInt bytesCount:2];
    [builder writeInt:_advInt bytesCount:2];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, connIntMin = %tu, connIntMax = %tu, latency = %tu, timeout = %tu, connInt = %tu, advInt = %tu>",[self class], self, _connIntMin,_connIntMax, _latency, _timeout, _connInt, _advInt];
}

@end
