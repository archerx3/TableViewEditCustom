//
//  CARootViewModel.m
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "CARootViewModel.h"

@interface CARootViewModel ()
{
    NSMutableArray * mItems;
}

@property (nonatomic, assign, readwrite) NSInteger numberOfItems;

- (void)sendContentUpdateSignl;
- (void)sendDataUpdateSignl;

@end

@implementation CARootViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        [self initializationRootViewModel];
    }
    
    return self;
}

- (void)initializationRootViewModel
{
    [self initializationProperty];
    
    [self makeDataSource];
}

- (void)initializationProperty
{
    mItems = [[NSMutableArray alloc] init];
    
    _numberOfItems = 0;
}

#pragma mark - Public
- (CARootModel *)modelAtIndex:(NSInteger)index
{
    CARootModel * model = nil;
    
    if (index < 0 || index >= mItems.count)
    {
        
    }
    else
    {
        model = [mItems objectAtIndex:index];
    }
    
    return model;
}

#pragma mark - Accessor
- (NSInteger)numberOfItems
{
    _numberOfItems = mItems.count;
    
    return _numberOfItems;
}

#pragma mark - Public Methods
- (void)reloadDataSource
{
    [self sendDataUpdateSignl];
}

#pragma mark - Private Methods
#pragma mark Send Signl
- (void)sendContentUpdateSignl
{
    if (self.contentUpdateBlock)
    {
        self.contentUpdateBlock();
    }
}

- (void)sendDataUpdateSignl
{
    if (self.dataUpdateBlock)
    {
        self.dataUpdateBlock();
    }
}

#pragma mark Make Data Source
- (void)makeDataSource
{
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < 10; ++ index)
    {
        CARootModel * model = [[CARootModel alloc] init];
        model.title = [NSString stringWithFormat:@"Test model %@", @(index + 1)];
        model.subtitle = @"Test model subtitle";
        
        [tempArray addObject:model];
    }
    
    [mItems removeAllObjects];
    [mItems addObjectsFromArray:tempArray];
}

@end
