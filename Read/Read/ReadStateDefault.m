#import "ReadStateDefault.h"
#import "Globe.h"
@implementation ReadStateDefault
+ (ReadStateDefault *)sharedStateDefault
{
    static dispatch_once_t pred;
    static ReadStateDefault *shared_instance = nil;
    
    dispatch_once(&pred, ^{
        shared_instance = [[self alloc] init];
    });
    
    return shared_instance;
}

- (BOOL)chooseReadState{
    NSDateFormatter *ReadDateFormatter = [[NSDateFormatter alloc] init];
    [ReadDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *ReadStartDate = [ReadDateFormatter dateFromString:ReadTime];
    NSDate *ReadEndDate = [NSDate date];
    NSCalendarUnit ReadUnit = NSCalendarUnitDay;
    NSCalendar *ReadCalendar = [NSCalendar currentCalendar];
    NSDateComponents *ReadDelta = [ReadCalendar components:ReadUnit fromDate:ReadStartDate toDate:ReadEndDate options:0];
    return ReadDelta.day > 5;
    
}

@end
