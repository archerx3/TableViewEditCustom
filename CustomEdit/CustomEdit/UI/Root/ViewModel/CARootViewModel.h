//
//  CARootViewModel.h
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CARootModel;

@interface CARootViewModel : NSObject

@property (nonatomic, copy) void (^contentUpdateBlock)(void);
@property (nonatomic, copy) void (^dataUpdateBlock)(void);

@property (nonatomic, assign, readonly) NSInteger numberOfItems;

- (void)reloadDataSource;

- (CARootModel *)modelAtIndex:(NSInteger)index;

@end
