//
//  YIPAudioConfig.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import "YIPAudioConfig.h"

@implementation YIPAudioConfig

+ (instancetype)defaultConfig {
    
    YIPAudioConfig *config  = [[self alloc] init];
    config.channels         = 2;
    config.sampleRate       = 44100;
    config.bitDepth         = 16;
    
    return config;
}

@end
