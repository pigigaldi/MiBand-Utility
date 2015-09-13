//
//  MBPeripheral.h
//  MiBandApiSample
//
//  Created by TracyYih on 15/1/2.
//  Copyright (c) 2015年 esoftmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral, CBService;
@class MBCentralManager;
@class MBUserInfoModel, MBBatteryInfoModel, MBLEParamsModel, MBDeviceInfoModel, MBAlarmClockModel, MBDateTimeModel, MBStatisticsModel;

typedef NS_ENUM(NSInteger, MBCharacteristicType) {
    MBCharacteristicTypeDeviceInfo = 0xFF01,
    MBCharacteristicTypeDeviceName,         //0xFF02
    MBCharacteristicTypeNotification,       //0xFF03
    MBCharacteristicTypeUserInfo,           //0xFF04
    MBCharacteristicTypeControl,            //0xFF05
    MBCharacteristicTypeRealtimeSteps,      //0xFF06
    MBCharacteristicTypeActivityData,       //0xFF07
    MBCharacteristicTypeFirmwareData,       //0xFF08
    MBCharacteristicTypeLEParams,           //0xFF09
    MBCharacteristicTypeDateTime,           //0xFF0A
    MBCharacteristicTypeStatistics,         //0xFF0B
    MBCharacteristicTypeBatteryInfo,        //0xFF0C
    MBCharacteristicTypeTest,               //0xFF0D
    MBCharacteristicTypeSensorData          //0xFF0E
};

typedef NS_OPTIONS(NSInteger, MBControlPoint) {
    MBControlPointStopCallRemind = 0,
    MBControlPointCallRemind,
    MBControlPointRealtimeSetpsNotification = 3,
    MBControlPointTimer,
    MBControlPointGoal,
    MBControlPointFetchData,
    MBControlPointFirmwareInfo,
    MBControlPointSendNotification,
    MBControlPointReset,
    MBControlPointConfirmData,
    MBControlPointSync,
    MBControlPointReboot = 12,
    MBControlPointColor = 14,
    MBControlPointWearPosition,
    MBControlPointRealtimeSteps,
    MBControlPointStopSync,
    MBControlPointSensorData,
    MBControlPointStopVibrate
};

typedef NS_ENUM(NSInteger, MBNotificationType) {
    MBNotificationTypeNormal = 0,
    MBNotificationTypeCall
};

typedef NS_ENUM(NSInteger, MBWearPosition) {
    MBWearPositionLeft = 0,
    MBWearPositionRight
};

typedef void(^MBDiscoverServicesResultBlock)(NSArray *services, NSError *error);
typedef void(^MBDiscoverCharacteristicsResultBlock)(NSArray *characteristics, NSError *error);
typedef void(^MBRealtimeStepsResultBlock)(NSUInteger steps, NSError *error);
typedef void(^MBActivityDataHandleBlock)(NSArray *array, NSError *error);

typedef void(^MBPeripheralReadValueResultBlock)(NSData *data, NSError *error);
typedef void(^MBPeripheralWriteValueResultBlock)(NSError *error);


@interface MBPeripheral : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, getter=isConnected, readonly) BOOL connected;
@property (nonatomic, weak) MBCentralManager *centralManager;
@property (nonatomic, strong) CBService *service;

@property (nonatomic, strong, readonly) CBPeripheral *cbPeripheral;

- (instancetype)initWithPeripheral:(CBPeripheral *)cbPeripheral centralManager:(MBCentralManager *)manager;
- (void)discoverServices:(NSArray *)serviceUUIDs withBlock:(MBDiscoverServicesResultBlock)block;
- (void)discoverCharacteristics:(NSArray *)characteristicUUIDs forService:(CBService *)service withBlock:(MBDiscoverCharacteristicsResultBlock)block;

/**
 *  绑定用户信息
 *
 *  注意：根据测试，只有先绑定用户信息后，手环才能进行其他操作，否则手环会自动断开蓝牙连接。
 *
 *  @param user  用户信息(MBUserInfoModel)
 *  @param block 回调函数，返回绑定是否成功
 */
- (void)bindingWithUser:(MBUserInfoModel *)user withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  读取用户信息
 *
 *  @param block 回调函数，返回用户信息(MBUserInfoModel)或获取是否成功
 */
- (void)readUserInfoWithBlock:(void (^)(MBUserInfoModel *userInfo, NSError *error))block;

/**
 *  给手环发送消息(振动，如查找手环功能)
 *
 *  @param type  消息类型，Normal为振动，Call震动时间根据设置的来电提醒时长
 *  @param block 回调函数，返回发送消息是否成功
 */
- (void)sendNotificationWithType:(MBNotificationType)type withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  给手环发送消息(振动，如查找手环功能)
 *
 *  @param type  消息类型，Normal为振动，Call震动时间根据设置的来电提醒时长
 *  @param block 回调函数，返回发送消息是否成功
 */
- (void)makeBandVibrateWithBlock:(MBPeripheralWriteValueResultBlock)block;
- (void)rebootBandWithBlock:(MBPeripheralWriteValueResultBlock)block;
- (void)factoryResetBandWithBlock:(MBPeripheralWriteValueResultBlock)block;
/**
 *  停止消息(震动，一般用于停止Call类型消息)
 *
 *  @param block 回调函数，返回操作是否成功
 */
