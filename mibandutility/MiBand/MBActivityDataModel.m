//
//  MBActivityDataModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBActivityDataModel.h"

@implementation MBActivityDataModel

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, intensity = %tu, steps = %tu, category = %tu>",[self class], self, _intensity, _steps, _category];
}

@end
