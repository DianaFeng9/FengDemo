//
//  YFRecommendViewController.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/12.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFRecommendViewController.h"

@interface YFRecommendViewController ()

@end

@implementation YFRecommendViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

@end
