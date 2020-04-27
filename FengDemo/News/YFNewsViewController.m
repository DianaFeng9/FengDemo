//
//  ViewController.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/9.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFNewsViewController.h"
#import "YFNewsCell.h"
#import "YFDetailController.h"
#import "YFDeleteView.h"
#import "YFLoader.h"
#import "YFNewsModel.h"

@interface YFNewsViewController ()<UITableViewDataSource, UITableViewDelegate, YFNewsCellDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArr;
@property(nonatomic, strong) YFLoader *loader;
@end

@implementation YFNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self quickCustomInit];
    [self dataInit];
}

- (void)quickCustomInit {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)dataInit {
    self.loader = [[YFLoader alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [self.loader loadListDataWithBlock:^(BOOL success, NSArray<YFNewsModel *> * _Nonnull dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(success) {
            strongSelf.dataArr = dataArray;
            [strongSelf.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YFDetailController *detailController = [[YFDetailController alloc] initWithData:((YFNewsModel *)self.dataArr[indexPath.row]).articleUrl];
    detailController.navigationItem.title = @"详情页";
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFNewsCell *cell = [YFNewsCell newsCellWithTableView:tableView];
    cell.delegate = self;
    [cell setData:self.dataArr[indexPath.row]];
    return cell;
}

- (void)newsCell:(YFNewsCell *)newsCell didClickDeleteButton:(UIButton *)deleteButton {
    YFDeleteView *deleteView = [[YFDeleteView alloc] initWithFrame:self.view.bounds];
    CGPoint deleteButtonPoint = [newsCell convertPoint:deleteButton.frame.origin toView:nil];
    
    __weak typeof(self) weakSelf = self;
    [deleteView showsDeleteViewFromePoint:deleteButtonPoint clickBlock:^{
        NSLog(@"点击了删除弹框的del按钮");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSIndexPath *indexPath = [strongSelf.tableView indexPathForCell:newsCell];
        //[strongSelf.dataArr removeLastObject];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

@end
