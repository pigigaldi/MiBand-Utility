//
//  MBDeviceInfoModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/3.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDeviceInfoModel : NSObject

@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *profileVersion;
@property (nonatomic, strong) NSString *firmwareVersion;
@property (nonatomic) NSUInteger feature;
@property (nonatomic) NSUInteger appearence;
@property (nonatomic) NSUInteger mac;
@property (nonatomic) NSUInteger mac16;


- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
