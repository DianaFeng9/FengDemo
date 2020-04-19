//
//  YFDeleteView.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/18.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFDeleteView.h"
#import <Masonry.h>

@interface YFDeleteView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic,copy) dispatch_block_t clickBlock;
@end

@implementation YFDeleteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)customInit {
    [self addSubview:self.backgroundView];
    [self addSubview:self.deleteButton];
    
    // layout
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(10, 5));
    }];
    
//    self.deleteButton.frame = CGRectMake(0, 0, 0, 0);
    [self layoutIfNeeded];
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        _backgroundView.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedBacgroundView)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.backgroundColor = [UIColor blueColor];
        [_deleteButton setTitle:@"DEL" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(clickedDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)clickedDeleteButton {
    if (_clickBlock) {
        _clickBlock();
    }
    [self removeFromSuperview];
}

- (void)clickedBacgroundView {
    [self removeFromSuperview];
}

- (void)showsDeleteViewFromePoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock{
    [[UIApplication sharedApplication].windows[0] addSubview:self];
    
//    self.deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
//    [self layoutIfNeeded];
    
//    [self layoutIfNeeded];
    _clickBlock = [clickBlock copy];
    
    [UIView animateWithDuration:1.0f animations:^{
//        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 150) / 2, (self.bounds.size.height - 50) / 2, 150, 50);

        [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(150.0, 50.0));
        }];
        [self layoutIfNeeded];
    }];
}

@end
