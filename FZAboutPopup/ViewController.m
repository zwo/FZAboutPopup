//
//  ViewController.m
//  FZAboutPopup
//
//  Created by Zhou Weiou on 15-6-27.
//  Copyright (c) 2015年 Zhou Weiou. All rights reserved.
//

#import "ViewController.h"
#import "FZAboutPopup.h"

@interface ViewController ()

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

- (IBAction)onAboutButton:(id)sender
{
    FZAboutPopup *about=[[FZAboutPopup alloc] initWithIconImage:[UIImage imageNamed:@"Icon-iPhone-76"]];
    [about show];
}

@end
