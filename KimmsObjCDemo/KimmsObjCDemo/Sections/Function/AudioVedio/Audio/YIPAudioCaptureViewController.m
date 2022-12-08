//
//  YIPAudioCaptureViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import "YIPAudioCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YIPAudioCapture.h"
#import "YIPAudioTools.h"
#import "YIPAudioEncoder.h"
#import "YIPMP4Muxer.h"

@interface YIPAudioCaptureViewController ()

@property (nonatomic, strong) YIPAudioConfig *audioConfig;

@property (nonatomic, strong) YIPAudioCapture *audioCapture;

@property (nonatomic, strong) YIPAudioEncoder *audioEncoder;

@property (nonatomic, strong) YIPMuxerConfig *muxerConfig;

@property (nonatomic, strong) YIPMP4Muxer *muxer;

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
    // 启动采集器
    [self.audioCapture start];
    // 启动封装器
    [self.muxer startWriting];
}

- (void)stop {
    // 停止采集器
    [self.audioCapture stop];
    // 停止封装器
    [self.muxer stopWriting:^(BOOL success, NSError * _Nonnull error) {
        NSLog(@"YIPMP4Muxer %@", success ? @"success" : [NSString stringWithFormat:@"error %zi %@", error.code, error.localizedDescription]);
    }];
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
            
            // 存储为PCM文件
//            if (sampleBuffer) {
//                // 1. 获取 CMBlockBuffer，这里面封装着 PCM 数据
//                CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
//                size_t lengthAtOffsetOutput, totalLengthOutput;
//                char *dataPointer;
//
//                // 2.从 CMBlockBuffer 中获取 PCM 数据存储到文件中
//                CMBlockBufferGetDataPointer(blockBuffer, 0, &lengthAtOffsetOutput, &totalLengthOutput, &dataPointer);
//                [self.fileHandle writeData:[NSData dataWithBytes:dataPointer length:totalLengthOutput]];
//            }
            
            // 对buffer进行编码
            [self.audioEncoder encodeSampleBuffer:sampleBuffer];
        };
    }
    
    return _audioCapture;
}

- (YIPAudioEncoder *)audioEncoder {
    if (!_audioEncoder) {
        __weak typeof(self) weakSelf = self;
        _audioEncoder = [[YIPAudioEncoder alloc] initWithAudioBitrate:96000];
        _audioEncoder.errorCallBack = ^(NSError* error) {
            NSLog(@"YIPAudioEncoder error:%zi %@", error.code, error.localizedDescription);
        };
        // 音频编码数据回调。在这里将 AAC 数据写入文件。
        _audioEncoder.sampleBufferOutputCallBack = ^(CMSampleBufferRef sampleBuffer) {
            
            // 存储为AAC文件
//            if (sampleBuffer) {
//                // 1、获取音频编码参数信息。
//                AudioStreamBasicDescription audioFormat = *CMAudioFormatDescriptionGetStreamBasicDescription(CMSampleBufferGetFormatDescription(sampleBuffer));
//
//                // 2、获取音频编码数据。AAC 裸数据。
//                CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
//                size_t totolLength;
//                char *dataPointer = NULL;
//                CMBlockBufferGetDataPointer(blockBuffer, 0, NULL, &totolLength, &dataPointer);
//                if (totolLength == 0 || !dataPointer) {
//                    return;
//                }
//
//                // 3、在每个 AAC packet 前先写入 ADTS 头数据。
//                // 由于 AAC 数据存储文件时需要在每个包（packet）前添加 ADTS 头来用于解码器解码音频流，所以这里添加一下 ADTS 头。
//                [weakSelf.fileHandle writeData:[YIPAudioTools adtsDataWithChannels:audioFormat.mChannelsPerFrame sampleRate:audioFormat.mSampleRate rawDataLength:totolLength]];
//
//                // 4、写入 AAC packet 数据。
//                [weakSelf.fileHandle writeData:[NSData dataWithBytes:dataPointer length:totolLength]];
//            }
            
            // 封装成.m4a
            [weakSelf.muxer appendSampleBuffer:sampleBuffer];
        };
    }
    
    return _audioEncoder;
}

- (YIPMuxerConfig *)muxerConfig {
   if (!_muxerConfig) {
       _muxerConfig = [[YIPMuxerConfig alloc] init];
       NSString *audioPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.m4a"];
       NSLog(@"M4A file path: %@", audioPath);
       [[NSFileManager defaultManager] removeItemAtPath:audioPath error:nil];
       _muxerConfig.outputURL = [NSURL fileURLWithPath:audioPath];
       _muxerConfig.muxerType = YIPMediaAudio;
   }
   
   return _muxerConfig;
}

- (YIPMP4Muxer *)muxer {
   if (!_muxer) {
       _muxer = [[YIPMP4Muxer alloc] initWithConfig:self.muxerConfig];
       _muxer.errorCallBack = ^(NSError* error) {
           NSLog(@"YIPMP4Muxer error:%zi %@", error.code, error.localizedDescription);
       };
   }
   
   return _muxer;
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
