//
//  UILabel+BaseLabel.m
//  ModuleProject
//
//  Created by Zlm on 14-11-18.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "UILabel+BaseLabel.h"

@implementation UILabel (BaseLabel)
//适配文字宽度(仅限1行)
-(void)setAutoVisitWidthWithString
{
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width, self.frame.size.height);
}
@end
