//
//  BoutiqueListViewCell.m
//  Read
//
//  Created by Jarvis on 2020/12/29.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BoutiqueListViewCell.h"
#import <Masonry.h>
#import "APIS.h"

@implementation BoutiqueListViewCell

-(UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.contentMode = UIViewContentModeScaleAspectFill;
        _coverImg.layer.cornerRadius = 5;
        _coverImg.clipsToBounds = YES;
        _coverImg.autoresizesSubviews = YES;
        _coverImg.backgroundColor = [UIColor blackColor];
    }
    return _coverImg;;
}

-(UILabel *)bookName
{
    if (!_bookName) {
        _bookName = [[UILabel alloc] init];
        _bookName.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.99];
        _bookName.font = [UIFont systemFontOfSize:16];
    }
    return _bookName;
}

-(UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor = [UIColor lightGrayColor];
        _desLabel.numberOfLines = 1;
        
    }
    return _desLabel;
}



-(void)configUI{
    
    self.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
  //  self.contentView.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.99];
    [self.contentView addSubview:self.desLabel];
       [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(15);
           make.left.right.equalTo(self.contentView).with.offset(5);
           make.bottom.equalTo(self.contentView).with.offset(-2);
       }];
    
    [self.contentView addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).with.offset(5);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.desLabel.mas_top);
    }];
    
    [self.contentView addSubview:self.coverImg];
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.bookName.mas_top).offset(-5);
    }];
    
   
}

- (void)setModel:(CategoryListBookModel *)model{
    _model = model;
    self.bookName.text = self.model.title;
     self.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,model.cover]]]];
    self.desLabel.text = self.model.shortIntro;
}

@end
