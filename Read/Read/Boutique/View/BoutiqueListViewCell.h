//
//  BoutiqueListViewCell.h
//  Read
//
//  Created by Jarvis on 2020/12/29.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "CategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueListViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) CategoryListBookModel *model;
@property (nonatomic,strong) UILabel *desLabel;
@end

NS_ASSUME_NONNULL_END
