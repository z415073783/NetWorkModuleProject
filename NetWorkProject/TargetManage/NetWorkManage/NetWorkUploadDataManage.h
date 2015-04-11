//
//  NetWorkUploadDataManage.h
//  NetWorkProject
//
//  Created by Zlm on 15-4-11.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkUploadDataManage : NSObject
{
    
}
-(NSURLRequest*)setRequestForData:(NSDictionary *)data Files:(NSDictionary *)files Trade:(NSString *)trade;
@end
