//
//  PhotoManageC.m
//  JinYinLand
//
//  Created by Zlm on 15-1-20.
//
//

#import "PhotoManageC.h"
@implementation PhotoManageC
+(PhotoManageC*)getInstance
{
    static PhotoManageC* shared = NULL;
    if (!shared)
    {
        shared = [[PhotoManageC alloc]init];
    }
    return shared;
}
-(void)openPhotoAlbumWithNumber:(int)number AllowsEditing:(BOOL)allowsEditing BeginName:(int)beginName
{
    zBeginName = beginName;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker=[[UIImagePickerController alloc] init];
        [picker setAllowsEditing:NO];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        if(number != 1)
        {
            MHImagePickerMutilSelector* imagePickerMutilSelector=[MHImagePickerMutilSelector standardSelector];//自动释放
            imagePickerMutilSelector.delegate=self;//设置代理
            [imagePickerMutilSelector setSelectImageNum:number];
            picker.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
            picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
            imagePickerMutilSelector.imagePicker=picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。

        }else
        {
            picker.delegate = self;
            picker.allowsEditing = allowsEditing;
        }
        
        [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

-(void)imagePickerMutilSelectorDidGetImages:(NSArray*)imageArray
{
//    通知单例获取图片
    [_delegate receivePhotoData:imageArray];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    [[PhotoManageC getInstance]->picker dismissViewControllerAnimated:YES completion:^{
        
    }];

    NSMutableArray* newName = [NSMutableArray array];
    [newName addObject:image];
    //    通知单例获取图片
    [_delegate receivePhotoData:newName];
}
//打开相机
-(UIImagePickerController*)openCarema
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        return picker;
        
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
        return nil;
    }
}
-(UIImagePickerController*)openPhoto
{
    //    首先判定相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //        通过模态的形式将整个照片选择器推入,显示在当前window上
        return picker;
    }
    return nil;
}
//缩小图片尺寸
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//合成UIImage
+(UIImage*)createImageFromView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
