//
//  MBDateTimeModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDateTimeModel : NSObject

@property (nonatomic, strong) NSDate *newerDate;
@property (nonatomic, strong) NSDate *olderDate;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
