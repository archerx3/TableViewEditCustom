//
//  CARootViewController.m
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "CARootViewController.h"

#import "CARootView.h"

#import "CARootViewModel.h"

@interface CARootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CARootView * contentView;
@property (nonatomic, strong) CARootViewModel * viewModel;

@end

@implementation CARootViewController

#pragma mark - Initialization
- (instancetype)init
{
    if (self = [super init])
    {
        [self initializationRootViewController];
    }
    
    return self;
}

- (void)initializationRootViewController
{
    [self initializationViewModel];
}

- (void)initializationViewModel
{
    _viewModel = [[CARootViewModel alloc] init];
}

#pragma mark - Life Cycle
- (void)loadView
{
    self.view = self.contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Custom Table View Edit";
    
    __weak CARootViewController * weakSelf = self;
    
    self.viewModel.dataUpdateBlock = [^{
        
        [weakSelf reloadContentView];
        
    } copy];
    
    self.viewModel.contentUpdateBlock = [^{
        
        [weakSelf reloadContentView];
        
    } copy];
}

#pragma mark - Public Methods

#pragma mark - Private Methods
#pragma mark Reload View
- (void)reloadContentView
{
    
}

- (void)reloadTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.contentView.tableView reloadData];
        
    });
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 1;
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [self.viewModel numberOfItems];
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    return cell;
}

#pragma mark - UITableView Delegate

#pragma mark - Accessor
- (CARootView *)contentView
{
    if (!_contentView)
    {
        CGRect viewFrame = [UIScreen mainScreen].bounds;
        _contentView = [[CARootView alloc] initWithFrame:viewFrame];
    }
    
    return _contentView;
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
