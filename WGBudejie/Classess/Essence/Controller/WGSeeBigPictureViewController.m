//
//  WGSeeBigPictureViewController.m
//  WGBudejie
//
//  Created by taolei on 16/11/3.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGSeeBigPictureViewController.h"
#import "WGTopic.h"
#import <Photos/Photos.h>
#import "MBProgressHUD+MJ.h"

@interface WGSeeBigPictureViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation WGSeeBigPictureViewController

static NSString *WGAssetCollectionTitle = @"百思不得姐";
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(15, 40, 35, 35);
    [leftButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    [self setupScrollView];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(WIDTH - 60 - 40, HEIGHT - 30 - 40, 60, 30);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    saveBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:saveBtn];
}

/**
 *   添加的UIScrollView
 */
- (void)setupScrollView
{
    // UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    imageView.x = 0;
    imageView.width = WIDTH;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    if(imageView.height > HEIGHT){
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else{
        imageView.centerY = HEIGHT * 0.5;
    }
}

- (void)save
{
    //  PHAuthorizationStatusNotDetermined = 0, 用户还没有做出选择
    //  PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
    //  PHAuthorizationStatusDenied,             用户拒绝当前应用访问相册(用户当初点击了"不允许")
    //  PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if(status == PHAuthorizationStatusRestricted){
        [MBProgressHUD showError:@"因为系统原因, 无法访问相册"];
    }else if (status == PHAuthorizationStatusDenied){
        WGLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    }else if (status == PHAuthorizationStatusAuthorized){
        [self saveImage];
    }else if (status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage
{
    // PHAsset : 一个资源，比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    __block NSString *assetLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存相机到"相机胶卷"
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if(success == NO){
            [self showError:@"保存图片失败"];
            return ;
        }
        
        // 2.获取相簿
        PHAssetCollection *createAssetCollection = [self createAssetCollection];
        if(createAssetCollection == nil){
            [self showError:@"创建相簿失败！"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 将“相机胶卷”中的图片添加到“相簿”
            // 获取图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if(success == NO){
                [self showError:@"保存图片失败"];
            }else{
                [self showSuccess:@"保存图片成功"];
            }
        }];
    }];
}

/**
 *   创建一个相簿
 @return  相簿
 */
- (PHAssetCollection *)createAssetCollection
{
    // 从已存在的相簿中查找本应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        if([assetCollection.localizedTitle isEqualToString:WGAssetCollectionTitle]){
            return assetCollection;
        }
    }
    
    // 错误信息
    NSError *error = nil;

    __block NSString *assstCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        assstCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:WGAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    
    if(error) return nil;
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assstCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:text];
    });
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
