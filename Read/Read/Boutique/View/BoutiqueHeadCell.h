//
//  BoutiqueHeadCell.h
//  Read
//
//  Created by Jarvis on 2020/12/29.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueHeadCell : UICollectionReusableView
@property (nonatomic,strong) UILabel *category;
@property (nonatomic,strong) SmallCategoryModel *model;
@end

NS_ASSUME_NONNULL_END
