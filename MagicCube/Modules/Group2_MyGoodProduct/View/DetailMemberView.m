//
//  DetailMemberView.m
//  MagicCube
//
//  Created by wanmeizty on 19/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DetailMemberView.h"
#import "DistributeLevelView.h"

@implementation DetailMemberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    MagicLabel * distributeTitlelabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(16), SCREEN_WIDTH - 20, SCALE_W(14))];
    distributeTitlelabel.text = @"分销提货价";
    distributeTitlelabel.textColor = Gray666Color;
    [self addSubview:distributeTitlelabel];
    
    CGFloat top = SCALE_W(35);
    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;
    for (int i = 0; i < 4; i ++) {
        
        DistributeLevelView * levelView = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * i), SCREEN_WIDTH, levelheight)];
        [levelView configTextRed:YES level:@"黄金会员" price:888 discount:@"8.5" grade:YES gradeText:@"升级白金会员" line:LinePositionShowUpDown];
        levelView.tag = 100 + i;
        [self addSubview:levelView];
    }
    
    UIView *linehead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    linehead.backgroundColor = BHHexColor(@"D9D9D9");
    [self addSubview:linehead];
}

-(void)setUpdata:(NSArray *)array{
    int index = 100;
    for (NSDictionary * dict in array) {
        CGFloat price = [[dict objectForKey:@"price"] floatValue];
        NSString * discount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"discount"]];
        NSString * name = [dict objectForKey:@"name"];
        DistributeLevelView * levelView = [self viewWithTag:index];
        [levelView configTextRed:YES level:name price:price discount:discount grade:YES gradeText:[NSString stringWithFormat:@"升级%@",name] line:LinePositionShowUpDown];
        index ++;
    }
}


@end