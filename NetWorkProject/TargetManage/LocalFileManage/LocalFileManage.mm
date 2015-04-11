//
//  LocalFileManage.m
//  ModuleProject
//
//  Created by Zlm on 15-3-21.
//  Copyright (c) 2015年 xmjw. All rights reserved.
//

#import "LocalFileManage.h"
#import "FileControl.h"
@implementation LocalFileManage
+(NSString *)getLocalFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(BOOL)createDirectoryWithPath:(NSString *)path
{
    //并给文件起个文件名
    NSString *fileDir = [[LocalFileManage getLocalFilePath] stringByAppendingPathComponent:path];
    BOOL isOk = [[NSFileManager defaultManager] createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    return isOk;
}
+(BOOL)removeFilePath:(NSString*)selectPath
{
    return FileControl::removeFilePath([selectPath UTF8String]);
}
//    获取指定目录下所有文件
+(NSArray*)getAllFileWithParentFile:(NSString*)parentPath
{
    vector<string>allFile = FileControl::FindAllFile([parentPath UTF8String]);
    
    NSMutableArray* fileArr = [NSMutableArray array];
    
    for (vector<string>::iterator iter = allFile.begin(); iter!=allFile.end(); iter++)
    {
        [fileArr addObject:[NSString stringWithUTF8String:(*iter).c_str()]];
    }
    return fileArr;
}
//    清除指定目录下所有文件
+(BOOL)removeAllChildrenFileWithParentFile:(NSString*)parentPath
{
    return FileControl::removeFilePathWithSubFile([parentPath UTF8String]);
}
-(id)readLocalData:(NSString*)filePath
{
    NSString* path = [[NSBundle mainBundle] pathForResource:filePath ofType:@"json"];
    NSData* jData = [[NSData alloc]initWithContentsOfFile:path];
    NSError* error = nil;
    id aData = [NSJSONSerialization JSONObjectWithData:jData options:kNilOptions error:&error];
    return aData;
}

@end
