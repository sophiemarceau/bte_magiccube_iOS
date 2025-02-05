//
//  UserHeadView.h
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserHeadView : UIView
@property (copy,nonatomic) void(^btnClickBlock)(NSInteger clickIndex);
- (void)configWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
