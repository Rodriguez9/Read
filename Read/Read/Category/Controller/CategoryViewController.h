//
//  CategoryViewController.h
//  Read
//
//  Created by Jarvis on 2021/1/14.
//  Copyright © 2021 Jarvis. All rights reserved.
//

#import "BaseViewController.h"
#import "JGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewController : BaseViewController
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSMutableArray<JGModel *> *CategoryList;
@property(nonatomic, strong) UIButton *sexTypeButton;
@property(nonatomic,assign) NSString *sexType;

@end

NS_ASSUME_NONNULL_END
