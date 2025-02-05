//
//  HomePageTableViewCell.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "NSString+Size.h"
@interface HomePageTableViewCell ()

@property (strong,nonatomic) UIImageView * picImageView;
@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel * subLabel;
@property (strong,nonatomic) UILabel * desLabel;
@property (strong,nonatomic) UILabel * numLabel;
@property (strong,nonatomic) UIView *redBgView;
@property (strong,nonatomic) UILabel * redBgLabel;

@end
@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = KBGCell;
        [self.contentView addSubview:self.bgImageView];
//        [self.bgImageView addSubview:self.picImageView];
        [self.bgImageView addSubview:self.titleLabel];
        [self.bgImageView addSubview:self.subLabel];
//        [self.bgImageView addSubview:self.desLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(173, 125.5, 162.5, 0.5)];
        lineView.backgroundColor = GrayMagicColor;
        [self.bgImageView addSubview:lineView];
        [self.bgImageView addSubview:self.numLabel];
        [self.bgImageView addSubview:self.redBgView];
    }
    return self;
}

- (void)configwidth:(NSDictionary *)dict{
//    NSLog(@"dict----->%@",dict);
   

    NSString *nameStr =  [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
//    CGFloat widh = [nameStr heightWithFont: UIFontMediumOfSize(16)constrainedToWidth:SCALE_W(110 +72.5)];
    CGFloat height = [nameStr heightWithFont: UIFontMediumOfSize(14) constrainedToWidth:SCALE_W(110 +72.5)];
    if (height < 42) {
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.origin.y, SCALE_W(96 + 40), height);
    }else{
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.origin.y, SCALE_W(96 + 40), 42);
    }
    self.titleLabel.text = nameStr;
    
//    @"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.subLabel.text = [dict objectForKey:@"subTitle"];
//    @"干燕窝原料印尼进口 CAIQ溯源";
    
    self.redBgLabel.text = @"去发卡";
//    [dict objectForKey:@"discountDesc"];
//    @"低至6折";
    NSString *salesVolume = [NSString stringWithFormat:@"%@",[dict objectForKey:@"maxCashBack"]];
     NSString *distribuionCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"distributionCount"]];
    NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(8.5),NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice = [NSString stringWithFormat:@"最高可赚%@元/张,已有%@人发卡",salesVolume,distribuionCount];
    NSString *price1 = salesVolume;
    NSString *price2 = distribuionCount;
    NSArray *attrArray = @[price1,price2];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
    
    self.numLabel.attributedText = attributestring;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
//    NSDictionary * attubtrDict1 = @{NSFontAttributeName:UIFontRegularOfSize(22),NSForegroundColorAttributeName:[UIColor whiteColor]};
//    NSString *deliveryPrice1 =@"代理价低至 3 折";
//    NSString *price1 = @"3";
//    NSAttributedString * attributestring1 = [MagicRichTool initWithString:deliveryPrice1 dict:attubtrDict1 subString:price1];
//    self.redBgLabel.attributedText = attributestring1;
}

+ (CGFloat)cellHeight{
    return 152 + 14;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 152)];
        _bgImageView.image = [UIImage imageNamed:@"homeCellBgIcon"];
//        _bgView.backgroundColor = KBGCell;
//        _bgView.layer.masksToBounds = YES;
//        _bgView.layer.cornerRadius = 16;
    }
    return _bgImageView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(35), SCALE_W(25), SCALE_W(100), SCALE_W(139 - 50))];
    }
    return _picImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(172, 25,SCALE_W(96 + 40), 42)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = Black1Color;
        _titleLabel.font = UIFontMediumOfSize(16);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(172, 72, SCALE_W(145 +27), 10)];
        _subLabel.textColor = Gray858Color;
        _subLabel.font = UIFontRegularOfSize(10);
        _subLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subLabel;
}

-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel= [[UILabel alloc] initWithFrame:CGRectMake(172.5, 84, 60, 12)];
        _desLabel.textAlignment= NSTextAlignmentLeft;
        _desLabel.textColor = RedMagicColor;
        _desLabel.font = UIFontLightOfSize(12);
        _desLabel.text = @"会员分销价";
    }
    return _desLabel;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(172, 133, SCALE_W(142 +40),8.5)];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = BlackMagicColor;
        _numLabel.font = UIFontRegularOfSize(8.5);
        _numLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _numLabel;
}

-(UILabel *)redBgLabel{
    if (_redBgLabel == nil) {
        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , self.redBgView.width, self.redBgView.height)];
        _redBgLabel.backgroundColor = [UIColor clearColor];
        _redBgLabel.textColor = [UIColor whiteColor];
        _redBgLabel.textAlignment = NSTextAlignmentCenter;
        _redBgLabel.font = UIFontRegularOfSize(14);
    }
    return _redBgLabel;
}

-(UIView *)redBgView{
    if (_redBgView == nil) {
        _redBgView = [[UILabel alloc] initWithFrame:CGRectMake(SCALE_W(173), 94.5 , SCALE_W(90), SCALE_W(23))];
        _redBgView.backgroundColor = RedMagicColor;
        _redBgView.layer.masksToBounds = YES;
        _redBgView.layer.cornerRadius = 11.5;
        [_redBgView addSubview:self.redBgLabel];
    }
    return _redBgView;
}
@end
