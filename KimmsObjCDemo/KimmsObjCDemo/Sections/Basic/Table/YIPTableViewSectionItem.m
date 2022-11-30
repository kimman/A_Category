//
//  YIPTableViewSectionItem.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/27.
//

#import "YIPTableViewSectionItem.h"
#import <YYKit/NSObject+YYModel.h>

@interface YIPTableViewSectionItem ()

@property (nonatomic, strong, readwrite) NSMutableArray *rows;

@property (nonatomic, copy, readwrite) NSString *title;

@end

@implementation YIPTableViewSectionItem

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        _rows = [NSMutableArray new];
    }
    
    return self;
}

- (void)addRow:(id)row {
    [_rows addObject:row];
}

- (NSArray *)rows {
    return [_rows copy];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"rows": [YIPTableViewCellItem class],
    };
}

@end
