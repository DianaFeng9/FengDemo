//
//  YFLoader.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/22.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFLoader.h"
#import "YFNewsModel.h"

@implementation YFLoader

- (void)loadListDataWithBlock:(YFLoaderFinishBlock)finishBlock {
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
#warning 类型检查 判断
        NSArray *dataArray = [((NSDictionary *)[(NSDictionary *)jsonObj objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *newsModelArray = @[].mutableCopy;
        for (NSDictionary *item in dataArray) {
            YFNewsModel *newsModel = [[YFNewsModel alloc] init];
            [newsModel configWithDictionary:item];
            [newsModelArray addObject:newsModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error == nil, newsModelArray.mutableCopy);
            }
        });
    }];
    [dataTask resume];
}
@end
