//
//  MemberLevelView.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MemberLevelView.h"

@interface MemberLevelView ()
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * levelLabel;
@property (assign,nonatomic) CGFloat imgW;
@property (strong,nonatomic) UIView * leftLine;
@property (strong,nonatomic) UIView * rightLine;
@end

@implementation MemberLevelView

- (instancetype)initWithFrame:(CGRect)frame imgW:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImgW:width];
    }
    return self;
}

- (void)createImgW:(CGFloat)width{
    if (width <= 0) width = SCALE_W(23);
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - width) * 0.5, (SCALE_W(42) - width) * 0.5, width, width)];
    [self addSubview:self.imgView];
    
    self.levelLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(42), self.frame.size.width, 14)];
    self.levelLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.levelLabel];
    
    self.leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, (SCALE_W(42) - width) * 0.5 + width * 0.5, (self.frame.size.width - width) * 0.5, 0.5)];
    self.leftLine.backgroundColor = LineD1GrayColor;
    [self addSubview:self.leftLine];
    
    self.rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - (self.frame.size.width - width) * 0.5, (SCALE_W(42) - width) * 0.5 + width * 0.5, (self.frame.size.width - width) * 0.5, 0.5)];
    self.rightLine.backgroundColor = LineD1GrayColor;
    [self addSubview:self.rightLine];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImgW:SCALE_W(23)];
    }
    return self;
}

- (void)configView:(NSString *)imgName levelText:(NSString *)levelStr LineLRPosition:(LineLRPosition)pos{
    self.imgView.image = [UIImage imageNamed:imgName];
    self.levelLabel.text = levelStr;
    
    if (pos == LinePositionShowLeftRight) {
        self.leftLine.hidden = NO;
        self.rightLine.hidden = NO;
    }else if(pos == LinePositionShowLeft){
        self.leftLine.hidden = NO;
        self.rightLine.hidden = YES;
    }else if(pos == LinePositionShowRight){
        self.leftLine.hidden = YES;
        self.rightLine.hidden = NO;
    }else{
        self.leftLine.hidden = YES;
        self.rightLine.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end