//
//  ViewController.h
//  BeaconPassbook-OC
//
//  Created by David Yang on 15/3/30.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addPassbook:(id)sender;

- (IBAction)saveToAlbum:(id)sender;
@end

