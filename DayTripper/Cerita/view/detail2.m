//
//  detail2.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/27/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "detail2.h"

@interface detail2 ()

@end

@implementation detail2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.view.backgroundColor = [UIColor whiteColor];
		localView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-65)];
		localView.hidden =YES;
		
		[self.view addSubview:localView];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
;
	// Do any additional setup after loading the view.
}

-(void)fetchCerita{
	NSString *url=[NSString stringWithFormat:@"http://flagig.com/api/get_post/?post_id=%@",[netra getNewsTitle]];
	NSString *escaped = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *URL = [NSURL URLWithString:escaped];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	op.responseSerializer = [AFJSONResponseSerializer serializer];
	[op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		
		title = [[[responseObject objectForKey:@"post"]objectForKey:@"title"]stripHtml];
		contents = [[responseObject objectForKey:@"post"]objectForKey:@"content"];
		
		[self draw];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	
	[[NSOperationQueue mainQueue] addOperation:op];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
	[self fetchCerita];
	[vanbungkring disableSwipe];
	[super viewWillAppear:animated];
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet:)];
	self.navigationItem.rightBarButtonItem = anotherButton;

}
-(void)draw{
	NSString *content = [NSString stringWithFormat:@"<html> \n"
						 "<head> \n"
						 "<style type=\"text/css\">"
						 "* {"
						 "-webkit-touch-callout: none;"
						 "-webkit-user-select: none;" /* Disable selection/copy in UIWebView */
						 "}"
						 "body {background:#fff;font-family:\"AvenirNext-Regular\";}"
						 "p {color:#666; font-size:14px}"
						 "a{text-decoration:none}"
						 "img{width:300px;height: auto;}"
						 "iframe {"
						" margin-top: 20px;"
						 "margin-bottom: 30px;max-width:300px;}"
						 "h1 {color:#666; font-size:22px}"
						 "</style>"
						 "</head> \n"
						 "<body\"><h1>%@</h1> %@</body> \n"
						 "</html>",title,contents];
	[localView reload];
	localView.hidden =NO;
	[localView loadHTMLString:content baseURL:nil];
}
- (void)showActionSheet:(id)sender //Define method to show action sheet
{
    NSString *actionSheetTitle = @"Share to Social Media"; //Action Sheet Title
    NSString *other1 = @"Facebook Share";
    NSString *other2 = @"Twitter Share";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
															 delegate:self
													cancelButtonTitle:Nil
											   destructiveButtonTitle:cancelTitle
													otherButtonTitles:other1, other2, nil];
    
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Facebook Share"]) {
        [self facebookShare];
    }
    if ([buttonTitle isEqualToString:@"Twitter Share"]) {
        [self twitterShare];
    }
	
}
-(void)twitterShare{
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [controller setInitialText:[NSString stringWithFormat:@"%@ via Flagig For Iphone",title]];
		
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
	else{
		
		UIAlertView *myalertView = [[UIAlertView alloc]initWithTitle:@"Twitter"
															 message:@"There's no Twitter Account, please setting it first" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[myalertView show];
	}
}
-(void)facebookShare{
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[NSString stringWithFormat:@"%@ via Flagig For Iphone",title]];
		
        
        [self presentViewController:controller animated:YES completion:Nil];
		[controller setCompletionHandler:^(SLComposeViewControllerResult result){
			
		}];
        
    }
	else{
		
		UIAlertView *myalertView = [[UIAlertView alloc]initWithTitle:@"Facebook"
															 message:@"There's no Facebook Account, please setting it first" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[myalertView show];
	}
	
}
-(void)email{
	
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[vanbungkring enableSwipe];
	localView.hidden =YES;
}


@end
