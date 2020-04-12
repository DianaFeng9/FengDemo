//
//  YFMeViewController.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/12.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFMeViewController.h"

@interface YFMeViewController ()

@end

@implementation YFMeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
