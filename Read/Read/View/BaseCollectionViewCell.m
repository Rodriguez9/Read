//
//  BaseCollectionViewCell.m
//  Read
//
//  Created by Jarvis on 2020/12/14.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{}

@end
