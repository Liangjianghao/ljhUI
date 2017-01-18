//
//  tableViewController.m
//  ljhUI
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "tableViewController.h"
#import "ViewController.h"
#import "NetWorking.h"

@interface tableViewController ()
{
    NSMutableArray *dataArr;
    UITableView *myTableView;
}
@end

@implementation tableViewController

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
    /*
    NSString *path;
    path = [[NSBundle mainBundle] pathForResource:@"my" ofType:@"json"];
    NSData *fileData = [[NSData alloc]init];
    fileData = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    
   NSArray * basedataArr=[dic objectForKey:@"Data"];
    NSLog(@"%lu",(unsigned long)basedataArr.count);
    
    NSLog(@"%@",[basedataArr[0] objectForKey:@"Name"]);
    NSArray *tableArr=[basedataArr[0] objectForKey:@"Tables"];
    dataArr=tableArr;
    NSArray*  rowArr=[tableArr[0] objectForKey:@"Rows"];
*/
    //    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@"ios",@"username",@"e10adc3949ba59abbe56e057f20f883e",@"password",nil];
    //    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=login"];
    
//    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"userid",nil];
//    
//    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=loadconfig"];
//    
//    //    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"userid",nil];
//    //
//    //    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=loadstore"];
//    
//    [NetWorking requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
//        
//        NSArray * basedataArr=[result objectForKey:@"Data"];
//        NSLog(@"%lu",(unsigned long)basedataArr.count);
//        
//        NSLog(@"%@",[basedataArr[0] objectForKey:@"Name"]);
//        NSArray *tableArr=[basedataArr[0] objectForKey:@"Tables"];
//        dataArr=tableArr;
//        [myTableView reloadData];
//        
//    } andFailedBlock:^(NSString *result, NSError *error) {
//        
//    }];

    dataArr=_baseDataArr;
    [myTableView reloadData];
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
    ViewController *uiViewController =[[ViewController alloc]init];
    uiViewController.rowArr=[dataArr[indexPath.row] objectForKey:@"Rows"];
    uiViewController.ID=[dataArr[indexPath.row] objectForKey:@"ID"];
    [self.navigationController pushViewController:uiViewController animated:YES];
}

@end
