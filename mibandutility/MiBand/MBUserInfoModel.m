//
//  MBUserInfoModel.m
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import "MBUserInfoModel.h"
#import "MBDataBuilder.h"
#import "MBDataReader.h"

@implementation MBUserInfoModel

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        MBDataReader *reader = [[MBDataReader alloc] initWithData:data];
        _uid = [reader readInt:4];
        _gender = (MBGenderType)[reader readInt:1];
        _age = [reader readInt:1];
        _height = [reader readInt:1];
        _weight = [reader readInt:1];
        _type = [reader readInt:1];
        _alias = [reader readString:8];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name uid:(NSUInteger)uid gender:(MBGenderType)gender age:(NSUInteger)age height:(NSUInteger)height weight:(NSUInteger)weight type:(MBAuthType)type {
    self = [super init];
    if (self) {
        _uid = uid;
        _gender = gender;
        _age = age;
        _height = height;
        _weight = weight;
        _alias = name;
        _type = type;
    }
    return self;
}

- (NSData *)data {
    MBDataBuilder *builder = [[MBDataBuilder alloc] init];
    [builder writeInt:_uid bytesCount:4];
    [builder writeInt:_gender bytesCount:1];
    [builder writeInt:_age bytesCount:1];
    [builder writeInt:_height bytesCount:1];
    [builder writeInt:_weight bytesCount:1];
    [builder writeInt:_type bytesCount:1];
    [builder writeString:_alias bytesCount:10];
    [builder writeChecksumFromIndex:0 length:19 lastMACByte:0x99];
    return [builder data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"uid = %tu, gender = %tu, age = %tu, height = %tu cm, weight = %tu kg, alias = %@, type = %tu", _uid, _gender, _age, _height, _weight, _alias, _type];
}

@end
