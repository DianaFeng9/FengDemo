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
#import "YFNewsModel.h"

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
        make.right.equalTo(self.imgView.mas_left).offset(-50.0);
        make.top.equalTo(self.contentView).offset(10.0);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10.0);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50.0, 50.0));
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).offset(-5.0);
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
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        // [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
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
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = [UIColor blueColor];
    }
    return _imgView;
}

#pragma mark - 设置数据
- (void)setData:(YFNewsModel *)newsModel {
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:newsModel.uniquekey];
    if (hasRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    self.titleLabel.text = newsModel.title;
    self.sourceLabel.text = newsModel.authorName;
    self.commentLabel.text = newsModel.category;
    self.timeLabel.text = newsModel.date;
    self.deleteButton.backgroundColor = [UIColor redColor];
    [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
    [self.deleteButton setTitle:@"X" forState:UIControlStateHighlighted];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:newsModel.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"设置完图片");
    }];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newsModel.picUrl]]];
//    self.imgView.image = image;
}

// #define YF_IS_DELEGATE_RSP_SEL(iDel, iSel) (iDel != nil && [iDel respondsToSelector:@selector(iSel)])

- (void)didClickDeleteButton{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(newsCell:didClickDeleteButton:)]) {
        [self.delegate newsCell:self didClickDeleteButton:self.deleteButton];
    }
}

@end
