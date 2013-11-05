//
//  ceritaViewController.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/12/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "ceritaViewController.h"

@interface ceritaViewController ()

@end
BOOL reload = 0;
BOOL first = 1;
@implementation ceritaViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		details = [[detailViewController alloc]init];
		news_array = [[NSMutableArray alloc]init];
		self.view.backgroundColor = [UIColor whiteColor];
		cerita = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-65)];
		cerita.separatorInset = UIEdgeInsetsZero;
		cerita.delegate = self;
		cerita.dataSource = self;
		[self.view addSubview:cerita];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self fetchCerita];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	
	cerita.tableFooterView = [[UIView alloc] init];
	self.title= @"Day Tripper";
	
	MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(openLeft)];
	[self.navigationItem setRightBarButtonItem:leftDrawerButton animated:YES];
}

-(void)openLeft{
	[vanbungkring openRight];
}
-(void)fetchCerita{
	if(first==1){
		[ProgressHUD show:@"Mengambil Data"];
	}

	[cerita setUserInteractionEnabled:NO];
	NSString *url=[NSString stringWithFormat:@"%@?json=get_recent_posts&page=%@",ApiBaseUrl,[netra getPage]];
	NSString *escaped = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *URL = [NSURL URLWithString:escaped];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	op.responseSerializer = [AFJSONResponseSerializer serializer];
	[op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		total_page  =[[responseObject objectForKey:@"pages"]integerValue];
		if([[responseObject objectForKey:@"posts"] count]!=0){
			for(id news_objects in [responseObject objectForKey:@"posts"]){
				newsModel *object=[[newsModel alloc] initWithDictionary:news_objects];
				if(![news_array containsObject:object]){
					[news_array addObject:object];
				}
				
				
			}
			[cerita reloadData];
			[cerita setUserInteractionEnabled:YES];
			
			if(first==1){
				[ProgressHUD showSuccess:@"Done"];
				first=0;
			}
		}
		else{
			[cerita setUserInteractionEnabled:YES];
				[ProgressHUD showSuccess:@"Done"];
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
		[cerita setUserInteractionEnabled:YES];
			[ProgressHUD showError:@"Error"];
	}];
	
	[[NSOperationQueue mainQueue] addOperation:op];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(current_page<total_page){
		
		return [news_array count]+1;
	}
	
	return [news_array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(indexPath.row==news_array.count){
		return 44;
	}
	else{
		return 260;
	}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	newsModel  *object_draw = [news_array objectAtIndex:indexPath.row];
	[netra setUrl:object_draw.url];
	[netra setNewsTitle:object_draw.Title];
	[netra setNewsContent:object_draw.content];
	[self.navigationController pushViewController:details animated:YES];
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *) loadingCell{
	
	UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicator.center=cell.center;
	[cell addSubview:activityIndicator];
	[activityIndicator startAnimating];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	[activityIndicator startAnimating];
	return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.row<news_array.count){
		return [self beritaCellRow:indexPath];
	}
	else{
		return [self loadingCell];
	}
	
}
-(UITableViewCell *)beritaCellRow:(NSIndexPath *)indexPath{
	newsModel  *object_draw = [news_array objectAtIndex:indexPath.row];
	static NSString *cells = @"FlagigCell";
	ceritaCell *cell = [[ceritaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
	if(cell ==Nil){
		cell = [[ceritaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
	}
	cell.title.text = object_draw.Title;
	cell.excerpt.text = [NSString stringWithFormat:@"By %@",object_draw.excerpt];
	
	
	if([object_draw.excerpt isEqualToString:@"Deasy Elsara"]){
		//
		[cell.avatar setImageWithURL:[NSURL URLWithString:@"http://0.gravatar.com/avatar/ac88fb6ca375713b52c3f446f70387a6?s=45&d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D45&r=G"] placeholderImage:Nil];
	}
	if([object_draw.excerpt isEqualToString:@"Clara Rondonuwu"]){
		//
		[cell.avatar setImageWithURL:[NSURL URLWithString:@"http://0.gravatar.com/avatar/42ccc44cab72f0dd904f294e136bfa76?s=45&d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D45&r=G"] placeholderImage:Nil];
	}
	if([object_draw.excerpt isEqualToString:@"Sica Harum"]){
		//
		[cell.avatar setImageWithURL:[NSURL URLWithString:@"http://1.gravatar.com/avatar/d95268242a0a9083a49006650b0722b3?s=45&d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D45&r=G"] placeholderImage:Nil];
	}
	if([object_draw.excerpt isEqualToString:@"Herajeng Gustiayu"]){
		//
		[cell.avatar setImageWithURL:[NSURL URLWithString:@"http://0.gravatar.com/avatar/cc744006eace21b9f5c869831ae6dd25?s=45&d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D45&r=G"] placeholderImage:Nil];
	}
	[cell.excerpt sizeToFit];
	[cell.thumbnail setImageWithURL:[NSURL URLWithString:object_draw.thumbnail] placeholderImage:[UIImage imageNamed:@"avatar"]];
	return cell;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:YES];
	first=1;
}
///pagination here
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if  (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
		[netra setPage:[NSString stringWithFormat:@"%d",[[netra getPage]intValue] +1]];
		[self fetchCerita];
		return;
	}
}
////refresh table;
- (void)statTodoSomething {
    [workTimer invalidate];
	reload =1;
	[self fetchCerita];
}
- (void)refreshTriggered {
    [self statTodoSomething];
}
- (void)onAllworkDoneTimer {
    [workTimer invalidate];
    workTimer = nil;
    
    
    [cerita.pullToRefreshController didFinishRefresh];
    [cerita reloadData];
}

@end
