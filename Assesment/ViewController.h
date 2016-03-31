
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,strong)NSMutableArray* arrMeanings;
@property(nonatomic,strong) IBOutlet UITextField* txtFieldKey;
@property(nonatomic,strong) IBOutlet UITableView* tblData;
-(IBAction)didTapFind:(id)sender;
@end

