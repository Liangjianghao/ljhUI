//
//  NetWorking.m
//  PG
//
//  Created by EssIOS on 16/12/1.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetworking.h"
@implementation NetWorking

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
//    NSData *jsonData=[NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableContainers error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+(void)requestWithAddress:(NSString *)addrress andParameters:(NSDictionary *)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    NSString *URLString = addrress;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    

    
    [manager POST:URLString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        successBlock(jsonDict,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error);  //这里打印错误信息
        failedBlock(@"failed",nil);
    }];
    
}
@end
