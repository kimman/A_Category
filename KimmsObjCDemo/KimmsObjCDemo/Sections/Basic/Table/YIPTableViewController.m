//
//  YIPTableViewController.m
//  KimmsObjCDemo
//
//  Created by Kimm on 2022/11/30.
//

#import "YIPTableViewController.h"

#import <Masonry/Masonry.h>
#import <YYKit/NSObject+YYModel.h>

@interface YIPTableViewController ()<UITableViewDelegate, UITableViewDataSource>

/// 主列表
@property (nonatomic, strong) UITableView *mainContainer;

/// 数据源
@property (nonatomic, strong) NSArray      *dataSources;

@end

@implementation YIPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"";
    
    [self initData];
    
    [self.view addSubview:self.mainContainer];
    [self.mainContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)initData {
    self.dataSources = [NSArray modelArrayWithClass:[YIPTableViewSectionItem class] json:[self sectionJson]];
}

- (NSArray *)sectionJson {
    return @[];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ComponentsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ComponentsCell"];
    }
    YIPTableViewSectionItem *sectionItem = [self.dataSources objectAtIndex:indexPath.section];
    YIPTableViewCellItem *item = [sectionItem.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YIPTableViewSectionItem *sectionItem = [self.dataSources objectAtIndex:section];
    return sectionItem.rows.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YIPTableViewSectionItem *sectionItem = [self.dataSources objectAtIndex:indexPath.section];
    YIPTableViewCellItem *item = [sectionItem.rows objectAtIndex:indexPath.row];
    if ([self respondsToSelector:@selector(didSelectedItem:)]) {
        [self didSelectedItem:item];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YIPTableViewSectionItem *sectionItem = [self.dataSources objectAtIndex:section];
    return sectionItem.title;
}

#pragma mark - Getter & Setter
- (UITableView *)mainContainer {
    if (!_mainContainer) {
        _mainContainer = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainContainer.delegate = self;
        _mainContainer.dataSource = self;
    }
    return _mainContainer;
}


@end
