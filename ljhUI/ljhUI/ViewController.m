//
//  ViewController.m
//  ljhUI
//
//  Created by mac on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define CONTROLHEIGHT 60
#define baseHeight 0

#import "ViewController.h"
#import "DBManager.h"
#import "KeepSignInInfo.h"
#import "ljhCheckbox.h"
#import "ljhSingleChooseBtn.h"
@interface ViewController ()
{
    NSMutableArray *dataArr;
    NSMutableArray *imgArr;
    
    int count;
    int count2;
    int count3;
    
    int pickerTag;
    int takePhotoTag;
    NSString *smellStr;
    NSMutableArray *photoArr;
    NSMutableDictionary     * _keepInfo;
    int viewheight;
    
    NSMutableArray *bigPictures;
    UIScrollView *otherScrollVC;
    UIScrollView *scrollV;

    NSMutableDictionary *baseText;
    NSMutableDictionary *baseDetailTest;
    
    UIImagePickerController * imagePicker;

//    NSArray *rowArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    baseText=[[NSMutableDictionary alloc]init];
    baseDetailTest=[[NSMutableDictionary alloc]init];
    count=0;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardDismiss:)];
    [self.view addGestureRecognizer:tap];
    [self loadData];
    [self uiConfig];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)keyBoardDismiss:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}
-(void)loadData
{
    
    NSString *path;
    path = [[NSBundle mainBundle] pathForResource:@"my" ofType:@"json"];
    NSData *fileData = [[NSData alloc]init];
    fileData = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];

    dataArr=[dic objectForKey:@"Data"];
    NSLog(@"%lu",(unsigned long)dataArr.count);
    
    NSLog(@"%@",[dataArr[0] objectForKey:@"Name"]);
    NSArray *tableArr=[dataArr[0] objectForKey:@"Tables"];
    
//    _rowArr=[tableArr[0] objectForKey:@"Rows"];
    
//    count=dataArr.count;
    
