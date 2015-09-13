//
//  MBDataReader.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDataReader : NSObject

@property (nonatomic) NSUInteger pos;
@property (nonatomic) Byte *bytes;
@property (nonatomic) NSUInteger length;

- (instancetype)initWithData:(NSData *)data;
- (instancetype)rePos:(NSUInteger)pos;
- (NSUInteger)bytesLeftCount;
- (NSUInteger)readInt:(NSUInteger)bytesCount;
- (NSUInteger)readIntReverse:(NSUInteger)bytesCount;
- (NSInteger)readSensorData;
- (NSString *)readString:(NSUInteger)bytesCount;
- (NSString *)readVersionString;
- (NSDate *)readDate;

@end
