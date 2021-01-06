//
//  MineTableViewCell.h
//  Read
//
//  Created by Jarvis on 2020/12/31.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UILabel *detail;

@property (nonatomic,strong) UIImageView *coverImg;
@end

NS_ASSUME_NONNULL_END
