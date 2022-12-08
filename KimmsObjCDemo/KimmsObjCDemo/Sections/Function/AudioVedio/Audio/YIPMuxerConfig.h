//
//  YIPMuxerConfig.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/12/5.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "YIPMediaBase.h"

NS_ASSUME_NONNULL_BEGIN


/// MP4参数配置
@interface YIPMuxerConfig : NSObject

/// 封闭输出地址
@property (nonatomic, strong) NSURL *outputURL;
/// 封闭文件类型
@property (nonatomic, assign) YIPMediaType muxerType;
/// 图像的变换信息。比如：视频图像旋转
@property (nonatomic, assign) CGAffineTransform preferredTransform;

@end

NS_ASSUME_NONNULL_END
