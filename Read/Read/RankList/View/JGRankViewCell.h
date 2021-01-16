

#import "BaseTableViewCell.h"
#import "JGModel.h"
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface JGRankViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UILabel *shortIntroLabel;
@property (nonatomic,strong) UILabel *majorCate;
@property (nonatomic,strong) UILabel *minorCate;
@property (nonatomic,strong) UILabel *Num;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) NSArray <UILabel *> *labels;
@property (nonatomic,strong) UIView *separate;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) JGRankModel *model;

-(void)configUI;
@end

NS_ASSUME_NONNULL_END
