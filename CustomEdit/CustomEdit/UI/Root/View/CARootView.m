//
//  CARootView.m
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "CARootView.h"
#import "Masonry.h"

@interface CARootView ()

@property (nonatomic, strong, readwrite) UITableView * tableView;

@end

@implementation CARootView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initializationRootView];
    }
    
    return self;
}

- (void)initializationRootView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:self.tableView];
}

#pragma mark - Update Constraints
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
}

#pragma mark - Lazy Load
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
        
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        _tableView.estimatedRowHeight = 0.0f;
        _tableView.estimatedSectionHeaderHeight = 0.0f;
        _tableView.estimatedSectionFooterHeight = 0.0f;
    }
    
    return _tableView;
}

@end
