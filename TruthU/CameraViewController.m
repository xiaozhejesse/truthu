//
//  CameraViewController.m
//  TruthU
//
//  Created by Xiao Zhe on 20/9/15.
//  Copyright (c) 2015 Xiao Zhe Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraViewController.h"
#import "CustomizedCameraControlView.h"
#import "PhotoOverlay.h"

@interface CameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic) UIImagePickerController *pickerController;
@property(nonatomic) CustomizedCameraControlView *overlay;
@property int captureOrGalleryFlag; // 0 from camera capture, 1 from gallery
@property int displayPickerControllerFlag; //whether display camera picker controller, 0 display, 1 not display
@property CGFloat width;
@property CGFloat height;

@end

@implementation CameraViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.displayPickerControllerFlag=0;
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.width = CGRectGetWidth(screen);
    self.height = CGRectGetHeight(screen);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takePhoto:) name:@"takePictureSaveToGallery" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectPhoto:) name:@"fetchPictureFromGallery" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayPickerController:) name:@"displayCameraPickerController" object:nil];
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    
    self.pickerController = [UIImagePickerController new];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else
    {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.pickerController.showsCameraControls = NO;
    
    if(self.pickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 0.0);
        self.pickerController.cameraViewTransform = translate;
        CGAffineTransform scale;
        if(fabs(self.width/self.height-3.0/4.0)<0.1){
            scale = CGAffineTransformScale(translate, -1.0, 1.0);
        }else{
            scale = CGAffineTransformScale(translate, -self.width/320.0, self.width/320.0);
        }
        self.pickerController.cameraViewTransform = scale;   
    } else {
        self.pickerController.cameraViewTransform = CGAffineTransformIdentity;
    }
    self.pickerController.delegate = self;
    
    self.overlay = [[CustomizedCameraControlView alloc] initWithNibName:@"CustomizedCameraControlView" bundle:nil];
    self.overlay.view.frame = self.pickerController.cameraOverlayView.frame;
    self.overlay.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.overlay.view.opaque = NO;
    
    self.pickerController.cameraOverlayView = self.overlay.view;
    if (self.displayPickerControllerFlag!=1) {
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }
    
}


- (void)viewDidUnload {
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.captureOrGalleryFlag == 0) {
        self.displayPickerControllerFlag = 0;//display
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    }else{
        self.displayPickerControllerFlag = 1;//not display
        PhotoOverlay *overlayView = [[NSBundle mainBundle] loadNibNamed:@"PhotoOverlay" owner:self options:nil][0];
        overlayView.frame = self.pickerController.view.frame;
        overlayView.imageView.image = newImage;
        [UIView transitionWithView:self.view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self.view addSubview:overlayView];
                        }
                        completion:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)takePhoto:(NSNotification*)notification{
    self.captureOrGalleryFlag = 0;
    
    //NSLog(@"takePhoto called from cameracontroller");
    self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    [self.pickerController takePicture];
    
}

- (void)selectPhoto:(NSNotification*)notification {
    self.captureOrGalleryFlag = 1;
    
    //NSLog(@"selectPhoto called from cameracontroller");
    self.pickerController.allowsEditing = YES;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}


- (void)displayPickerController:(NSNotification*)notification {
    CameraViewController *newCameraController = [[CameraViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:newCameraController animated:YES completion:nil];
}
@end



