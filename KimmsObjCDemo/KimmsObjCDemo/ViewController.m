//
//  ViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/25.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [UILabel new];
    label.text = @"Hi~ I am Kimm";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}


@end