- (void)stopNotificationWithBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  获取手环设备名称
 *
 *  默认为"MI"
 *
 *  @param block 回调函数，返回设备名称或获取是否成功
 */
- (void)readDeviceName:(void (^)(NSString *name, NSError *error))block;

/**
 *  获取设备信息
 *
 *  @param block 回调函数，返回设备信息(MBDeviceInfoModel)或获取是否成功
 */
- (void)readDeviceInfoWithBlock:(void (^)(MBDeviceInfoModel *deviceInfo, NSError *error))block;

/**
 *  获取手环各种统计数据
 *
 *  @param block 回调函数，返回手环统计数据(MBStatisticsModel)或获取是否成功
 */
- (void)readStatisticsWithBlock:(void (^)(MBStatisticsModel *statistics, NSError *error))block;

/**
 *  获取手环电池信息
 *
 *  @param block 回调函数，返回电池信息(MBBatteryInfoModel)或获取是否成功
 */
- (void)readBatteryInfoWithBlock:(void (^)(MBBatteryInfoModel *batteryInfo, NSError *error))block;

/**
 *  设置(校准)设备时间
 *
 *  @param datetime 所设置的时候
 *  @param block    回调函数，返回设置是否成功
 */
- (void)setDateTimeInfo:(MBDateTimeModel *)datetime withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  获取设备时间
 *
 *  @param block 回调函数，返回设备时间(MBDateTimeModel)或获取是否成功
 */
- (void)readDateTimeWithBlock:(void (^)(MBDateTimeModel *dateTime, NSError *error))block;

/**
 *  读取LE单元参数
 *
 *  @param block 回调函数，返回设备LE参数(MBLEParamsModel)或读取是否成功
 */
- (void)readLEParamsWithBlock:(void (^)(MBLEParamsModel *leparams, NSError *error))block;

/**
 *  设置LE参数
 *
 *  @param leparams LE参数
 *  @param block    回调函数，返回设置是否成功
 */
- (void)setLEParams:(MBLEParamsModel *)leparams withBlock:(MBPeripheralWriteValueResultBlock)block;
- (void)setHighLEParamsWithBlock:(MBPeripheralWriteValueResultBlock)block;
- (void)setLowLEParamsWithBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  设置手环佩戴位置
 *
 *  @param position 佩戴位置，左手(脚)或右手(脚)
 *  @param block    返回函数，返回设置是否成功
 */
- (void)setWearPosition:(MBWearPosition)position withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  设置指示灯颜色
 *
 *  注意：手环指示灯并不是标准256级别色彩显示，而是6级别色彩，因此取色范围不变，颜色变化粒度较小（6x6x6）。
 *
 *  @param red   RGB模式中红色通道的值，取值范围0~6
 *  @param green RGB模式中绿色通道的值，取值范围0~6
 *  @param blue  RGB模式中蓝色通道的值，取值范围0~6
 *  @param blink 标记设置时手环指示灯是否闪烁
 *  @param block 回调函数，返回设置是否成功
 */
- (void)setColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue blink:(BOOL)blink withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  设置来电提醒时间
 *
 *  只有手环通过蓝牙连接到手机上时来电提醒才会生效。
 *
 *  @param interval 提醒时长，0表示关闭来电提醒，开启时间在1~30秒之间
 *  @param block    回调函数，返回设置是否成功
 */
- (void)setCallRemindInterval:(NSUInteger)interval withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  设置闹钟
 *
 *  @param info  闹钟信息(MBAlarmClockModel)
 *  @param block 回调函数，返回设置是否成功
 */
- (void)setAlarmClock:(MBAlarmClockModel *)info withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  获取实时步数
 *
 *  @param block 回调函数，返回实时步数或获取是否成功
 */
- (void)readRealtimeStepsWithBlock:(MBRealtimeStepsResultBlock)block;

/**
 *  订阅实时步数
 *
 *  实时返回当前步数变化
 *
 *  @param block 回调函数，返回实时步数或获取是否成功
 */
- (void)subscribeRealtimeStepsWithBlock:(MBRealtimeStepsResultBlock)block;

/**
 *  停止订阅实时步数通知
 *
 *  @param block 回调函数，返回操作是否成功
 */
- (void)stopSubscribeRealtimeStepsWithBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  设置步行目标
 *
 *  手环根据该目标判断当日是否达到目标(达到目标手环回震动提醒)，或在用户抬手时显示当日步数占目标步数比例，1一个指示灯标识1/3， 2个指示灯表示2/3，3个指示灯标识达到目标。
 *
 *  @param steps 目标步数
 *  @param block 回调函数，返回设置是否成功
 */
- (void)setGoalSteps:(NSUInteger)steps withBlock:(MBPeripheralWriteValueResultBlock)block;

/**
 *  获取活动信息
 *
 *  @param block 回调函数，返回活动信息(@[MBActivityDataFragmentModel, ...])或获取是否成功
 */
- (void)readActivityDataWithBlock:(MBActivityDataHandleBlock)block;

/**
 *  确认已接收完活动信息
 *
 *  TODO: 当前改时间存在偏移量，后续改进。
 *
 *  @param time  确认时间
 *  @param block 回调函数，返回操作是否成功
 */
- (void)confirmActivityDataWithDate:(NSDate *)time withBlock:(MBPeripheralWriteValueResultBlock)block;

@end
