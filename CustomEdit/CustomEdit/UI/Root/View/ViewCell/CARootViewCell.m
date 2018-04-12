//
//  CARootViewCell.m
//  CustomEdit
//
//  Created by archer.chen on 4/12/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "CARootViewCell.h"

#import "Masonry.h"

@interface CARootViewCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;

@end

@implementation CARootViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initializationViewCell];
    }
    
    return self;
}

- (void)initializationViewCell
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
}

#pragma mark - update constraints
- (void)updateConstraints
{
    [super updateConstraints];
    
    CGFloat labelHeight = self.contentView.frame.size.height - 2 * 8.0f;
    
    // 注意像素对齐
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(10.0f);
        make.width.mas_equalTo(self.contentView.frame.size.width / 2.0f);
        make.height.mas_equalTo(labelHeight);
        
    }];
    
    [self.subtitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-16.0f);
        make.size.mas_equalTo(CGSizeMake(150.0f, labelHeight));
        
    }];
}

#pragma mark - Accessor
- (void)setModel:(CARootModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self updateCell];
    }
}

#pragma mark Lazy Load
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
    }
    
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel)
    {
        _subtitleLabel = [[UILabel alloc] init];
    }
    
    return _subtitleLabel;
}

#pragma mark - Private Methods
- (void)updateCell
{
    self.titleLabel.text = self.model.title;
    self.subtitleLabel.text = self.model.subtitle;
    
    [self setNeedsUpdateConstraints];
}

@end
