

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrMeanings = [NSMutableArray array];
}
#pragma mark
#pragma mark UiTableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrMeanings.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"MeaningCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    UILabel* lblWord = (UILabel*)[cell viewWithTag:1001];
    NSDictionary* dic = [_arrMeanings objectAtIndex:indexPath.row];
    lblWord.text = [dic valueForKey:@"lf"];
    return cell;
}
#pragma mark
#pragma mark UiTableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(IBAction)didTapFind:(id)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString* path  = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=";
    
    NSURL *baseURL = [NSURL URLWithString:@"http://www.nactem.ac.uk/software/acromine/dictionary.py"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    [manager GET:[NSString stringWithFormat:@"%@%@",path,_txtFieldKey.text] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]]) {
             NSArray* arrMain = (NSArray*)responseObject;
             NSDictionary* dic = [arrMain objectAtIndex:0];
             self.arrMeanings = [dic valueForKey:@"lfs"];
             NSLog(@"data: %@", _arrMeanings);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [_tblData reloadData];
             });
         }
         
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         // Failure
         NSLog(@"Failure: %@", [error description]);
     }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
