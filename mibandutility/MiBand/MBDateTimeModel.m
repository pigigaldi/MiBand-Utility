//
//  MBDateTimeModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBDateTimeModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"

@implementation MBDateTimeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        self.newerDate = [reader readDate];
        self.olderDate = [reader readDate];
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeDate:self.newerDate];
    [builder writeDate:self.olderDate];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, newerDate = %@, olderDate = %@>",[self class], self, self.newerDate, self.olderDate];
}


@end
