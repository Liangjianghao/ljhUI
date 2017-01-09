//
//  DMManager.m
//  pickersTest
//
//  Created by EssIOS on 16/1/13.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "DMManager.h"

@implementation DMManager
//创建表单
+ (void)creatTableWith:(NSMutableDictionary *)dataDic andName:(NSString *)name
{
    NSString *firstpart;
  
//    firstpart=[NSString stringWithFormat:@"CREATE TABLE %@ ",name];
    NSArray *keyArr=[dataDic allKeys];
    for (int i=0; i<keyArr.count; i++) {
        if (!firstpart) {
             firstpart=[NSString stringWithFormat:@"CREATE TABLE %@ (%@ text,",name,keyArr[i]];
        }
        else
        {
            if (i==keyArr.count-1) {
                firstpart=[firstpart stringByAppendingString:[NSString stringWithFormat:@"%@ text)",keyArr[i]]];
            }
            else{
        firstpart=[firstpart stringByAppendingString:[NSString stringWithFormat:@"%@ text,",keyArr[i]]];
            }
        }
        
    }
//    firstpart=[firstpart stringByAppendingString:secondPart];
    NSLog(@"firstpart\n%@",firstpart);
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:name])
        {

//            [db executeUpdate:firstpart];
//             [NSString stringWithFormat:@"CREATE TABLE %@ (userID text,speed text,timestamo text,strSysVers text,strModel text,verson text,latitude  text,longitude text,phoneModel text,strName text,strSysName text,strLocModel text, identifier text, networkType text, batteryLevel text, carrierName text)",name]];
//            NSLog(@"%@",firstpart);

            if (  [db executeUpdate:firstpart]) {
                NSLog(@"success");
            }
                else
                {
                    NSLog(@"failed");
                }
            }
        
    }
    [db close];
    
//    FMDatabase * db = [self getDB];
//    if ([db open])
//    {
//        if (![db tableExists:@"location"])
//        {
//            [db executeUpdate:@"CREATE TABLE location (userID text,speed text,timestamo text,strSysVers text,strModel text,verson text,latitude  text,longitude text,phoneModel text,strName text,strSysName text,strLocModel text, identifier text, networkType text, batteryLevel text, carrierName text)"];
//        }
//    }
//    [db close];
}
//存储表单详情
+ (void)keepInfo:(NSMutableDictionary *)InfoDic withName:(NSString *)name
{
    [self creatTableWith:InfoDic andName:name];
    
    FMDatabase * db = [self getDB];
    
    NSString *insertStr;
    NSString *firstStr;
    NSString *secondStr;
    NSString *thirdStr;
    if (!insertStr) {
        insertStr=[NSString stringWithFormat:@"insert into %@ (",name];
    }
    
    NSArray *keyArr=[InfoDic allKeys];
    for (int i=0; i<keyArr.count; i++) {
        if (!firstStr) {
            firstStr=[NSString stringWithFormat:@"%@,",keyArr[i]];
            thirdStr=[NSString stringWithFormat:@"('%@',",[InfoDic objectForKey:keyArr[i]]];
        }
        else{
            if (i==keyArr.count-1)
            {
                firstStr=[firstStr stringByAppendingString:[NSString stringWithFormat:@"%@) values",keyArr[i]]];
                thirdStr=[thirdStr stringByAppendingString:[NSString stringWithFormat:@"'%@')",[InfoDic objectForKey:keyArr[i]]]];
            }
            else
            {
                firstStr=[firstStr stringByAppendingString:[NSString stringWithFormat:@"%@,",keyArr[i]]];
                thirdStr=[thirdStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[InfoDic objectForKey:keyArr[i]]]];
            
            }
            
        }
       
    }
    firstStr=[firstStr stringByAppendingString:thirdStr];
    insertStr=[insertStr stringByAppendingString:firstStr];
//    NSLog(@"firstStr\n%@",insertStr);
    NSLog(@"%@",NSHomeDirectory());
    if ([db open])
    {
//        [db executeUpdate:@"insert into location (userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName];
//        [db executeQuery:insertStr];
        if ([db executeQuery:insertStr]) {
            NSLog(@"success");
            
        }
        else
        {
            NSLog(@"faield");
        }
    }
    [db close];
    
    
//    [self creatTableWith:InfoDic andName:@"123"];
    
    
//    FMDatabase * db = [self getDB];
//        NSDate * date = [NSDate date];
//        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        NSString *timestamo=[formatter stringFromDate:date];
    
//    NSString * userID       = [InfoDic objectForKey:@"UserName"];
//    NSString * speed        = [InfoDic objectForKey:@"Hobby"];
//    NSString * timestamo    = [InfoDic objectForKey:@"timestamo"];
//    NSString * strSysVers   = [InfoDic objectForKey:@"Password"];
//    NSString * strModel     = [InfoDic objectForKey:@"strModel"];
//    NSString * verson     = [InfoDic objectForKey:@"verson"];
//    NSString * latitude     = [InfoDic objectForKey:@"latitude"];
//    NSString * longitude    = [InfoDic objectForKey:@"longitude"];
//    NSString * phoneModel   = [InfoDic objectForKey:@"phoneModel"];
//    NSString * strName      = [InfoDic objectForKey:@"strName"];
//    NSString * strSysName   = [InfoDic objectForKey:@"strSysName"];
//    NSString * strLocModel  = [InfoDic objectForKey:@"strLocModel"];
//    NSString * identifier   = [InfoDic objectForKey:@"identifier"];
//    NSString * networkType  = [InfoDic objectForKey:@"networkType"];
//    NSString * batteryLevel = [InfoDic objectForKey:@"batteryLevel"];
//    NSString * carrierName  = [InfoDic objectForKey:@"carrierName"];
//    
//    if ([db open])
//    {
//        if ([db executeUpdate:@"insert into location (userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName]) {
//            NSLog(@"1");
//
//        }
//        else
//        {
//            NSLog(@"2");
//        }
//        
//
//    }
//    [db close];
    
}
+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}
+ (NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/baishi.sqlite"];
}
@end
