//
//  MBDataBuilder.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDataBuilder : NSObject

@property (nonatomic) NSUInteger pos;
@property (nonatomic) Byte *bytes;

- (instancetype)writeInt:(NSUInteger)value bytesCount:(NSUInteger)count;
- (instancetype)writeString:(NSString *)value bytesCount:(NSUInteger)count;
- (instancetype)writeVersionString:(NSString *)value;
- (instancetype)writeDate:(NSDate *)value;
- (instancetype)writeColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue blink:(BOOL)blink;
- (instancetype)writeChecksumFromIndex:(NSUInteger)index length:(NSUInteger)length lastMACByte:(NSUInteger)lastMACByte;
- (NSData *)data;

@end
