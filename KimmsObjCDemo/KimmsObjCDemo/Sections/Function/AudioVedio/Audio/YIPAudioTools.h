//
//  YIPAudioTools.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YIPAudioTools : NSObject

+ (NSData *)adtsDataWithChannels:(NSInteger)channels sampleRate:(NSInteger)sampleRate rawDataLength:(NSInteger)rawDataLength;

@end

NS_ASSUME_NONNULL_END
