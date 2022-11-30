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
                    @"viewController": @"abc"
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

@end
