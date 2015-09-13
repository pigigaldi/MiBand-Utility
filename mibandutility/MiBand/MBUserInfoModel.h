//
//  MBUserInfoModel.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBGenderType) {
    MBGenderTypeFemale = 0,
    MBGenderTypeMale
};

typedef NS_ENUM(NSUInteger, MBAuthType) {
    MBAuthTypeNormal = 0,
    MBAuthTypeClearData,
    MBAuthTypeRetainData
};

@interface MBUserInfoModel : NSObject

@property (nonatomic) NSUInteger uid;
@property (nonatomic) MBGenderType gender;
@property (nonatomic) NSUInteger age;
@property (nonatomic) NSUInteger height;
@property (nonatomic) NSUInteger weight;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic) MBAuthType type;

- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithName:(NSString *)name uid:(NSUInteger)uid gender:(MBGenderType)gender age:(NSUInteger)age height:(NSUInteger)height weight:(NSUInteger)weight type:(MBAuthType)type;
- (NSData *)data;

@end
