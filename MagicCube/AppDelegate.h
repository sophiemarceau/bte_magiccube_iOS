//
//  AppDelegate.h
//  MagicCube
//
//  Created by wanmeizty on 20/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
 @property(nonatomic,strong) MainViewController *mainVc;
- (void)setupKeyWindow;
@end

