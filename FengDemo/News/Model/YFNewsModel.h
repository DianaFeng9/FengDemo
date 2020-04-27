//
//  NewsModel.h
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/27.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFNewsModel : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *uniquekey;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *articleUrl;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
