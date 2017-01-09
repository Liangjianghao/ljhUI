//
//  ljhSingleChooseBtn.m
//  ljhUI
//
//  Created by mac on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ljhSingleChooseBtn.h"

@implementation ljhSingleChooseBtn
{
    NSString *choice;
    
}
- (instancetype)mybuttonwithArr:(NSArray *)arr andTitle:(NSString *)title andMessage:(NSString *)message
{
    self.baseArr=arr;
    _alertTitle=title;
    _alertMessage=message;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAlert:)];
    [self addGestureRecognizer:tap];
    
    return self;
}

-(void)showAlert:(UITapGestureRecognizer *)tap{
    

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"单选" message:@"测试" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<_baseArr.count; i++) {
        UIAlertAction *corfirmAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",_baseArr[i]] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            [self setTitle:[NSString stringWithFormat:@"%@",_baseArr[i]] forState:UIControlStateNormal];
            choice=[NSString stringWithFormat:@"%@",_baseArr[i]];
            self.finishBlock(choice);

            
        }];
        [alertController addAction:corfirmAction];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [[self getCurrentViewController:self] presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark - 获取当前view的viewcontroller
- (UIViewController *)getCurrentViewController:(UIView *) currentView
{
    for (UIView* next = [currentView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
