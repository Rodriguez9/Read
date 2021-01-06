//
//  CategoryModel.h
//  Read
//
//  Created by Jarvis on 2020/12/23.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryModel : NSObject
@property (nonatomic, assign) NSInteger bookCount;
@property (nonatomic, strong) NSArray *bookCover;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) NSInteger monthlyCount;
@property (nonatomic, strong) NSString *name;

@end


@interface CategoryListBookModel : NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *shortIntro;

@end


@interface SmallCategoryModel : NSObject
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSMutableArray *mins;
@end

@interface CategoryListModel : NSObject
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) NSString *ok;
@end

@interface RankListModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *shortIntro;
@property (nonatomic, strong) NSString *majorCate;
@property (nonatomic, strong) NSString *minorCate;
@end


NS_ASSUME_NONNULL_END
