//
//  TempImageTableViewCell.h
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TempImageTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
+ (CGFloat)cellDetailHeight;
- (void)configDict:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END