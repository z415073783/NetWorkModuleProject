//
//  UITextView+BaseTextView.m
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "UITextView+BaseTextView.h"

@implementation UITextView (BaseTextView)
//uitextview 适配显示高度
-(void)setAutoVisitHeightWithString
{
    
    CGRect frame = self.frame;
    CGSize size = [self.text sizeWithFont:self.font
                        constrainedToSize:self.contentSize //CGSizeMake(280, 1000)
                         lineBreakMode:NSLineBreakByTruncatingTail];
    frame.size.height = size.height > 1 ? size.height + 20 : 64;
    self.frame = frame;
}
@end
