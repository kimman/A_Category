//
//  YIPTableViewSectionItem.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import "YIPTableViewCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIPTableViewSectionItem : NSObject

@property (nonatomic, strong, readonly) NSArray *rows;

@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;

- (void)addRow:(id)row;

@end

NS_ASSUME_NONNULL_END
