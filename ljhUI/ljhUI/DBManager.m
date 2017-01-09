//
//  DBManager.m
//  pickersTest
//
//  Created by EssIOS on 16/1/14.
//  Copyright © 2016年 ljh. All rights reserved.
//
#import "FMDB.h"
#import "DBManager.h"

@implementation DBManager

+ (void)createInfoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"test"])
        {
            [db executeUpdate:@"CREATE TABLE test (ProejctId text,StoreId text,StoreCode text,CreateDate text,CreateUserId text,FormId text,ItemName  text,ItemValue text,expand1 text,expand2 text,expand3 text,expand4 text,expand5 text,expand6 text)"];
        }
    }
    [db close];
}
//查询相关信息
+(NSMutableDictionary *)selectInfo:(NSString *)str
{
    NSMutableDictionary *dic;
    dic=[[NSMutableDictionary alloc]init];

    FMDatabase * db = [self getDB];
    
    if ([db open])
    {
//        [db executeUpdate:@"select *from test"];
//        if (db ) {
//            <#statements#>
//        }
        FMResultSet *set = [db executeQuery:@"select *from test"];
        while ([set next])
        {
            
            NSLog(@"%@ %@",[set stringForColumn:@"ItemValue"],[set stringForColumn:@"ItemName"]);
            [dic setValue:[set stringForColumn:@"ItemValue"] forKey:[set stringForColumn:@"ItemName"]];
            
            NSLog(@"%@",dic);

     

        }
        [set close];
    }
    [db close];
            NSLog(@"%@",dic);    
    return dic;
}
// 存储相关信息
+ (void)keeInfo:(FMModel *)model
{
    [self createInfoTable];

    FMDatabase * db = [self getDB];
   
    if ([db open])
    {
        [db executeUpdate:@"insert into test (ProejctId,StoreId,StoreCode,CreateDate,CreateUserId,FormId,ItemName,ItemValue,expand1,expand2,expand3,expand4,expand5,expand6) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.ProejctId,model.StoreId,model.StoreCode,model.CreateDate,model.CreateUserId,model.FormId,model.ItemName,model.ItemValue,@"",@"",@"",@"",@"",@""];
    }
    [db close];
    
}
+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}
+ (NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/test.sqlite"];
}
@end
