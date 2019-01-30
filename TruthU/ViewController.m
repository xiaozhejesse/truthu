//
//  ViewController.m
//  TruthU
//
//  Created by Xiao Zhe on 20/9/15.
//  Copyright (c) 2015 Xiao Zhe Com. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)toCameraView:(id)sender {
    [self performSegueWithIdentifier:@"ToCameraView" sender:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
AudioServicesPlaySystemSound(1109);

}

-(void)viewDidAppear:(BOOL)animated{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
