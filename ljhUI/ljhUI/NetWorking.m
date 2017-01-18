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
+(void)requestWithAddress:(NSString *)addrress andParameters:(NSDictionary *)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    NSString *URLString = addrress;
  
    NSDictionary *dic=parameter;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
 
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    requestSerializer
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet
//                                                         setWithObject:@"application/json"];
    
    [manager POST:URLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        //        AFURLResponseSerialization
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"responseObject %@",responseObject);
        
//        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

//        NSLog(@"jsonDict %@",jsonDict);
        
        successBlock(jsonDict,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error);  //这里打印错误信息
        failedBlock(@"failed",nil);
    }];

}
@end
