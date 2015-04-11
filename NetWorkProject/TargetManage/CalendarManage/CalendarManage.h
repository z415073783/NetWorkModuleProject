//
//  CalendarManage.h
//  NumberOne
//
//  Created by Zlm on 14-9-3.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//  日历

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalendarManage : UIView
{
@private
  
    NSDateComponents* currentComponent;
    NSDateComponents* selectComponent;
    NSDate* currentDate;
//    标记
//    NSMutableArray* maskArray;
    
}
@property(retain) NSArray* maskArray;
//当前选择月份
@property(readonly) int currentMonth;
//改变量
@property(readonly) int changeIndex;
//改变月份  (传入月份改变量)
-(void)changeMonth:(int)sender;
-(id)initWithMask:(NSArray*)mask;
//获得当月最大天数
+(int)getMaxDayWithYear:(int)year Month:(int)month;

@end
