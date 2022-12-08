//
//  YIPMediaBase.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/12/5.
//

#ifndef YIPMediaBase_h
#define YIPMediaBase_h

typedef NS_ENUM(NSInteger, YIPMediaType) {
    YIPMediaNone    = 0,
    YIPMediaAudio   = 1 << 0,   // 仅音频
    YIPMediaVideo   = 1 << 1,   // 仅视频
    YIPMediaAV      = YIPMediaAudio | YIPMediaVideo,    // 音视频
};

#endif /* YIPMediaBase_h */
