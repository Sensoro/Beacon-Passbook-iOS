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

- (IBAction)saveToAlbum:(id)sender {
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark PKAddPassesViewControllerDelegate

-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"保存完成"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"不能保存到相册。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}
@end
