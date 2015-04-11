//
//  LocalFileManage.h
//  ModuleProject
//
//  Created by Zlm on 15-3-21.
//  Copyright (c) 2015年 xmjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFileManage : NSObject
//获得本地路径
+(NSString*)getLocalFilePath;
//创建文件夹
+(BOOL)createDirectoryWithPath:(NSString*)path;
//清除指定文件
+(BOOL)removeFilePath:(NSString*)selectPath;
//    获取指定目录下所有文件
+(NSArray*)getAllFileWithParentFile:(NSString*)parentPath;
//    清除指定目录下所有文件
+(BOOL)removeAllChildrenFileWithParentFile:(NSString*)parentPath;
//读取工程中的json文件
+(id)readLocalData:(NSString*)filePath;


@end
