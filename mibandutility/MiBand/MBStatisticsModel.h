//
//  MBStatisticsModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/5.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBStatisticsModel : NSObject

@property (nonatomic) NSUInteger wake;
@property (nonatomic) NSUInteger vibrate;
@property (nonatomic) NSUInteger light;
@property (nonatomic) NSUInteger conn;
@property (nonatomic) NSUInteger adv;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
