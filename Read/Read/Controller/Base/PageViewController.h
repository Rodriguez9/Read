//
//  PageViewController.h
//  Read
//
//  Created by Jarvis on 2020/12/11.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageViewController : BaseViewController
- (instancetype)init:(NSArray <NSString *>*)titles vcs:(NSArray <UIViewController *> *)vcs;
@property(nonatomic, strong) HMSegmentedControl *segment;
@property(nonatomic, strong) UIPageViewController *pageVC;
@property(nonatomic,readwrite)NSArray <UIViewController *> *vcs;
@property(nonatomic,readwrite)NSArray <NSString *> *titles;
@property (nonatomic,strong) UIView *separate;
-(void)changeIndex:(UISegmentedControl *)segment;
@end

NS_ASSUME_NONNULL_END
