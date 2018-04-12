//
//  CARootViewCell.h
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CARootModel.h"

static NSString * CARootViewCellIdentifier = @"CARootViewCellIdentifier";

@interface CARootViewCell : UITableViewCell

@property (nonatomic, strong) CARootModel * model;

@end
