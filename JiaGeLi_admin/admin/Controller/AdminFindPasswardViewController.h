//
//  AdminFindPasswardViewController.h
//  JiaGeLi_admin
//
//  Created by LTY on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
//#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^FindPasswardSuccess)(NSDictionary * dic);
@interface AdminFindPasswardViewController : UIViewController

@property(nonatomic,copy)FindPasswardSuccess findPasswardSuccess;
@end

NS_ASSUME_NONNULL_END
