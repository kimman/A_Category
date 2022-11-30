//
//  YIPTableViewCellItem.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YIPTableViewCellItem : NSObject

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *viewController;

@end

NS_ASSUME_NONNULL_END
