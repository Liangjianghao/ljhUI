//
//  tableViewController.h
//  ljhUI
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *baseDataArr;
@end
