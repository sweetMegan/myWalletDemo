//
//  BaseUtil.h
//  WashingStore
//
//  Created by yager on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface BaseUtil : NSObject


+ (id)controllerInStoryboard:(NSString *)storyboard withIdentifier:(NSString *)identifier;


+ (BOOL)isDeviceiPhone;
+ (BOOL)isDeviceiPhone4;
+ (BOOL)isDeviceRetina;
+ (BOOL)isDeviceiPhone5;

+ (void)alertWithTitle:(NSString *)title msg:(NSString *)msg;

+ (BOOL)emptyLocation:(CLLocation *)location;

+ (BOOL)isEmpty:(NSString*)str;
+ (BOOL)isEmptyOrNull:(NSString *)str;
+ (BOOL)isNull:(NSObject *)obj;

+ (BOOL)isEmptyLoction:(NSString *)locInfo;
+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height;
+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height cornerRadius:(CGFloat)radius;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//协议数据操作
+ (BOOL)removeCacheData;
+ (BOOL)removeCacheItem:(NSString *)protocolName;
+ (BOOL)isExistProtocolData:(NSString *)protocolName;
+ (BOOL)saveProtocolData:(NSData *)data withName:(NSString *)protocolName;
+ (NSData *)readProtocolData:(NSString *)protocolName;

//电话操作
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string;
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber;
+ (void)callAndBack:(NSString *)phoneNum;
+ (void)callAndBackWeb:(NSString *)phoneNum;


//获取UUID
+ (NSString *)appleIFV;
+(NSString*)dateStringFromDate:(NSString*)dateString;
//将view转image
+(UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
/**
 *设备别名
 */
+(NSString *)deviceName;
/**
 *app 版本号
 */
+(NSString *)appVersion;
/**
 *系统版本
 */
+(NSString *)deviceVersion;
/**
 *获取字符串string中某个字符出现的次数
 */
+(NSInteger)getCountOfCharater:(NSString *)charater InString:(NSString *)searchString;
/**
 *生成32位随机数
 */
+(NSString *)ret32bitString;

@end
