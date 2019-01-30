//
//  CustomizedCameraControlView.m
//  TruthU
//
//  Created by Xiao Zhe on 20/9/15.
//  Copyright (c) 2015 Xiao Zhe Com. All rights reserved.
//

#import "CustomizedCameraControlView.h"

@interface CustomizedCameraControlView ()

@end

@implementation CustomizedCameraControlView

- (IBAction)takePictureSaveToGallery:(id)sender {
    //NSLog(@"Take picture from overlay!");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"takePictureSaveToGallery" object:self];
}

- (IBAction)fetchPictureFromGallery:(id)sender {
    //NSLog(@"Access picture from overlay!");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fetchPictureFromGallery" object:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end