//
//  ViewController.h
//  ljhUI
//
//  Created by mac on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ViewController : UIViewController

@property (strong,nonatomic)ProductModel *model;
@property (strong,nonatomic)NSArray *rowArr;
@property (strong,nonatomic)NSString *ID;

@end

