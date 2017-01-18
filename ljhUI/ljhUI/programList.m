//
//  programList.m
//  ljhUI
//
//  Created by mac on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "NetWorking.h"
#import "tableViewController.h"

#import "programList.h"


@interface programList ()
{
    NSMutableArray *dataArr;
    UITableView *myTableView;
}
@end

@implementation programList

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]init];
    
    [self loadData];
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
  
}


-(void)loadData
{
    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@3,@"userid",nil];
    
    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=loadconfig"];
    
    //    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"userid",nil];
    //
    //    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=loadstore"];
    
    [NetWorking requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
        
        NSArray * basedataArr=[result objectForKey:@"Data"];
//        NSLog(@"%lu",(unsigned long)basedataArr.count);
//        
//        NSLog(@"%@",[basedataArr[0] objectForKey:@"Name"]);
//        NSArray *tableArr=[basedataArr[0] objectForKey:@"Tables"];
        dataArr=basedataArr;
        [myTableView reloadData];
        
    } andFailedBlock:^(NSString *result, NSError *error) {
        
    }];
    
//    NSString * writePath = [NSString stringWithFormat:@"%@/Library/new.json",NSHomeDirectory()];
//    
//        NSData *fileData = [[NSData alloc]init];
//        fileData = [NSData dataWithContentsOfFile:writePath];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
//        dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
}

#pragma mark--tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        //        cell=[[[NSBundle mainBundle]loadNibNamed:@"BottleCell" owner:self options:nil]firstObject];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
    cell.textLabel.text=[dataArr[indexPath.row] objectForKey:@"Name"];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ViewController *uiViewController =[[ViewController alloc]init];
//    uiViewController.rowArr=[dataArr[indexPath.row] objectForKey:@"Rows"];
//    uiViewController.ID=[dataArr[indexPath.row] objectForKey:@"ID"];
//    [self.navigationController pushViewController:uiViewController animated:YES];
    
    tableViewController *tableList=[[tableViewController alloc]init];
    tableList.baseDataArr=[dataArr[indexPath.row] objectForKey:@"Tables"];
    [self.navigationController pushViewController:tableList animated:YES];
}

@end
