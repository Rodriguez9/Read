//
//  BaseTableViewCell.m
//  Read
//
//  Created by Jarvis on 2020/12/11.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{}

@end
