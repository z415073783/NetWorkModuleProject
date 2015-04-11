//
//  ImageDetailController.m
//  NumberOne
//
//  Created by Zlm on 14-10-20.
//  Copyright (c) 2014年 xmjw. All rights reserved.
//

#import "ImageDetailController.h"
#import "WholeDefine.h"
#import "UIImageView+WebCache.h"
#import "AdaptiveDeviceManage.h"
@interface ImageDetailController ()

@end

@implementation ImageDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithNetImage:(NSString*)imagePath Size:(CGSize)size
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
        
        zImageView = [[UIImageView alloc]init];
        zImageView.frame = CGRectMake(0, 0, size.width, size.height);
        zImageView.center = CGPointMake(ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.width/2, ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.height/2);
        preSize = CGSizeMake(size.width, size.height);
        prePoint = CGPointMake(ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.width/2, ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.height/2);
        [zImageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"Resource/UIImage/GeneralImage/General_Replace.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        [self.view addSubview:zImageView];
        
        [self initView];
    }
    return self;
}

-(id)initWithImage:(UIImage*)image Size:(CGSize)size
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
        
        
        zImageView = [[UIImageView alloc]initWithImage:image];
        zImageView.frame = CGRectMake(0, 0, size.width, size.height);
        zImageView.center = CGPointMake(ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.width/2, ZZRectMakeWithAuto(CGRectMake(0, 0, 320, 480)).size.height/2);
        [self.view addSubview:zImageView];
        
        [self initView];
    }
    return self;
}
-(void)initView
{
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchMethod:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangestMethod:)];
    [self.view addGestureRecognizer:pan];
    
}
-(void)pangestMethod:(UIPanGestureRecognizer*)sender
{
    CGPoint trans = [sender translationInView:zImageView];
//    zImageView.transform = CGAffineTransformMakeTranslation(trans.x, trans.y);
    zImageView.center = zImageView.center = CGPointMake(prePoint.x+trans.x, prePoint.y+trans.y);
    
    
}
-(void)tapMethod:(UITapGestureRecognizer*)sender
{
    //    zImageView
    
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    
    
}

-(void)pinchMethod:(UIPinchGestureRecognizer*)sender
{
    
    zImageView.frame = CGRectMake(0, 0, sender.scale*preSize.width, sender.scale*preSize.height);
    zImageView.center = prePoint;
    
//    CGAffineTransformMakeScale(sender.scale, sender.scale);
    
    
//    [zImageView sizeThatFits:CGSizeMake(320*sender.scale, 150*sender.scale)];
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   
    preSize = zImageView.frame.size;
        
    prePoint = zImageView.center;
        
  
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
