//
//  CategoryViewCell.h
//  Read
//
//  Created by Jarvis on 2021/1/14.
//  Copyright © 2021 Jarvis. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "JGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) JGModel *model;
@end

NS_ASSUME_NONNULL_END
