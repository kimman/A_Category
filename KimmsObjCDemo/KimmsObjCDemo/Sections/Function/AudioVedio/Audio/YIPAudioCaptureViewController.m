//
//  YIPAudioCaptureViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import "YIPAudioCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YIPAudioCapture.h"

@interface YIPAudioCaptureViewController ()

@property (nonatomic, strong) YIPAudioConfig *audioConfig;

@property (nonatomic, strong) YIPAudioCapture *audioCapture;

@property (nonatomic, strong) NSFileHandle *fileHandle;

@end

@implementation YIPAudioCaptureViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAudioSession];
    [self setupUI];
}

- (void)dealloc {
    if (_fileHandle) {
        [_fileHandle closeFile];
    }
}

#pragma mark - Setup
- (void)setupUI {
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.title = @"Audio Capture";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Navigation item.
    UIBarButtonItem *startBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    UIBarButtonItem *stopBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(stop)];
    self.navigationItem.rightBarButtonItems = @[startBarButton, stopBarButton];

}

- (void)setupAudioSession {
    NSError *error = nil;
    
    // 1、获取音频会话实例。
    AVAudioSession *session = [AVAudioSession sharedInstance];

    // 2、设置分类和选项。
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    if (error) {
        NSLog(@"AVAudioSession setCategory error.");
        error = nil;
        return;
    }
    
    // 3、设置模式。
    [session setMode:AVAudioSessionModeVideoRecording error:&error];
    if (error) {
        NSLog(@"AVAudioSession setMode error.");
        error = nil;
        return;
    }

    // 4、激活会话。
    [session setActive:YES error:&error];
    if (error) {
        NSLog(@"AVAudioSession setActive error.");
        error = nil;
        return;
    }
}

#pragma mark - Action
- (void)start {
    [self.audioCapture start];
}

- (void)stop {
    [self.audioCapture stop];
}

#pragma mark - Getter & Setter
- (YIPAudioConfig *)audioConfig {
    if (!_audioConfig) {
        _audioConfig = [YIPAudioConfig defaultConfig];
    }
    return _audioConfig;
}

- (YIPAudioCapture *)audioCapture {
    if (!_audioCapture) {
        __weak typeof(self) weakSelf = self;
        _audioCapture = [[YIPAudioCapture alloc] initWithConfig:self.audioConfig];
        _audioCapture.errorCallback = ^(NSError * _Nonnull error) {
            NSLog(@"[YIPAudioCapture error]: %zi %@", error.code, error.localizedDescription);
        };
        
        // 音频采集数据回调。在这里将 PCM 数据写入文件
        _audioCapture.sampleBufferOutputCallback = ^(CMSampleBufferRef  _Nonnull sampleBuffer) {
            __strong typeof(weakSelf) self = weakSelf;
            if (sampleBuffer) {
                // 1. 获取 CMBlockBuffer，这里面封装着 PCM 数据
                CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
                size_t lengthAtOffsetOutput, totalLengthOutput;
                char *dataPointer;
                
                // 2.从 CMBlockBuffer 中获取 PCM 数据存储到文件中
                CMBlockBufferGetDataPointer(blockBuffer, 0, &lengthAtOffsetOutput, &totalLengthOutput, &dataPointer);
                [self.fileHandle writeData:[NSData dataWithBytes:dataPointer length:totalLengthOutput]];
            }
        };
    }
    
    return _audioCapture;
}

- (NSFileHandle *)fileHandle {
    if (!_fileHandle) {
        NSString *audioPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.pcm"];
        NSLog(@"PCM file path: %@", audioPath);
        [[NSFileManager defaultManager] removeItemAtPath:audioPath error:nil];
        [[NSFileManager defaultManager] createFileAtPath:audioPath contents:nil attributes:nil];
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:audioPath];
    }

    return _fileHandle;
}

@end
