//
//  PhotoManageC.h
//  JinYinLand
//
//  Created by Zlm on 15-1-20.
//
//

#import <Foundation/Foundation.h>
#import "MHImagePickerMutilSelector.h"
//using namespace std;

@protocol PhotoDelegate <NSObject>
@optional
-(void)receivePhotoData:(NSArray*)sender;
@end

@interface PhotoManageC : NSObject<MHImagePickerMutilSelectorDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController* picker;
    int zBeginName;
}
@property(assign)id<PhotoDelegate> delegate;
+(PhotoManageC*)getInstance;
-(void)openPhotoAlbumWithNumber:(int)number AllowsEditing:(BOOL)allowsEditing BeginName:(int)beginName;
-(UIImagePickerController*)openPhoto;
-(UIImagePickerController*)openCarema;
//合成UIImage
+(UIImage*)createImageFromView:(UIView*)view;
//设置图片尺寸
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
@end
