//
//  NetWorking.h
//  PG
//
//  Created by EssIOS on 16/12/1.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
+(void)requestWithAddress:(NSString *)addrress andParameters:(NSDictionary *)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock;
;
@end
