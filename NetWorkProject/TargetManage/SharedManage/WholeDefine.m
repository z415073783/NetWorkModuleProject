//
//  WholeDefine.m
//  New_Target
//
//  Created by Zlm on 14-9-1.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "WholeDefine.h"
//#import "JSON.h"
#import "SharedManage.h"
#import "ImageDetailController.h"
#import "UIImageView+WebCache.h"
@implementation WholeDefine

+(WholeDefine *)getInstance
{
    static WholeDefine* shared = nil;
    if (shared == nil)
    {
        shared = [[WholeDefine alloc]init];
        
    }
    
    return shared;
}

+(void)addAlertViewWithTitle:(NSString*)sender Target:(id)target
{
    UIAlertView* zAlert = [[UIAlertView alloc]initWithTitle:@"" message:sender delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [zAlert show];
}
//全屏展示图片
+(void)imageAdjustSizeWith:(UIImage*)image Size:(CGSize)size
{
    ImageDetailController* zImageC = [[ImageDetailController alloc]initWithImage:image Size:size];
    
    [[SharedManage getInstance].mainLayer presentViewController:zImageC animated:NO completion:^{
        
    }];
}
+(void)imageNetAdjustSizeWith:(NSString*)imagePath Size:(CGSize)size
{
    ImageDetailController* zImageC = [[ImageDetailController alloc]initWithNetImage:imagePath Size:size];
    [[SharedManage getInstance].mainLayer presentViewController:zImageC animated:NO completion:^{
        
    }];
}

+(void)removeNetImageCache
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}


@end
