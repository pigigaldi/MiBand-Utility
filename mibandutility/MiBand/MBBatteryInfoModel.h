//
//  MBBatteryInfoModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBatteryInfoModel : NSObject

@property (nonatomic) NSUInteger level;
@property (nonatomic, strong) NSDate *lastCharge;
@property (nonatomic) NSUInteger chargesCount;
@property (nonatomic) NSUInteger status;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
