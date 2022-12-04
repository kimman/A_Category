//
//  YIPFunctionViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import "YIPAudioVedioDemoViewController.h"

@interface YIPAudioVedioDemoViewController ()

@end

@implementation YIPAudioVedioDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"音视频";
}

- (NSArray *)sectionJson {
    return @[
        @{
            @"title": @"",
            @"rows": @[
                @{
                    @"title": @"音频采集",
                    @"viewController": @"YIPAudioCaptureViewController"
                },
                @{
                    @"title": @"AAC编码",
                    @"viewController": @"YIPAudioEncoderViewController"
                },
                @{
                    @"title": @"音频播放",
                    @"viewController": @"abc"
                },
                @{
                    @"title": @"视频采集",
                    @"viewController": @"abc"
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
