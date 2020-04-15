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

@interface YFNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation YFNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.backgroundColor = [UIColor blueColor];
//    btn.frame = CGRectMake(100, 100, 50, 100);
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(pushViewC:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YFDetailController *detailController = [[YFDetailController alloc] init];
    detailController.navigationItem.title = @"详情页";
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFNewsCell *cell = [YFNewsCell newsCellWithTableView:tableView];
    
//    YFNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
//    }
    
    
//    cell.textLabel.text = [NSString stringWithFormat:@"标题- %@", @(indexPath.row)];
    return cell;
}




//- (void)pushViewC:(UIButton *)btn {
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor blackColor];
//    vc.navigationItem.title = @"标题";
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
