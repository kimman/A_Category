//
//  ViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/25.
//

#import "YIPDemoViewController.h"
#import "YIPTableViewController.h"

@interface YIPDemoViewController ()

@end

@implementation YIPDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
}


- (NSArray *)sectionJson {
    return @[
        @{
            @"title": @"基础",
            @"rows": @[
                @{
                    @"title": @"WeakTimer",
                    @"viewController": @"abc"
                },
            ],
        },
        @{
            @"title": @"功能",
            @"rows": @[
                @{
                    @"title": @"音视频",
                    @"viewController": @"YIPAudioVedioDemoViewController"
                },
                @{
                    @"title": @"登录",
                },
            ],
        },
        @{
            @"title": @"效果",
            @"rows": @[
                @{
                    @"title": @"动画",
                },
            ],
        },
        @{
            @"title": @"组件",
            @"rows": @[
                @{
                    @"title": @"验证码",
                },
            ],
        },
    ];
}

- (void)didSelectedItem:(YIPTableViewCellItem *)item {
    Class cls = NSClassFromString(item.viewController);
    UIViewController *ctrl = [[cls alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
