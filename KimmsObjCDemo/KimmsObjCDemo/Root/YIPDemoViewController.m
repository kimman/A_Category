//
//  ViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/25.
//

#import "YIPDemoViewController.h"
#import <Masonry/Masonry.h>

@interface YIPDemoViewController ()

@end

@implementation YIPDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.text = @"Hi~ I am Kimm";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}


@end
