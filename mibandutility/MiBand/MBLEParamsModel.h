//
//  MBLEParamsModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBLEParamsModel : NSObject

@property (nonatomic) NSUInteger connIntMin;
@property (nonatomic) NSUInteger connIntMax;
@property (nonatomic) NSUInteger latency;
@property (nonatomic) NSUInteger timeout;
@property (nonatomic) NSUInteger connInt;
@property (nonatomic) NSUInteger advInt;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
