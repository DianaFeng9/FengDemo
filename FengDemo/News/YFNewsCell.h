//
//  YFNewsCell.h
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/13.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YFNewsCellDelegate <NSObject>
@optional
- didClickDeleteButton:(UIButton *)deleteButton;
@end


@interface YFNewsCell : UITableViewCell

@property (nonatomic, weak) id<YFNewsCellDelegate> delegate;

+ (instancetype)newsCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
