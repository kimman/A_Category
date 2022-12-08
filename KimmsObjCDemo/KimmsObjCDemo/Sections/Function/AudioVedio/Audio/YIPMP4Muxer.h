//
//  YIPMP4Muxer.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/12/5.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "YIPMuxerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIPMP4Muxer : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfig:(YIPMuxerConfig *)config;

@property (nonatomic, strong, readonly) YIPMuxerConfig *config;
@property (nonatomic, copy) void (^errorCallBack)(NSError *error); // 封装错误回调。

- (void)startWriting; // 开始封装写入数据。
- (void)cancelWriting; // 取消封装写入数据。
- (void)appendSampleBuffer:(CMSampleBufferRef)sampleBuffer; // 添加封装数据。
- (void)stopWriting:(void (^)(BOOL success, NSError *error))completeHandler; // 停止封装写入数据。

@end

NS_ASSUME_NONNULL_END
