//
//  PhotoOverlay.m
//  TruthU
//
//  Created by Xiao Zhe on 23/9/15.
//  Copyright (c) 2015 Xiao Zhe Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "PhotoOverlay.h"

@implementation PhotoOverlay

- (IBAction)closeOnClick:(id)sender {
    [UIView transitionWithView:self.superview
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self removeFromSuperview];
                    }
                    completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayCameraPickerController" object:self];
}


@end

