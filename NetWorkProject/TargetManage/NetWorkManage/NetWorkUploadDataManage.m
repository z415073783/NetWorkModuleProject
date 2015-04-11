//
//  NetWorkUploadDataManage.h
//  NetWorkProject
//
//  Created by Zlm on 15-4-11.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import "NetWorkUploadDataManage.h"
#import "NetWorkManage.h"
#import "JSON.h"
static NSString* boundaryStr = @"--";
static NSString* randomIDStr;
static NSString *uploadID;
@implementation NetWorkUploadDataManage
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        randomIDStr = @"uploadData";
        uploadID = @"uploadFile";
    }
    return self;
}
//拼接顶部字符串
-(NSString*)topFilesStringWithUploadFile:(NSString*)uploadFile
{
    NSMutableString* strM = [NSMutableString string];
    [strM appendFormat:@"%@%@\n",boundaryStr,randomIDStr];
    [strM appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\n",uploadID,uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n",[self mimeTypeWithFilePath:uploadFile]];
    return strM;
}
//拼接底部字符串
-(NSString*)bottomFilesString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"底部字符串：%@", strM);
    return strM;
}
//拼接数据顶部字符串
-(NSString*)topDataString
{
    
    NSMutableString* strM = [NSMutableString string];
    [strM appendFormat:@"%@%@\n",boundaryStr,randomIDStr];
//    [strM appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\n",uploadID,uploadFile];
    [strM appendFormat:@"%@\n\n", [NetWorkManage getInstance].contentType];
    return strM;
}
//拼接数据底部字符串
-(NSString*)bottomDataString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
//    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
//    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    return strM;
}


- (NSString *)mimeTypeWithFilePath:(NSString *)filePath
{
    // 1. 判断文件是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return nil;
    }
    
    // 2. 使用HTTP HEAD方法获取上传文件信息
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3. 调用同步方法获取文件的MimeType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    return response.MIMEType;
}


-(NSURLRequest *)setRequestForData:(NSDictionary *)data Files:(NSDictionary *)files Trade:(NSString *)trade
{
    NSMutableData *dataM = [NSMutableData data];
    //上传文件
    if (files)
    {
        NSArray* allKey = [files allKeys];
        //上传文件
        for (int i = 0;i<[allKey count];i++)
        {
            NSString* key = [allKey objectAtIndex:i];
            NSString* value = [files objectForKey:key];
            [dataM appendData:[[self topFilesStringWithUploadFile:key] dataUsingEncoding:NSUTF8StringEncoding]];
            // 拼接上传文件本身的二进制数据
            [dataM appendData:[NSData dataWithContentsOfFile:value]];
            [dataM appendData:[[self bottomFilesString] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
        //上传数据
    if (data)
    {
        [dataM appendData:[[self topDataString] dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:[[data JSONRepresentation]dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
        [dataM appendData:[[self bottomDataString]dataUsingEncoding:NSUTF8StringEncoding]];
    }
   
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",[NetWorkManage getInstance].ipconfig,trade]];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:[NetWorkManage getInstance].timeout];
    requestM.HTTPMethod = @"POST";
    requestM.HTTPBody = dataM;
    NSString *typeStr = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [requestM setValue:typeStr forHTTPHeaderField:@"Content-Type"];
    NSString *lengthStr = [NSString stringWithFormat:@"%@", @([dataM length])];
    [requestM setValue:lengthStr forHTTPHeaderField:@"Content-Length"];
    return requestM;
}

@end
