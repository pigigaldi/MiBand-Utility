//
//  MBActivityDataReader.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/4.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBDataReader.h"

@interface MBActivityDataReader : MBDataReader

- (BOOL)isDone;
- (instancetype)appendData:(NSData *)data;
- (NSArray *)activityDataFragmentList;

@end
