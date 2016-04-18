//
//  FoodController.m
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

//获取设备屏幕尺寸
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

//左边列表的宽度
#define LeftTableWidth 100

#import "FoodController.h"
//model
#import "FoodData.h"
#import "FoodModel.h"
//view
#import "FoodLeftCell.h"
#import "FoodRightCell.h"

@interface FoodController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSMutableArray *foodDataSource;
@property (nonatomic, assign, getter=isRolling) BOOL isRoll;
@end

@implementation FoodController

- (NSMutableArray *)foodDataSource
{
    if (!_foodDataSource) {
        self.foodDataSource = [NSMutableArray array];
    }
    return _foodDataSource;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isRoll = NO;
    //创建视图
    [self setupLeftTabelView];
    [self setupRightTableView];
    //获取数据
    [self getFoodData];
}

#pragma mark - 创建视图
- (void)setupLeftTabelView
{
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, LeftTableWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
}


- (void)setupRightTableView
{
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(LeftTableWidth, 64, ScreenWidth - LeftTableWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    rightTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:rightTableView];
    self.rightTableView = rightTableView;
}

#pragma mark - 获取数据
- (void)getFoodData
{
    NSArray *foods = [FoodData foodData];
    //字典转模型
    for (NSDictionary *food in foods) {
        FoodModel *foodM = [FoodModel initWithDict:food];
        [self.foodDataSource addObject:foodM];
    }
    FoodModel *firstM = [self.foodDataSource firstObject];
    NSLog(@"firstTitle -- %@",firstM.title);
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.leftTableView == tableView) {
        return 1;
    }else{
        return self.foodDataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.leftTableView == tableView) {
        return self.foodDataSource.count;
    }else{
        FoodModel *foodM = self.foodDataSource[section];
        return foodM.foodSubs.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        FoodLeftCell *cell = [FoodLeftCell cellWithTableView:tableView];
        FoodModel *foodM = self.foodDataSource[indexPath.row];
        cell.textLabel.text = foodM.title;
        return cell;
    }else{
        FoodRightCell *cell = [FoodRightCell cellWithTableView:tableView];
        FoodModel *foodM = self.foodDataSource[indexPath.section];
        FoodItemModel *foodItemM = foodM.foodSubs[indexPath.row];
        cell.foodItemM = foodItemM;
        return cell;
    }
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        return KFoodItemCellHeight;
    }else{
        return KFoodSubCellHeight;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTableView) {
        FoodModel *foodM = self.foodDataSource[section];
        return foodM.title;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightTableView) {
        return 25;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark + 设置左右列表联动
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {//点击左侧列表
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

//headerView将要显示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (!self.isRolling && tableView == self.rightTableView) {//滚动右侧列表
        NSInteger subFoodSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:subFoodSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

//footerView已经消失
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (!self.isRolling && tableView == self.rightTableView) {//滚动右侧列表
        NSInteger subFoodSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:subFoodSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

//scrollView停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //记录停止拖拽时的状态
    _isRoll = NO;
}

#pragma mark - 其他
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
