//
//  YIPTableViewController.h
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import <UIKit/UIKit.h>
#import "YIPTableViewSectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YIPTableViewDataSource <NSObject>

@required

/// 数据源的JSON，用于转为列表数据，类型： NSArray / NSString / NSData
- (id)sectionJson;

@optional
- (void)didSelectedItem:(YIPTableViewCellItem *)item;

@end

@interface YIPTableViewController : UIViewController<YIPTableViewDataSource>

@end

NS_ASSUME_NONNULL_END
