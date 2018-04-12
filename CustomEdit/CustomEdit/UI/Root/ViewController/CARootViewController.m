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
    
    leftButtonItem.enabled = !self.viewModel.isEditing;
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)configureNavigationBarRightBarButtons
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(doneButtonaction:)];
    
    rightButtonItem.enabled = self.viewModel.isEditing;
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

#pragma mark - Public Methods

#pragma mark - Private Methods
#pragma mark - Actions
- (void)editButtonAction:(id)sender
{
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    self.viewModel.isEditing = YES;
    
    [self.contentView.tableView setEditing:YES animated:YES];
    
    [self reloadContentView];
}

- (void)doneButtonaction:(id)sender
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.viewModel.isEditing = NO;
    
    [self.contentView.tableView setEditing:NO animated:YES];
    
    [self reloadContentView];
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

#pragma mark Edit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableView Delegate
#pragma mark Edit
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle = UITableViewCellEditingStyleNone;
    
    if (self.viewModel.isEditing)
    {
        editingStyle = UITableViewCellEditingStyleDelete;
    }
    
    return editingStyle;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * titleFOrDeleteConfirmationButton = @"Sure";
    
    return titleFOrDeleteConfirmationButton;
}

#pragma mark NS_AVAILABLE_IOS(8_0)
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * actions = [NSMutableArray array];
    
    UITableViewRowAction * normalRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                                title:@"Normal"
                                                                              handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                  
                                                                              }];
    
    [actions addObject:normalRowAction];
    
    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                                title:@"Destrutive"
                                                                              handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                  
                                                                              }];
    
    [actions addObject:deleteRowAction];
    
    UITableViewRowAction * defaultRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                                 title:@"Default"
                                                                               handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                   
                                                                               }];
    
    [actions addObject:defaultRowAction];
    
    return actions;
}

#pragma mark API_AVAILABLE(ios(11.0))
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0))
{
    UISwipeActionsConfiguration * leadingConfiguration = nil;
    
    NSMutableArray * actions = [NSMutableArray array];
    
    UIContextualAction * normalAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                title:@"Normal"
                                                                              handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                    
                                                                                }];
    normalAction.backgroundColor = [UIColor greenColor];
    [actions addObject:normalAction];
    
    UIContextualAction * destuctiveAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                                    title:@"Destructive"
                                                                                  handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                      
                                                                                  }];
    [destuctiveAction setBackgroundColor:[UIColor blueColor]];
    [actions addObject:destuctiveAction];
    
    leadingConfiguration = [UISwipeActionsConfiguration configurationWithActions:actions];
    
    return leadingConfiguration;
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0))
{
    UISwipeActionsConfiguration * trailingConfiguration = nil;
    
    NSMutableArray * actions = [NSMutableArray array];
    
    UIContextualAction * normalAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                title:@"Normal"
                                                                              handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                  
                                                                              }];
    normalAction.backgroundColor = [UIColor greenColor];
    [actions addObject:normalAction];
    
    UIContextualAction * destuctiveAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                                    title:@"Destructive"
                                                                                  handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                      
                                                                                  }];
    [destuctiveAction setBackgroundColor:[UIColor blueColor]];
    [actions addObject:destuctiveAction];
    
    trailingConfiguration = [UISwipeActionsConfiguration configurationWithActions:actions];
    
    return trailingConfiguration;
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

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
