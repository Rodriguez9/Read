
#import "CurrentReadController.h"
#import "ReadTool.h"
#import "Const_UI.h"

@interface CurrentReadController ()

@end

@implementation CurrentReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [self.view setBackgroundColor:[ReadTool shareInstance].theme];
    [self.view addSubview:self.readView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:@"ThemeNotification" object:nil];
}

-(void)changeTheme:(NSNotification *)no
{
    [ReadTool shareInstance].theme = no.object;
    [self.view setBackgroundColor:[ReadTool shareInstance].theme];
}

-(ReadView *)readView
{
    if (!_readView) {
        _readView = [[ReadView alloc] initWithFrame:CGRectMake(20,40 + HEIGHT_NAVADD_FIT, self.view.frame.size.width-20-20, self.view.frame.size.height-40-50 - HEIGHT_NAVADD_FIT - HEIGHT_NAVADD_FIT)];
        ReadTool *config = [ReadTool shareInstance];
        _readView.frameRef = [ReadTool parserContent:_content config:config bouds:CGRectMake(0,0, _readView.frame.size.width, _readView.frame.size.height)];
    }
    return _readView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
