//
//  MBActivityDataFragmentModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBActivityDataFragmentModel.h"

@implementation MBActivityDataFragmentModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _activityDataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, type = %tu, timeStamp = %@, duration = %tu min, count = %tu>",[self class], self, _type, _timeStamp, _duration, _count];
}

@end
