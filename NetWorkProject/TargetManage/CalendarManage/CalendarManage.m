//
//  CalendarManage.m
//  NumberOne
//
//  Created by Zlm on 14-9-3.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "CalendarManage.h"
@interface CalendarManage()
-(void)initView:(NSDateComponents*)sender;
-(NSDateComponents*)getCurrentData:(int)changeMonth;
-(int)isMark:(int)day Label:(UILabel*)label;
@end

@implementation CalendarManage
-(id)initWithMask:(NSArray*)mask
{
    if ([super init])
    {
        self.userInteractionEnabled = NO;
        if (mask != nil)
        {
//            [mask retain];
            [self setMaskArray:mask];
//            [self.maskArray retain];
        }
        [self initView:[self getCurrentData:0]];
        _changeIndex = 0;
        return self;
    }
    return nil;
}

-(void)changeMonth:(int)sender
{
    _changeIndex = sender;
    NSArray* subArr = [self subviews];
    for (id item in subArr)
    {
        [item removeFromSuperview];
    }
    [self initView:[self getCurrentData:sender]];
}


//获得时间
-(NSDateComponents *)getCurrentData:(int)changeMonth
{
    //    东八区
//   地区时间
    NSDate* date = [NSDate date];
//    NSDate *date = [[NSDate alloc] initWithTimeInterval:60*60*8 sinceDate:xidate];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    
    if (changeMonth != 0)
    {
        NSDateComponents *c1 = [[NSDateComponents alloc] init];
        [c1 setMonth:changeMonth];
        date = [calendar dateByAddingComponents:c1 toDate:date options:0];
    }else
    {
        currentDate = [date copy];
    }
    //转换成当地时间
//    年
    comps = [calendar components:NSYearCalendarUnit fromDate:date];
    NSInteger year = [comps year];
//    月
    comps = [calendar components:NSMonthCalendarUnit fromDate:date];
    NSInteger month = [comps month];
    //日
    comps = [calendar components:(NSDayCalendarUnit) fromDate:date];
    NSInteger day = [comps day];
    //时
    comps = [calendar components:NSHourCalendarUnit fromDate:date];
    NSInteger hour = [comps hour];
    //分
    comps = [calendar components:NSMinuteCalendarUnit fromDate:date];
    NSInteger minute = [comps minute];
    //秒
    comps = [calendar components:NSSecondCalendarUnit fromDate:date];
    NSInteger second = [comps second];
//    第一天星期几
    comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    NSInteger weekday = [comps weekday];

    NSLog(@"%d-%d-%d %d:%d:%d",year,month,day,hour,minute,second);
    _currentMonth = month;
    NSDateComponents *currentCalent = [[NSDateComponents alloc]init];
    [currentCalent setYear:year];
    [currentCalent setMonth:month];
    [currentCalent setDay:day];
    [currentCalent setHour:hour];
    [currentCalent setMinute:minute];
    [currentCalent setSecond:second];
    [currentCalent setWeekday:weekday];
    
    if (changeMonth == 0)
    {
        currentComponent = [currentCalent copy];
    }
    selectComponent = [currentCalent copy];
    return currentCalent;
}
//获得当月最大天数
+(int)getMaxDayWithYear:(int)year Month:(int)month
{
    int maxDays = 0;
    BOOL run = NO;
    if (year%4 == 0 )
    {
        if (year%100 ==0)
        {
            if (year%400 == 0)
            {
                //                润
                run = YES;
            }else
            {
                //                平
            }
            
        }else
        {
            //            润
            run = YES;
        }
    }else
    {
        //        平
    }
    
    if (month == 2)
    {
        maxDays = 28;
        if (run == YES)
        {
            maxDays = 29;
        }
    }else
    {
        //        std::vector<int>numberVec;
        NSArray* numberArr = [NSArray arrayWithObjects:@"1",@"3",@"5",@"7",@"8",@"10",@"12", nil];
        maxDays = 30;
        for (NSString* item in numberArr)
        {
            if (month == [item intValue])
            {
                maxDays = 31;
            }
        }
    }
    
    return maxDays;
}

-(void)initView:(NSDateComponents *)sender
{
    NSArray* weekArr = [NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
    
    for (int i = 0; i<7; i++)
    {
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(i*35, 0, 35, 30)];
        [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = [weekArr objectAtIndex:i];
        title.textColor = [UIColor blackColor];
        [self addSubview:title];
        
    }
    int maxDays = [CalendarManage getMaxDayWithYear:sender.year Month:sender.month];
    
    for (int i = 0; i < maxDays; i++)
    {
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake((sender.weekday+i-1)%7*35, ((sender.weekday+i-1)/7+1) * 35, 35, 30)];
        title.textAlignment = NSTextAlignmentCenter;
        
        [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        //        [weekArr objectAtIndex:i]
        title.text = [NSString stringWithFormat:@"%d",i+1];
        title.textColor = [UIColor blackColor];
        if (sender.day == i+1 && sender.year == currentComponent.year && sender.month == currentComponent.month)
        {
            title.textColor = [UIColor yellowColor];
        }
        [title setTag:i+1];
        
//        标记
        switch ([self isMark:i+1 Label:title])
        {
            case 1:
            {
                title.textColor = [UIColor redColor];
            }
                break;
            default:
                break;
        }
        
        [self addSubview:title];
    }
}

-(int)isMark:(int)day Label:(UILabel*)label
{
    int returnColor = 0;
    
    for (NSArray*item in _maskArray)
    {
        //天数
        int markDay = [[item objectAtIndex:0] intValue];
        //颜色
        int markColor = [[item objectAtIndex:1] intValue];
        
        //计算相差天数
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents* dicComp = [[NSDateComponents alloc]init];
        [dicComp setDay:markDay];
        NSDate* dicDate = [calendar dateByAddingComponents:dicComp toDate:currentDate options:0];
        
        NSDateComponents *comps;
        comps = [calendar components:NSYearCalendarUnit fromDate:dicDate];
        NSInteger dicyear = [comps year];
        comps = [calendar components:NSMonthCalendarUnit fromDate:dicDate];
        NSInteger dicmonth = [comps month];
        comps = [calendar components:NSDayCalendarUnit fromDate:dicDate];
        NSInteger dicday = [comps day];
       
        if (dicyear == selectComponent.year && dicmonth == selectComponent.month && dicday == day)
        {
            returnColor = markColor;
            
//            自定义图片
            if ([item count] == 3)
            {
                
                UIImage* image = [UIImage imageNamed:[item objectAtIndex:2]];
                UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
                imageView.frame = label.frame;
                [self addSubview:imageView];
            }
        }
    }
    return returnColor;
};

@end