//    for (int i=0; i<dataArr.count; i++) {
//        [baseText setObject:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ControlName"]] forKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
//        [baseDetailTest setObject:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ControlValue"]] forKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
//  
//    }
    NSLog(@"baseText\n%@",baseText);
    //    NSLog(@"detail%@\n",baseDetailTest);
    NSDictionary *dictionary=[DBManager selectInfo:nil];
    NSLog(@"dictionary\%@",dictionary);
}
-(void)uiConfig
{
    scrollV=[[UIScrollView alloc]init];
    scrollV.frame=CGRectMake(0, 0, WIDTH,HEIGHT);
    scrollV.contentSize=CGSizeMake(WIDTH, viewheight);
    scrollV.userInteractionEnabled=YES;
    [self.view addSubview:scrollV];
//    UITapGestureRecognizer *dimissTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardDismiss:)];
//    [scrollV addGestureRecognizer:dimissTap];
    
    for (int j=0; j<_rowArr.count; j++) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(0, viewheight, WIDTH, 40);
        label.text=[NSString stringWithFormat:@"%@",[_rowArr[j] objectForKey:@"Name"]];
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor grayColor];
        [scrollV addSubview:label];
        viewheight+=60;
        NSArray *lineArr=[_rowArr[j] objectForKey:@"Contorls"];
        
        for (int i=0; i<lineArr.count; i++) {
            
            count++;

            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(10, viewheight, 100, CONTROLHEIGHT);
            label.text=[NSString stringWithFormat:@"%@",[lineArr[i] objectForKey:@"Name"]];
            label.textAlignment=NSTextAlignmentCenter;
            [scrollV addSubview:label];
            
            //            viewheight+=80;
            
            if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Input"]) {
                
                UITextField *textField=[[UITextField alloc]init];
                textField.frame=CGRectMake(160, viewheight, WIDTH/2-10, 40);
                textField.placeholder=[NSString stringWithFormat:@"%@",[lineArr[i] objectForKey:@"Name"]];
                textField.delegate=self;
                //                textField.tag=101+i;
                textField.tag=[[lineArr[i] objectForKey:@"ID"] intValue];
                textField.borderStyle=UITextBorderStyleRoundedRect;
                [scrollV addSubview:textField];
                viewheight+=60;
                
            }
            else if([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Select"]) {
                
                ljhSingleChooseBtn *btn=[[ljhSingleChooseBtn alloc]init];
//                NSString *Str=[baseDetailTest objectForKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
//                NSLog(@"%@",[NSString stringWithFormat:@"%@",[rowArr[i] objectForKey:@"ID"]]);
//                
//                NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[self dicToArray:Str]];
                
                NSArray *myarr=@[@"是",@"否"];
                [btn mybuttonwithArr:myarr andTitle:@"单选" andMessage:@"测试"];
                [btn setFinishBlock:^(NSString *result) {
                    
                }];
                btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
                [btn setTitle:@"单选" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                btn.tag=[[lineArr[i] objectForKey:@"ID"] intValue];
                [scrollV addSubview:btn];
                viewheight+=60;
                
                
            }
            
            else if([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"CheckBox"]) {
                
                ljhCheckbox *btn=[[ljhCheckbox alloc]init];
//                NSString *Str=[baseDetailTest objectForKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
//                NSLog(@"%@",[NSString stringWithFormat:@"%@",[rowArr[i] objectForKey:@"ID"]]);
//                
//                NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[self dicToArray:Str]];
                
                NSArray *myarr=@[@"位置一",@"位置二"];

                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [btn mybuttonwithArr:myarr andTitle:@"多选" andMessage:@"测试"];
                [btn setFinishBlock:^(NSString *result) {
                    
                }];
                btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
                [btn setTitle:@"多选" forState:UIControlStateNormal];
                btn.tag=[[lineArr[i] objectForKey:@"ID"] intValue];
                [scrollV addSubview:btn];
                viewheight+=60;
                
                
            }
             /*
            else if([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"日期选择框"]) {
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
                [btn setTitle:@"日期选择" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //                btn.tag=101+i;
                btn.tag=[[rowArr[i] objectForKey:@"ID"] intValue];
                [scrollV addSubview:btn];
                viewheight+=80;
                
                
            }
             */
            else if([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Camara"]) {
                
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(WIDTH/2+10,viewheight, 40, 40);
                //                [btn setTitle:@"照片选择" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
                            [btn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                //            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
//                btn.backgroundColor=[UIColor blackColor];
                
                btn.tag=101+i;
                takePhotoTag=btn.tag;
                [scrollV addSubview:btn];
                
                [self baseConfigWithTag:btn.tag];
                
                viewheight+=160;
                
            }
            else
            {
                NSLog(@"other");
                viewheight+=60;

            }

        }
    }
    
    /*
    for (int i=0; i<count; i++) {
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(10, viewheight, 100, CONTROLHEIGHT);
        label.text=[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ControlLabel"]];
        label.textAlignment=NSTextAlignmentCenter;
        [scrollV addSubview:label];
        
        //            viewheight+=80;
        
        if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"文本框"]) {
            
            UITextField *textField=[[UITextField alloc]init];
            textField.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
            textField.placeholder=[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ControlLabel"]];
            textField.delegate=self;
            //                textField.tag=101+i;
            textField.tag=[[dataArr[i] objectForKey:@"ID"] intValue];
            [scrollV addSubview:textField];
            viewheight+=80;
            
        }
        else if([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"单选框"]) {
            
            ljhSingleChooseBtn *btn=[[ljhSingleChooseBtn alloc]init];
            NSString *Str=[baseDetailTest objectForKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]);
            
            NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[self dicToArray:Str]];
            [btn mybuttonwithArr:arr andTitle:@"单选" andMessage:@"测试"];
            [btn setFinishBlock:^(NSString *result) {
                
            }];
            btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
            [btn setTitle:@"单选" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
            btn.tag=[[dataArr[i] objectForKey:@"ID"] intValue];
            [scrollV addSubview:btn];
            viewheight+=80;
            
            
        }
        else if([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"多选框"]) {
            
            ljhCheckbox *btn=[[ljhCheckbox alloc]init];
            NSString *Str=[baseDetailTest objectForKey:[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"ID"]]);
            
            NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[self dicToArray:Str]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [btn mybuttonwithArr:arr andTitle:@"多选" andMessage:@"测试"];
            [btn setFinishBlock:^(NSString *result) {
                
            }];
            btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
            [btn setTitle:@"多选" forState:UIControlStateNormal];
            btn.tag=[[dataArr[i] objectForKey:@"ID"] intValue];
            [scrollV addSubview:btn];
            viewheight+=80;

            
        }
        else if([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"日期选择框"]) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(160, viewheight, 160, CONTROLHEIGHT);
            [btn setTitle:@"日期选择" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //                btn.tag=101+i;
            btn.tag=[[dataArr[i] objectForKey:@"ID"] intValue];
            [scrollV addSubview:btn];
            viewheight+=80;
            
            
        }
        else if([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"照片选择"]) {
            
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(110,viewheight, CONTROLHEIGHT, CONTROLHEIGHT);
            //                [btn setTitle:@"照片选择" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            btn.backgroundColor=[UIColor blackColor];

            btn.tag=101+i;
            takePhotoTag=btn.tag;
            [scrollV addSubview:btn];
            
            [self baseConfigWithTag:btn.tag];
            
            viewheight+=160;
            
        }
        else
        {
            NSLog(@"other");
        }
    }
*/
    imagePicker = [[UIImagePickerController alloc] init];//初始化
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;//设置可编辑
    
  
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=CGRectMake(0, 0,40, 40);
//    //    [btn setTitle:@"title" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    //    [btn setBackgroundImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
//    [btn setTitle:@"保存" forState:UIControlStateNormal];
//    //    [btn setImage:[UIImage imageNamed:@"icon-40"] forState:UIControlStateNormal];
//    
//    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    //    [self.view addSubview:btn];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton *savebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.frame=CGRectMake(10, viewheight, WIDTH-20, 40);
    [savebtn setTitle:@"保存数据" forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    savebtn.layer.cornerRadius=10;
    savebtn.clipsToBounds=YES;
    [savebtn addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    [scrollV addSubview:savebtn];
    
    scrollV.contentSize=CGSizeMake(WIDTH, viewheight+50);
    ProductModel *oneModel=[KeepSignInInfo selectOneProductDetailTable:_ID andProCode:_model.ProductId];
    count3=0;
    
    for (int j=0; j<_rowArr.count; j++) {
        NSArray *lineArr=[_rowArr[j] objectForKey:@"Contorls"];
        for (int i=0; i<lineArr.count; i++) {
            count3++;
            
            if ([oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",i+1]]) {
            
            if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Input"]) {
                UITextField *tf=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
                
                tf.text=[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",count3]];
            }
            else if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Select"])
            {
                UIButton *btn=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
                
//                [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",count2]];
                [btn setTitle:[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",count3]] forState:UIControlStateNormal];

            }
                
            else if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"CheckBox"])
                    {
                        UIButton *btn=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
            
                        [btn setTitle:[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",count3]] forState:UIControlStateNormal];
                    }
            //        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"照片选择"])
            //        {
            //            
            //        }
            else{
                
            }
        }
        }
    }
    /*
    for (int i=0; i<count; i++) {
        if ([oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",i]]) {
            
      
        if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"文本框"]) {
    
            UITextField *tf=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
            tf.text=[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",i]];
//                        [_model setValue:tf.text forKey:[NSString stringWithFormat:@"expand%d",i]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"单选框"])
        {
            UIButton *btn=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
            [btn setTitle:[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",i]] forState:UIControlStateNormal];
            
//            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",i]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"多选框"])
        {
            UIButton *btn=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
            [btn setTitle:[oneModel valueForKey:[NSString stringWithFormat:@"Expand%d",i]] forState:UIControlStateNormal];
//            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",i]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"照片选择"])
        {
            
        }
        else{
            
        }
        }
        
    }
     */
    

}
-(void)saveData:(UIButton*)btns
{
    count2=0;
    if (!_model) {
        _model=[[ProductModel alloc]init];
    }
    _model.Code=_ID;
    
    for (int j=0; j<_rowArr.count; j++) {
        NSArray *lineArr=[_rowArr[j] objectForKey:@"Contorls"];
        for (int i=0; i<lineArr.count; i++) {
            count2++;
        
        if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Input"]) {
            UITextField *tf=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
            
            [_model setValue:tf.text forKey:[NSString stringWithFormat:@"expand%d",count2]];
        }
        else if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Select"])
        {
            UIButton *btn=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
            
            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",count2]];
        }
            
        else if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"CheckBox"])
        {
            UIButton *btn=[self.view viewWithTag:[[lineArr[i] objectForKey:@"ID"] intValue]];
            
            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",count2]];
        }
//        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"照片选择"])
//        {
//            
//        }
        else{
            
        }
    }
    }

    /*
    for (int i=0; i<count; i++) {
        
        if ([[lineArr[i] objectForKey:@"ControlType"]isEqualToString:@"Input"]) {
            UITextField *tf=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
                             
            [_model setValue:tf.text forKey:[NSString stringWithFormat:@"expand%d",i+1]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"单选框"])
        {
            UIButton *btn=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
            
            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",i+1]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"多选框"])
        {
            UIButton *btn=[self.view viewWithTag:[[dataArr[i] objectForKey:@"ID"] intValue]];
            
            [_model setValue:btn.titleLabel.text forKey:[NSString stringWithFormat:@"expand%d",i+1]];
        }
        else if ([[[dataArr[i] objectForKey:@"ControlType"] objectForKey:@"Name"]isEqualToString:@"照片选择"])
        {
        
        }
        else{
        
        }
        
    }
     */
    
//    isSaved=YES;
//    
//    ProductModel *model=  [KeepSignInInfo selectMDDetailTable:_model.Code];
//    if (model.Code) {
//        NSLog(@"存在,更新");
//        [KeepSignInInfo updataMDWithTheDictionary:_model];
//    }
//    else
//    {
//        NSLog(@"不存在,创建");
        [KeepSignInInfo keepStoreWithTheDictionary:_model];
//    }
    
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
//字典转数组 后台json数据为str 若为数据不需要
-(NSMutableArray *)dicToArray:(NSString *)str
{
    NSLog(@"%@",str);
    NSMutableArray *array =[[NSMutableArray alloc]initWithArray:[str componentsSeparatedByString:@"，"]]; //从","中分隔成个数组
    NSLog(@"array:%@",array);
    return array;
    
}
-(void)baseConfigWithTag:(int)tag
{
    NSLog(@"tag值%d",tag);
    NSLog(@"%d",viewheight);
    UIScrollView  *mysmallScr=[self.view viewWithTag:tag+100];
    int height=mysmallScr.frame.origin.y;
    NSLog(@"height %d",height);
    //    [mysmallScr removeFromSuperview];
    
    UIScrollView  *newsmallScr=[[UIScrollView alloc]init];
    newsmallScr.frame=CGRectMake(5, height==0?viewheight+60:height, WIDTH, 90);
    
    photoArr=[KeepSignInInfo selectPhotoWithType:[NSString stringWithFormat:@"%d",takePhotoTag] andId:_ID];
    
    newsmallScr.tag=tag+100;
    // smallScr.backgroundColor=[UIColor grayColor];
    newsmallScr.contentSize=CGSizeMake(90 *photoArr.count+80, 90);
    //        newsmallScr.backgroundColor=[UIColor redColor];
    [scrollV addSubview:newsmallScr];
    UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Photobtn.frame=CGRectMake(0, 20, 60, 60);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, viewheight, 100, 40);
    //    label.backgroundColor=[UIColor redColor];
    label.text=[NSString stringWithFormat:@"门头照1张:"];
    label.textAlignment=NSTextAlignmentCenter;
    //    [scrollV addSubview:label];
    
    [Photobtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    Photobtn.tag=3001;
    [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    //    [newsmallScr addSubview:Photobtn];
    if (photoArr.count>0) {
        for (int j=0; j<photoArr.count; j++) {
 
            UIImageView *imgV=[[UIImageView alloc]init];
            imgV.frame=CGRectMake(90*j, 0, 80, 80);
            
            [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photoArr[j]]]];
            imgV.backgroundColor=[UIColor redColor];
            imgV.backgroundColor=[UIColor grayColor];
            UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
            [imgV addGestureRecognizer:longPress];
            imgV.userInteractionEnabled=YES;
            [newsmallScr addSubview:imgV];
            
        }
    }
}
-(void)takePhoto:(UIButton *)btn
{
    
    takePhotoTag=btn.tag;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction *destructiveTwoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:destructiveTwoAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
// 相机代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

    [picker dismissViewControllerAnimated:YES completion:^{
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        UIImage * image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
        //        time = resultStr;
        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
        //        [_loMar stopUpdatingLocation];
        [imgArr addObject:imageUrl];
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
        //        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
        //        [self useImage:imageDic];
        
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        
        NSString * imageType = @"JPG";
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString * Createtime = [formatter stringFromDate:date];
        _keepInfo=[[NSMutableDictionary alloc]init];
        [_keepInfo setValue:[NSString stringWithFormat:@"%d",takePhotoTag] forKey:@"selectType"];
        
        [_keepInfo setValue:_ID   forKey:@"storeCode"];
        [_keepInfo setValue:userID      forKey:@"userID"];
        [_keepInfo setValue:identifier  forKey:@"identifier"];
        [_keepInfo setValue:imageType   forKey:@"imageType"];
        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
        //        StoreMD * store = [keepLocationInfo selectLocationLastData];
        //        [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
        //        [_keepInfo setValue:store.Longitude forKey:@"Longitude"];
        //        [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
        [self useImage:imageDic];
    }];
    
    
}
- (void)useImage:(NSDictionary *)imageDic
{
    UIImage * image = [imageDic objectForKey:@"image"];
    NSString * imageUrl = [imageDic objectForKey:@"imageurl"];
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),imageUrl];
    //对图片进行压缩
    CGSize newSize = CGSizeMake(768, 1024);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //照片写入本地存储
    NSData * photoData = UIImageJPEGRepresentation(newImage,1);
    [photoData writeToFile:writePath atomically:NO];
    
    UITableView *tableView=(UITableView *)[self.view viewWithTag:takePhotoTag];
    //    [tableView reloadData];
    [self imgUiConfigWithTag:takePhotoTag];
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存到相册失败" ;
    }else{
        msg = @"保存到相册成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    
    [UIView animateWithDuration:8 animations:^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
}

-(void)toDetail:(UITapGestureRecognizer *)tap
{

    bigPictures=[KeepSignInInfo selectPhotoWithType:[NSString stringWithFormat:@"%ld",tap.view.superview.tag-100] andId:_ID];
    self.tabBarController.tabBar.hidden = YES;
    otherScrollVC=[[UIScrollView alloc]init];
    otherScrollVC.frame=CGRectMake(0, 104, WIDTH, WIDTH*1.3);
    otherScrollVC.contentSize=CGSizeMake(WIDTH*bigPictures.count, WIDTH*1.3);
    NSLog(@"count-->>%lu",(unsigned long)bigPictures.count);
    otherScrollVC.pagingEnabled=YES;
    for (int i=0; i<bigPictures.count; i++) {
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(10+WIDTH*i, 0, WIDTH-20,  WIDTH*1.3);
        [otherScrollVC addSubview:imgV];
        imgV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),bigPictures[i]]];
        imgV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        [imgV addGestureRecognizer:tap];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view addSubview:otherScrollVC];
        
    }];
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [otherScrollVC removeFromSuperview];
    
}
-(void)imgUiConfigWithTag:(int)tag
{
    NSLog(@"tag值%d",tag);
    NSLog(@"%d",viewheight);
    UIScrollView  *mysmallScr=[self.view viewWithTag:tag+100];
    int height=mysmallScr.frame.origin.y;
    NSLog(@"height %d",height);
    [mysmallScr removeFromSuperview];
    
    UIScrollView  *newsmallScr=[[UIScrollView alloc]init];
    newsmallScr.frame=CGRectMake(5, height==0?viewheight+60:height, WIDTH-50, 90);
    
    photoArr=[KeepSignInInfo selectPhotoWithType:[NSString stringWithFormat:@"%d",takePhotoTag] andId:_ID];
    
    newsmallScr.tag=tag+100;
    // smallScr.backgroundColor=[UIColor grayColor];
    newsmallScr.contentSize=CGSizeMake(90 *photoArr.count+80, 90);
    //    newsmallScr.backgroundColor=[UIColor redColor];
    [scrollV addSubview:newsmallScr];
    UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Photobtn.frame=CGRectMake(0, 20, 60, 60);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, viewheight, 100, 40);
    //    label.backgroundColor=[UIColor redColor];
    label.text=[NSString stringWithFormat:@"门头照1张:"];
    label.textAlignment=NSTextAlignmentCenter;
    //    [scrollV addSubview:label];
    
    [Photobtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    Photobtn.tag=3001;
    [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    //    [newsmallScr addSubview:Photobtn];
    if (photoArr.count>0) {
        for (int j=0; j<photoArr.count; j++) {
            
            
            
            UIImageView *imgV=[[UIImageView alloc]init];
            imgV.frame=CGRectMake(90*j, 0, 80, 80);
            
            [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photoArr[j]]]];
            //        imgV.backgroundColor=[UIColor redColor];
            imgV.backgroundColor=[UIColor grayColor];
            UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
            [imgV addGestureRecognizer:longPress];
            imgV.userInteractionEnabled=YES;
            [newsmallScr addSubview:imgV];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
