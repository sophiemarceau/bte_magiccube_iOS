//
//  HomeListViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HomeListViewController.h"
#import "HomePageTableViewCell.h"
#import "ProductDetailViewController.h"
#import "DistributeDetailViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "wechatLoginViewController.h"
#import "forgetViewController.h"
#import "ChangeDeviceViewController.h"

@interface HomeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger current_page,total_count;
    
}
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong) UITableView *baseTableView;

//@property (nonatomic,weak) id<JohnScrollViewDelegate>delegate;
@property (nonatomic,assign)NSInteger user_id;
@property(nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic,assign)NSInteger current_page;
@property (nonatomic,assign)NSInteger total_count;
@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSMutableArray array];
    [self.view addSubview:self.baseTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [self requestData];
}

-(void)requestData{
    current_page = 1;
    NSMutableDictionary *pramaDic = @{}.mutableCopy;
    [pramaDic setObject:self.tagid forKey:@"module"];
    [pramaDic setObject:@"1" forKey:@"pageNum"];
//    [pramaDic setObject:self.tagid forKey:@"pageSize"];
    [BTERequestTools requestWithURLString:kAppApiHomePageList parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---kAppApiHomePageList--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            Boolean isLastPage = [[[responseObject objectForKey:@"data"] objectForKey:@"lastPage"] boolValue];
            NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
            [self.listArray removeAllObjects];
            [self.listArray addObjectsFromArray:array];
            [self.baseTableView reloadData];

            if (isLastPage) {
                 [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
    }];
}

-(void)giveMeMoreData{
    current_page++;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)current_page];
    NSMutableDictionary *pramaDic = @{}.mutableCopy;
    [pramaDic setObject:self.tagid forKey:@"module"];
    [pramaDic setObject:page forKey:@"pageNum"];
    
    [BTERequestTools requestWithURLString:kAppApiHomePageList parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
        NMRemovLoadIng;
        NSLog(@"---kAppApiHomePageList--responseObject--giveMeMoreData->%@",responseObject);
        if (IsSucess(responseObject)) {
            Boolean isLastPage = [[[responseObject objectForKey:@"data"] objectForKey:@"lastPage"] boolValue];
            NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
            [self.listArray addObjectsFromArray:array];
            [self.baseTableView reloadData];
            if (isLastPage) {
                [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
        [self.baseTableView.mj_header endRefreshing];
        [self.baseTableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [self.listArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageItem *model = [self.listArray objectAtIndex:indexPath.row];
//    return  [model heightForRowWithisShow:model.isShow];
    return [HomePageTableViewCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"HomePageCell";
    HomePageTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell configwidth:[self.listArray objectAtIndex:indexPath.row]];
//    NSString *nameStr =  [NSString stringWithFormat:@"首页_%d",[self getRandomNumber:1 to:3]];
//    cell.bgImageView.image = [UIImage imageNamed:nameStr];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        DistributeDetailViewController *vc= [[DistributeDetailViewController alloc] init];
     NSDictionary *dic = [self.listArray objectAtIndex:indexPath.row];
     vc.snStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sn"]];

    
//    if (indexPath.row == 0) {
//        wechatLoginViewController *vc= [[wechatLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 1) {
//        LoginViewController *vc= [[LoginViewController alloc] init];
//        vc.loginStyle = pwdLogin;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 2) {
//        forgetViewController *vc= [[forgetViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 3) {
//        ChangeDeviceViewController *vc= [[ChangeDeviceViewController alloc] init];
//        vc.changeDeviceStyle = changeByCodeMessage;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if ([self.questionArray count] == 0) {
//
//    }else{
//        QuestDetailViewController *vc = [[QuestDetailViewController alloc] init];
//        NewQuestionCellFrame *cellFrame =  [self.questionArray objectAtIndex:indexPath.row];
//        vc.question_id = cellFrame.homequestionModel.question_id;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)acceptMsg:(NSNotification *)notification{
//        NSLog(@"acceptMsg----%@",notification);
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        self.canScroll = YES;
        self.baseTableView.scrollEnabled = YES;
        self.baseTableView.showsVerticalScrollIndicator = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollView----%f",scrollView.contentOffset.y);
    if (self.DidScrollBlock) {
        self.DidScrollBlock(scrollView.contentOffset.y);
    }
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
        [scrollView setContentOffset:CGPointZero];
        self.canScroll = NO;
        self.baseTableView.showsVerticalScrollIndicator = NO;
        self.baseTableView.scrollEnabled = NO;
    }
}

-(UITableView *)baseTableView{
    if (_baseTableView == nil) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scrollViewHeight)];
        _baseTableView.dataSource = self;
        _baseTableView.backgroundColor = [UIColor whiteColor];
        _baseTableView.delegate = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTableView.estimatedRowHeight = 80;
        _baseTableView.scrollEnabled = YES;
        _baseTableView.bounces = YES;
        
        UIView *headerView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 14.5)];
        headerView.backgroundColor = [UIColor whiteColor];
        _baseTableView.tableHeaderView =  headerView;
        //        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        //        _baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            [self loadData];
        //        }];
        //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
         WS(weakSelf)
        MJRefreshBackNormalFooter *allfooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf giveMeMoreData];
        }];
        _baseTableView.mj_footer = allfooter;
        _baseTableView.mj_footer.ignoredScrollViewContentInsetBottom = HOME_INDICATOR_HEIGHT;
    }
    return _baseTableView;
}
@end

