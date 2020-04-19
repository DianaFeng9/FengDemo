//
//  YFDeleteView.h
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/18.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFDeleteView : UIView

- (void)showsDeleteViewFromePoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
