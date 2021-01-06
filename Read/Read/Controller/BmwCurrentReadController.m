
#import "BmwCurrentReadController.h"
#import "BmwReadTool.h"
#import "BmwConst_UI.h"

@interface BmwCurrentReadController ()

@end

@implementation BmwCurrentReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [self.view setBackgroundColor:[BmwReadTool shareInstance].theme];
    [self.view addSubview:self.readView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:@"BmwThemeNotification" object:nil];
}

//- (void)viewWillAppear:(BOOL)animated{
//   self.navigationController.navigationBarHidden = YES;
//}


-(void)changeTheme:(NSNotification *)no
{
    [BmwReadTool shareInstance].theme = no.object;
    [self.view setBackgroundColor:[BmwReadTool shareInstance].theme];
}

-(BmwReadView *)readView
{
    if (!_readView) {
        _readView = [[BmwReadView alloc] initWithFrame:CGRectMake(20,40 + HEIGHT_NAVADD_FIT, self.view.frame.size.width-20-20, self.view.frame.size.height-40-50 - HEIGHT_NAVADD_FIT - HEIGHT_NAVADD_FIT)];
        BmwReadTool *config = [BmwReadTool shareInstance];
        _readView.frameRef = [BmwReadTool parserContent:_content config:config bouds:CGRectMake(0,0, _readView.frame.size.width, _readView.frame.size.height)];
    }
    return _readView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
