//
//  YFLoader.h
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/22.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YFNewsModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^YFLoaderFinishBlock)(BOOL success, NSArray<YFNewsModel *> *dataArray);

@interface YFLoader : NSObject

- (void)loadListDataWithBlock:(YFLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
