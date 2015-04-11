//
//  ImageDetailController.h
//  NumberOne
//
//  Created by Zlm on 14-10-20.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDetailController : UIViewController<UIGestureRecognizerDelegate>
{
    UIImageView* zImageView;
    UITapGestureRecognizer* tap;
    UIPinchGestureRecognizer *pinch;
    
    CGSize preSize;
    CGPoint prePoint;
    
    float zScale;
    float transX;
    float transY;
 
}
-(id)initWithImage:(UIImage*)image Size:(CGSize)size;
-(id)initWithNetImage:(NSString*)imagePath Size:(CGSize)size;
@end
