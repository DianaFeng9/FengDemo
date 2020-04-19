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

@interface YFNewsViewController ()<UITableViewDataSource, UITableViewDelegate, YFNewsCellDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArr;

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
    self.dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        [self.dataArr addObject:@"hhhh"]; // 数据暂时无
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YFDetailController *detailController = [[YFDetailController alloc] init];
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

//    cell.textLabel.text = [NSString stringWithFormat:@"标题- %@", @(indexPath.row)];
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
        [strongSelf.dataArr removeLastObject];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

@end
