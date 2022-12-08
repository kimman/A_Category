//
//  YIPMuxerConfig.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/12/5.
//

#import "YIPMuxerConfig.h"

@implementation YIPMuxerConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _muxerType          = YIPMediaAV;
        _preferredTransform = CGAffineTransformIdentity;
    }
    return self;
}

@end
