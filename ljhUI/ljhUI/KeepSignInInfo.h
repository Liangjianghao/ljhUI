//
//  KeepSignInInfo.h
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
@interface KeepSignInInfo : NSObject
/// 删除用户操作的照片


+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode;
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo;
+ (void)keepStoreWithTheDictionary:(ProductModel *)model;
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;

@end
