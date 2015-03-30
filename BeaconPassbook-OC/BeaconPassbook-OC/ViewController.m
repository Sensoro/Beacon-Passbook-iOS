//
//  ViewController.m
//  BeaconPassbook-OC
//
//  Created by David Yang on 15/3/30.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <PKAddPassesViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPassbook:(id)sender {
    
    NSURL * passPath = [[NSBundle mainBundle] URLForResource:@"Generic" withExtension:@"pkpass"];
    
    NSError * error = nil;
    NSData * passData = [NSData dataWithContentsOfURL:passPath options:0 error:&error];
    
    PKPass* pkPass = [[PKPass alloc] initWithData:passData error:&error];
    PKPassLibrary * passLibrary = [[PKPassLibrary alloc] init];
    
    BOOL contained = [passLibrary containsPass:pkPass];
    
    if (contained == NO) {
        PKAddPassesViewController *vc = [[PKAddPassesViewController alloc] initWithPass:pkPass];
        if (vc) {
            [vc setDelegate:self];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else{
        [[UIApplication sharedApplication] openURL:[pkPass passURL]];
    }
}

#pragma mark PKAddPassesViewControllerDelegate

-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
