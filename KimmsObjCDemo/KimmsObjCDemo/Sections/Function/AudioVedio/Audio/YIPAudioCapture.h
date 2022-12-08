//
//  YIPAudioCapture.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "YIPAudioConfig.h"

NS_ASSUME_NONNULL_BEGIN


/// 音频采集模块
@interface YIPAudioCapture : NSObject


/// 采集的参数配置
@property (nonatomic, strong, readonly) YIPAudioConfig *config;

/// 音频采集数据回调
@property (nonatomic, copy) void (^sampleBufferOutputCallback)(CMSampleBufferRef sampleBuffer);

/// 音频采集错误回调
@property (nonatomic, copy) void (^errorCallback)(NSError *error);


+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithConfig:(YIPAudioConfig *)config;

/// 开始采集音频
- (void)start;

/// 停止采集音频
- (void)stop;

@end

NS_ASSUME_NONNULL_END
