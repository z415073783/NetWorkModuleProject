//
//  TypeTableView.m
//  XiaMenTravel
//
//  Created by Zlm on 14-9-21.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "TypeTableView.h"
#import "WholeDefine.h"
#import "AdaptiveDeviceManage.h"
@implementation TypeTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithData:(NSArray*)sender Position:(CGRect)Pos Type:(int)type
{
    self = [super initWithFrame:ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480))];
    if (self)
    {
        zType = type;
        dataArray = sender;
        zTableView = [[UITableView alloc]initWithFrame:Pos style:UITableViewStylePlain];
        zTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        zTableView.delegate = self;
        zTableView.dataSource = self;
        [self addSubview:zTableView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapanimation:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(id)initWithData:(NSArray*)sender Position:(CGPoint)Pos
{
    self = [super initWithFrame:ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480))];
    if (self)
    {
        zType = 0;
//        zType = type;
        dataArray = sender;
        zTableView = [[UITableView alloc]initWithFrame:CGRectMake(Pos.x, Pos.y, 160, [sender count] * 44) style:UITableViewStylePlain];
        zTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        zTableView.delegate = self;
        zTableView.dataSource = self;
        [self addSubview:zTableView];
        
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapanimation:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)tapanimation:(UITapGestureRecognizer*)sender
{
    CGPoint zPoint = [sender locationInView:self];
    NSLog(@"%f,%f",zPoint.x,zPoint.y);
    
    [self removeFromSuperview];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UILabel* name = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 25)];
    name.text = [dataArray objectAtIndex:indexPath.row];
    name.textColor = [UIColor whiteColor];
    name.backgroundColor = [UIColor clearColor];
    [cell addSubview:name];
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    UIButton* zbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    zbutton.frame = CGRectMake(0, 0, 160, 45);
    zbutton.tag = indexPath.row+1;
    [zbutton addTarget:self action:@selector(selectButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:zbutton];
    
    
    
    
    return cell;
    
}
-(void)selectButtonMethod:(UIButton*)sender
{
    
    [_delegate receiveTypeData:zType selectNumber:sender.tag - 1];
    
    [self removeFromSuperview];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [_delegate receiveTypeData:zType selectNumber:indexPath.row];
//    
//    [self removeFromSuperview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
