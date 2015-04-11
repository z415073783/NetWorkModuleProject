//
//  TypeTableView.h
//  XiaMenTravel
//
//  Created by Zlm on 14-9-21.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeTableViewProtocol.h"
@interface TypeTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* zTableView;
    NSArray* dataArray;
    int zType;
    
}
@property id<TypeTableViewProtocol>delegate;
-(id)initWithData:(NSArray*)sender Position:(CGRect)Pos Type:(int)type;
-(id)initWithData:(NSArray*)sender Position:(CGPoint)Pos;
@end
