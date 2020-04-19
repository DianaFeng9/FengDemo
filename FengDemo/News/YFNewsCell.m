//
//  YFNewsCell.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/13.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFNewsCell.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface YFNewsCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation YFNewsCell

+ (instancetype)newsCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"news_list_cell";
    YFNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YFNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviews];
        [self setNewsCellData];        
    }
    return self;
}

- (void)setUpSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.deleteButton];
    
    // layout
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20.0);
        make.top.equalTo(self.contentView).offset(10.0);
        make.height.mas_equalTo(20.0);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10.0);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40.0, 40.0));
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10.0);
        make.bottom.equalTo(self.contentView).offset(-5.0);
        make.height.mas_equalTo(10.0);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sourceLabel.mas_right).offset(5.0);
        make.bottom.height.equalTo(self.sourceLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentLabel.mas_right).offset(5.0);
        make.bottom.height.equalTo(self.sourceLabel);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30.0, 30.0));
        make.right.mas_equalTo(self.imgView.mas_left).offset(-5.0);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - property
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _titleLabel;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.font = [UIFont systemFontOfSize:12.0];
        _sourceLabel.backgroundColor = [UIColor redColor];
    }
    return _sourceLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:12.0];
        _commentLabel.backgroundColor = [UIColor yellowColor];
    }
    return _commentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.backgroundColor = [UIColor greenColor];
    }
    return _timeLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton addTarget:self action:@selector(didClickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeCenter;
    }
    return _imgView;
}

#pragma mark - 设置数据
//- (void)setNewsCellData:(NewsData *) newsData {
//
//}

- (void)setNewsCellData {
    self.titleLabel.text = @"标题";
    self.sourceLabel.text = @"数据源";
    self.commentLabel.text = @"888评论";
    self.timeLabel.text = @"3分钟前";
    self.deleteButton.backgroundColor = [UIColor redColor];
    [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
    [self.deleteButton setTitle:@"X" forState:UIControlStateHighlighted];
    self.imgView.backgroundColor = [UIColor yellowColor];
}

// #define YF_IS_DELEGATE_RSP_SEL(iDel, iSel) (iDel != nil && [iDel respondsToSelector:@selector(iSel)])

- (void)didClickDeleteButton{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(newsCell:didClickDeleteButton:)]) {
        [self.delegate newsCell:self didClickDeleteButton:self.deleteButton];
    }
}

@end
