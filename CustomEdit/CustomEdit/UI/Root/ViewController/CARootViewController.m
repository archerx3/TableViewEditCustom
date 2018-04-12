//
//  CARootViewController.m
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "CARootViewController.h"

#import "CARootView.h"
#import "CARootViewCell.h"

#import "CARootViewModel.h"
#import "CARootModel.h"

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
    
    [self.contentView.tableView registerClass:[CARootViewCell class]
                       forCellReuseIdentifier:CARootViewCellIdentifier];
    
    __weak CARootViewController * weakSelf = self;
    
    self.viewModel.dataUpdateBlock = [^{
        
        [weakSelf reloadContentView];
        
    } copy];
    
    self.viewModel.contentUpdateBlock = [^{
        
        [weakSelf reloadContentView];
        
    } copy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.viewModel reloadDataSource];
    
    [self configureNavigationBar];
}

#pragma mark - Navigation Bar
- (void)configureNavigationBar
{
    [self configureNavigationBarLeftBarButtons];
    [self configureNavigationBarRightBarButtons];
}

- (void)configureNavigationBarLeftBarButtons
{
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                      target:self
                                                                                      action:@selector(editButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)configureNavigationBarRightBarButtons
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(doneButtonaction:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

#pragma mark - Public Methods

#pragma mark - Private Methods
#pragma mark - Actions
- (void)editButtonAction:(id)sender
{
    
}

- (void)doneButtonaction:(id)sender
{
    
}

#pragma mark Reload View
- (void)reloadContentView
{
    [self reloadTableView];
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
    
    NSString * cellIdentifier = CARootViewCellIdentifier;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[CARootViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    
    NSInteger index = indexPath.row;
    
    CARootModel * model = [self.viewModel modelAtIndex:index];
    
    [(CARootViewCell *)cell setModel:model];
    
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
        
        _contentView.tableView.dataSource = self;
        _contentView.tableView.delegate = self;
    }
    
    return _contentView;
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
