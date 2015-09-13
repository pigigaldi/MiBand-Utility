//
//  MBAlarmClockModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, MBDays) {
    MBDaysOnce = 0,
    MBDaysMon = 1,
    MBDaysTue = 1 << 1,
    MBDaysWeb = 1 << 2,
    MBDaysThu = 1 << 3,
    MBDaysFri = 1 << 4,
    MBDaysSat = 1 << 5,
    MBDaysSun = 1 << 6,
    MBDaysAll = 0x1111111
};

@interface MBAlarmClockModel : NSObject

@property (nonatomic) NSUInteger index;     //0~2
@property (nonatomic) BOOL enabled;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSUInteger smartWakeupDuration;
@property (nonatomic) MBDays days;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)data;

@end
