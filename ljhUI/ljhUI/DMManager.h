//
//  DMManager.h
//  pickersTest
//
//  Created by EssIOS on 16/1/13.
//  Copyright © 2016年 ljh. All rights reserved.
//
#import "FMDB.h"
#import "FMModel.h"
#import <Foundation/Foundation.h>

@interface DMManager : NSObject
+ (void)creatTableWith:(NSMutableDictionary *)dataDic andName:(NSString *)name;

+ (void)keepInfo:(NSMutableDictionary *)InfoDic withName:(NSString *)name;
@end
