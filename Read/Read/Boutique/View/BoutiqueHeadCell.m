//
//  BoutiqueHeadCell.m
//  Read
//
//  Created by Jarvis on 2020/12/29.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BoutiqueHeadCell.h"
#import <Masonry.h>

@implementation BoutiqueHeadCell
- (UILabel *)category{
    if (!_category) {
        _category = [[UILabel alloc] init];
        //_category.font = [UIFont systemFontOfSize:18];
        _category.textColor = [UIColor blackColor];
        [_category setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    }
    return _category;
}

-(void)configUI{
    self.layer.cornerRadius = 15;
    [self addSubview:self.category];
    [self.category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.right.equalTo(self).offset(5);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setModel:(SmallCategoryModel *)model{
    self.model = model;
    self.category.text = [NSString stringWithFormat:@"%@%@",model.major,@">"];
}

@end
