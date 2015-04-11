//
//  TypeTableViewProtocol.h
//  XiaMenTravel
//
//  Created by Zlm on 14-9-22.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TypeTableViewProtocol <NSObject>
@optional
-(void)receiveTypeData:(int)type selectNumber:(int)num;
@end
