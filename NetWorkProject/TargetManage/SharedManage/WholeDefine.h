//
//  WholeDefine.h
//  New_Target
//
//  Created by Zlm on 14-9-1.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WholeDefine : NSObject

+(WholeDefine*)getInstance;
//提示框
+(void)addAlertViewWithTitle:(NSString*)sender Target:(id)target;
//图片根据手势放大缩小
+(void)imageAdjustSizeWith:(UIImage*)image Size:(CGSize)size;
//传入网络图片链接,根据手势放大缩小
+(void)imageNetAdjustSizeWith:(NSString*)imagePath Size:(CGSize)size;
//清理图片缓存
+(void)removeNetImageCache;

@end
