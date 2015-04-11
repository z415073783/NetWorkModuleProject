//
//  MHMutilImagePickerViewController.m
//  doujiazi
//
//  Created by Shine.Yuan on 12-8-7.
//  Copyright (c) 2012年 mooho.inc. All rights reserved.
//

#import "MHImagePickerMutilSelector.h"
#import <QuartzCore/QuartzCore.h>

@interface MHImagePickerMutilSelector ()

@end

@implementation MHImagePickerMutilSelector

@synthesize imagePicker;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        pics=[[NSMutableArray alloc] init];
        //[pics addObject:@""];
        [self.view setBackgroundColor:[UIColor blackColor]];
        _selectImageNum = 10;
        //if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            
        //}
    }
    return self;
}

+(id)standardSelector
{
    return [[MHImagePickerMutilSelector alloc] init];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count>=2) {
        //NSLog(@"%@",viewController.view);
        for (UIView* ii in viewController.view.subviews) {
            // NSLog(@"%@",ii);
        }
        [[viewController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height-131)];
        
        
        selectedPan=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-131, [UIScreen mainScreen].applicationFrame.size.width, 131)];
        UIImageView* imv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 131)];
        [imv setImage:[UIImage imageNamed:@"MHImage_background.png"]];
        [selectedPan addSubview:imv];
//        [imv release];
        
        textlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 13, 300, 14)];
        [textlabel setBackgroundColor:[UIColor clearColor]];
        [textlabel setFont:[UIFont systemFontOfSize:14.0f]];
        [textlabel setTextColor:[UIColor whiteColor]];
        [textlabel setText:[NSString stringWithFormat:@"当前选中0张(最多%d张)",_selectImageNum]];
        [selectedPan addSubview:textlabel];
//        [textlabel release];
        
        UIButton*   btn_done=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn_done setFrame:CGRectMake(530/2, 5, 47, 31)];
//        [btn_done setImage:[UIImage imageNamed:@"MHImage_contain.png"] forState:UIControlStateNormal];
        [btn_done addTarget:self action:@selector(doneHandler) forControlEvents:UIControlEventTouchUpInside];
        [btn_done setTitle:@"完成" forState:UIControlStateNormal];
        [btn_done setBackgroundImage:[UIImage imageNamed:@"MHImage_contain.png"] forState:UIControlStateNormal];
        [selectedPan addSubview:btn_done];
        
        
        tbv=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 90, 320) style:UITableViewStylePlain];
        
        tbv.transform=CGAffineTransformMakeRotation(M_PI * -90 / 180);
        tbv.center=CGPointMake(160, 131-90/2);
        [tbv setRowHeight:100];
        [tbv setShowsVerticalScrollIndicator:NO];
        [tbv setPagingEnabled:YES];
        
        tbv.dataSource=self;
        tbv.delegate=self;
        
        //[tbv setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
        
        [tbv setBackgroundColor:[UIColor clearColor]];
        
        
        [tbv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [selectedPan addSubview:tbv];
//        [tbv release];
        
        [viewController.view addSubview:selectedPan];
//        [selectedPan release];
    }else{
        [pics removeAllObjects];
        
        
    }
}

-(void)doneHandler
{
    if (delegate && [delegate respondsToSelector:@selector(imagePickerMutilSelectorDidGetImages:)]) {
        [delegate performSelector:@selector(imagePickerMutilSelectorDidGetImages:) withObject:pics];
    }
    [self close];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pics.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger row=indexPath.row;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIView* rotateView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80 , 80)];
        [rotateView setBackgroundColor:[UIColor blueColor]];
        rotateView.transform=CGAffineTransformMakeRotation(M_PI * 90 / 180);
        rotateView.center=CGPointMake(45, 45);
        [cell.contentView addSubview:rotateView];
//        [rotateView release];
        
        UIImageView* imv=[[UIImageView alloc] initWithImage:[pics objectAtIndex:row]];
        [imv setFrame:CGRectMake(0, 0, 80, 80)];
        [imv setClipsToBounds:YES];
        [imv setContentMode:UIViewContentModeScaleAspectFill];
        
        [imv.layer setBorderColor:[UIColor whiteColor].CGColor];
        [imv.layer setBorderWidth:2.0f];
        
        [rotateView addSubview:imv];
//        [imv release];
        
        UIButton*   btn_delete=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 22, 22)];
        [btn_delete setImage:[UIImage imageNamed:@"MHImage_cancel.png"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(70, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:row];
        
        [rotateView addSubview:btn_delete];
    }
    
    return cell;
}

-(void)deletePicHandler:(UIButton*)btn
{
    [pics removeObjectAtIndex:btn.tag];
    [self updateTableView];
}

-(void)updateTableView
{
    textlabel.text=[NSString stringWithFormat:@"当前选中%i张(最多%d张)",pics.count,_selectImageNum];
    
    [tbv reloadData];
    
    if (pics.count>3) {
        CGFloat offsetY=tbv.contentSize.height-tbv.frame.size.height-(320-90);
        [tbv setContentOffset:CGPointMake(0, offsetY) animated:YES];
    }else{
        [tbv setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //[btn_addCover.imageView setImage:image forState:UIControlStateNormal];
    
    //[picker dismissModalViewControllerAnimated:YES];
    if (pics.count>=_selectImageNum) {
        return;
    }
    
    [pics addObject:image];
    [self updateTableView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (delegate && [delegate respondsToSelector:@selector(imagePickerMutilSelectorDidGetImages:)]) {
        [delegate performSelector:@selector(imagePickerMutilSelectorDidGetImages:) withObject:nil];
    }
    [self close];
}

-(void)close
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)dealloc
{
    delegate=nil;
    imagePicker=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
