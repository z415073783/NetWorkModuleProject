//
//  NetWorkManage.h
//  NetWorkProject
//
//  Created by Zlm on 15-4-10.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    Application_json_charset_utf8,
    Application_x_www_form_urlencoded
    
    
}ContentType;
@interface NetWorkManage : NSObject
{
    @private
//    NSString* zIpconfig;
    
    
}
@property(nonatomic)NSString* ipconfig;
@property(nonatomic)NSMutableURLRequest* request;
@property(nonatomic)NSString* contentType;
@property(nonatomic)int timeout;
+(NetWorkManage*)getInstance;
#pragma mark -网络请求配置-
/*设置网络请求ip或域名 例:192.168.1.1:8081*/
+(void)setIpconfig:(NSString*)ipconfig;
/*设置用户名和密码*/
+(void)setUserName:(NSString*)userName Password:(NSString*)password;
/*设置数据类型*/
+(void)setContentType:(ContentType)sender;
/*设置请求超时时间*/
+(void)setTimeoutInterval:(int)sender;

#pragma mark -网络请求接口-
/*GET请求
 data:数据
 trade:链接头
 */
+(void)sendGetRequest:(NSDictionary*)data Trade:(NSString*)trade Block:(void(^)(id resultData,NSError* error))resultBlock;
/*POST请求*/
+(void)sendPostRequest:(NSDictionary*)data Trade:(NSString*)trade Block:(void(^)(id resultData,NSError* error))resultBlock;
/*上传数据
 data:数据
 files:文件名->路径
 trade:链接头
 */
+(void)sendPostFilesRequest:(NSDictionary*)data Files:(NSDictionary*)files Trade:(NSString*)trade Block:(void(^)(id resultData,NSError* error))resultBlock;


@end
