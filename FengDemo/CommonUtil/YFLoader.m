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
    NSArray<YFNewsModel *> *dataList = [self readDataFromLocal];
    if (finishBlock) {
            finishBlock(nil, dataList.copy);
    }
    
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
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
        [strongSelf archiveListDataWithArray:newsModelArray.copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error == nil, newsModelArray.mutableCopy);
            }
        });
    }];
    [dataTask resume];
}

- (NSArray<YFNewsModel *> *)readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"YFData/listdata"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *readListData = [fileManager contentsAtPath:dataPath];
    
    NSError *error = nil;
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [YFNewsModel class], nil] fromData:readListData error:&error];
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count]>0) {
        return (NSArray<YFNewsModel *> *)unarchiveObj;
    }
    
    return nil;
}

- (void)archiveListDataWithArray:(NSArray<YFNewsModel *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"YFData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    
    // 创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"listdata"];
    NSError *error = nil;
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:NO error:&error];
    
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
}

- (void)getSandBoxPath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"YFData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    
    // 创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"listdata"];
    NSData *listData = [@"ahsjdhks" dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
//    // 查询文件
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
//
//    // 删除
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:listDataPath];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[@"hhhhh" dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    [fileHandle synchronizeFile];
    [fileHandle closeFile];
    
    NSLog(@"");
}
@end
