//
//  KeepSignInInfo.m
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "KeepSignInInfo.h"
#import "FMDB.h"


#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
@implementation KeepSignInInfo
// 创建相关门店信息
+ (void)creatStoreInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"storeInfo"])
        {
            
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE storeInfo (userID text,ProjectId text,StoreId text,Code text,CreateDate text,CreateUserId text,DiDui text,Area text,Position text,POSM text,state text,ProductId text,Price text,ProductSmell text,AreaRatio text,Expand1 text,Expand2 text,Expand3 text,Expand4 text,Expand5 text,Expand6 text,Expand7 text,Expand8 text,Expand9 text,Expand10 text,Expand11 text,Expand12 text,Expand13 text,Expand14 text,Expand15 text,Expand16 text,Expand17 text,Expand18 text,Expand19 text,Expand20 text,Expand21 text,Expand22 text,Expand23 text,Expand24 text,Expand25 text,Expand26 text,Expand27 text,Expand28 text,Expand29 text,Expand30 text,Expand31 text,Expand32 text,Expand33 text,Expand34 text,Expand35 text,Expand36 text,Expand37 text,Expand38 text,Expand39 text,Expand40 text,Expand41 text,Expand42 text,Expand43 text,Expand44 text,Expand45 text,Expand46 text,Expand47 text,Expand48 text,Expand49 text,Expand50 text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
+ (void)keepStoreWithTheDictionary:(ProductModel *)model
{
    [self creatStoreInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        NSString *signInType    =model.DiDui;
        NSString *identifier    =model.Area;
        NSString *Createtime    =model.Position;
        NSString *storeName     =model.POSM;
        NSString *productId     =model.ProductId;
        NSString *price            =model.Price;
        NSString *productSmell   =model.ProductSmell;
        NSString *areaRatio=   model.AreaRatio;
        NSString *state=   model.MDstate;
        
        NSString *Expand1   =model.Expand1;
        NSString *Expand2    =model.Expand2;
        NSString *Expand3  = model.Expand3;
        NSString *Expand4           = model.Expand4;
        NSString *Expand5    = model.Expand5;
        NSString *Expand6    = model.Expand6;
        NSString *Expand7    = model.Expand7;
        NSString *Expand8    = model.Expand8;
        NSString *Expand9    = model.Expand9;
        NSString *Expand10    = model.Expand10;
        
        NSString *Expand11   =model.Expand11;
        NSString *Expand12    =model.Expand12;
        NSString *Expand13  = model.Expand13;
        NSString *Expand14           = model.Expand14;
        NSString *Expand15    = model.Expand15;
        NSString *Expand16    = model.Expand16;
        NSString *Expand17    = model.Expand17;
        NSString *Expand18    = model.Expand18;
        NSString *Expand19    = model.Expand19;
        NSString *Expand20    = model.Expand20;
        NSString *Expand21    = model.Expand21;
        NSString *Expand22    = model.Expand22;
        NSString *Expand23    = model.Expand23;
        NSString *Expand24    = model.Expand24;
        NSString *Expand25    = model.Expand25;
        
        
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into storeInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
    
}



+(NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/SignIn.sqlite"];
}

+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}
// 创建巡店拍照table
+ (void)creatPhotoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"photoInfo"])
        {
            [db executeUpdate:@"CREATE TABLE photoInfo (userID text,StoreCode text,selectType text,imageType text,identifier text,Longitude text,LocationTtime  text,Latitude text,Createtime text,imageUrl text)"];
        }
    }
    [db close];
}
//123
// 存储照片信息
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo
{
    [self creatPhotoTable];
    NSString *userID = [photoInfo objectForKey:@"userID"];
    NSString *storeCode = [photoInfo objectForKey:@"storeCode"];
    NSString *selectType = [photoInfo objectForKey:@"selectType"];
    NSString *imageType = [photoInfo objectForKey:@"imageType"];
    NSString *identifier = [photoInfo objectForKey:@"identifier"];
    NSString *Longitude = [photoInfo objectForKey:@"Longitude"];
    NSString *Latitude = [photoInfo objectForKey:@"Latitude"];
    NSString *LocationTtime = [photoInfo objectForKey:@"LocationTtime"];
    NSString *Createtime = [photoInfo objectForKey:@"Createtime"];
    NSString *imageUrl = [photoInfo objectForKey:@"imageUrl"];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into photoInfo(userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl];

            [db executeUpdate:insertPhotoStr];
        }
    }];
}

// 根据选的照片类型查询门店照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
//            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
                        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
//2333
// 根据选的照片类型查询产品照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and storecode = '%@' and userID like '%@'",selectType,storecode,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
//搜索单一产品信息
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    //    NSMutableArray * arr = [NSMutableArray array];
    ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where Code like '%@' and ProductId like '%@' and userID like '%@'",code,productCode,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                //                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                model.Expand9=[set stringForColumn:@"Expand9"];
                model.Expand10=[set stringForColumn:@"Expand10"];
                
                model.Expand11=[set stringForColumn:@"Expand11"];
                model.Expand12=[set stringForColumn:@"Expand12"];
                model.Expand13=[set stringForColumn:@"Expand13"];
                model.Expand14=[set stringForColumn:@"Expand14"];
                model.Expand15=[set stringForColumn:@"Expand15"];
                model.Expand16=[set stringForColumn:@"Expand16"];
                model.Expand17=[set stringForColumn:@"Expand17"];
                model.Expand18=[set stringForColumn:@"Expand18"];
                model.Expand19=[set stringForColumn:@"Expand19"];
                model.Expand20=[set stringForColumn:@"Expand20"];
                
                model.Expand21=[set stringForColumn:@"Expand21"];
                model.Expand22=[set stringForColumn:@"Expand22"];
                model.Expand23=[set stringForColumn:@"Expand23"];
                model.Expand24=[set stringForColumn:@"Expand24"];
                model.Expand25=[set stringForColumn:@"Expand25"];
                
                
                
                //                [arr addObject:model];
                
            }
        }
    }];
    //    return  arr;
    return model;
    
}
@end
