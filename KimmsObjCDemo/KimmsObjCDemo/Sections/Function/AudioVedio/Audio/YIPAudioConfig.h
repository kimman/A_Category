//
//  YIPAudioConfig.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 音频采集配置
@interface YIPAudioConfig : NSObject


/// 声道数，默认：2
@property (nonatomic, assign) NSUInteger channels;

/// 采样率，默认：44100
@property (nonatomic, assign) NSUInteger sampleRate;

/// 量化位深，默认：16
@property (nonatomic, assign) NSUInteger bitDepth;


+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
