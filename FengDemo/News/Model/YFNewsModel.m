//
//  NewsModel.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/27.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFNewsModel.h"

@implementation YFNewsModel

- (void)configWithDictionary:(NSDictionary *)dictionary {
#warning 类型判断，数据处理，如date nsdate使用时更方便等等
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniquekey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
