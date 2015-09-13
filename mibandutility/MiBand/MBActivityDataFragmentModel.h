//
//  MBActivityDataFragmentModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBActivityDataFragmentModel : NSObject

@property (nonatomic) NSUInteger type;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic) NSUInteger duration;
@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) NSMutableArray *activityDataList;

@end
