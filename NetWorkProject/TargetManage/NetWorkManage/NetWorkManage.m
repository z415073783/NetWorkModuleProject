//
//  NetWorkManage.m
//  NetWorkProject
//
//  Created by Zlm on 15-4-10.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import "NetWorkManage.h"
#import "JSON.h"
#import "NetWorkUploadDataManage.h"
@implementation NetWorkManage
+(NetWorkManage*)getInstance
{
    static NetWorkManage* shared = nil;
    if (shared == nil)
    {
        shared = [[NetWorkManage alloc]init];
        [shared setRequest:[[NSMutableURLRequest alloc]init]];
        [shared.request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [NetWorkManage setTimeoutInterval:15];
        //默认ContentType
        [NetWorkManage setContentType:Application_json_charset_utf8];
    }
    return shared;
}
+(void)setIpconfig:(NSString *)ipconfig
{
    [[NetWorkManage getInstance] setIpconfig:ipconfig];
}
+(void)setUserName:(NSString *)userName Password:(NSString *)password
{
    NSString* baseEncodedData = [[[NSString stringWithFormat:@"%@:%@",userName,password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [[NetWorkManage getInstance].request setValue:[NSString stringWithFormat:@"%@ %@", @"Basic", baseEncodedData]
   forHTTPHeaderField:@"Authorization"];
}
+(void)setTimeoutInterval:(int)sender
{
    [[NetWorkManage getInstance] setTimeout:sender];
    [[NetWorkManage getInstance].request setTimeoutInterval:sender];
}
+(void)setContentType:(ContentType)sender
{
    switch (sender)
    {
        case Application_json_charset_utf8:
        {
            [[NetWorkManage getInstance] setContentType:@"application/json; charset=utf-8"];
        }
            break;
        case Application_x_www_form_urlencoded:
        {
            [[NetWorkManage getInstance] setContentType:@"application/x-www-form-urlencoded"];
        }
            break;
        default:
            break;
    }
    
    [[NetWorkManage getInstance].request setValue:[NetWorkManage getInstance].contentType forHTTPHeaderField:@"Content-type"];
}

+(void)sendGetRequest:(NSDictionary *)data Trade:(NSString *)trade Block:(void (^)(id, NSError *))resultBlock
{
    
    //数据解析
    NSMutableString* dataStr = [NSMutableString string];
    if (data)
    {
        NSArray* allKey = [data allKeys];
        
        for (int i = 0; i<[allKey count]; i++)
        {
            if (i == 0 )
            {
                [dataStr appendFormat:@"?"];
            }
            [dataStr appendFormat:@"%@=%@",[allKey objectAtIndex:i],[data objectForKey:[allKey objectAtIndex:i]]];
            if (i < [allKey count] - 1)
            {
                [dataStr appendString:@"&"];
            }
        }
    }
    //拼接链接
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@?%@",[NetWorkManage getInstance].ipconfig,trade,dataStr]];
    
    NSMutableURLRequest* request = [NetWorkManage getInstance].request;
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sharedSession];
    //    session
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString* dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        id result = [dataStr JSONValue];
        resultBlock(result,error);
    } ];
    //开始任务
    [task resume];
}
+(void)sendPostRequest:(NSDictionary *)data Trade:(NSString *)trade Block:(void (^)(id, NSError *))resultBlock
{
    //拼接链接
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",[NetWorkManage getInstance].ipconfig,trade]];
    NSMutableURLRequest* request = [NetWorkManage getInstance].request;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    if (data)
    {
        [request setHTTPBody:[[data JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    }
    NSURLSession* session = [NSURLSession sharedSession];
    //    session
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString* dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        id result = [dataStr JSONValue];
        resultBlock(result,error);
    } ];
    //开始任务
    [task resume];
}
+(void)sendPostFilesRequest:(NSDictionary *)data Files:(NSDictionary *)files Trade:(NSString *)trade Block:(void (^)(id, NSError *))resultBlock
{
    //拼接链接
    NSURLRequest* request = [[[NetWorkUploadDataManage alloc]init] setRequestForData:data Files:files Trade:trade];
    
    NSURLSession* session = [NSURLSession sharedSession];
    //    session
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString* dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        id result = [dataStr JSONValue];
        resultBlock(result,error);
    } ];
    //开始任务
    [task resume];
}


@end
