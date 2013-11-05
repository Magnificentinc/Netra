//
//  rightViewController.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/27/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "rightViewController.h"

@interface rightViewController ()

@end

@implementation rightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.view.backgroundColor = [UIColor blackColor];
		table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20,270,self.view.frame.size.height)];
		table.backgroundColor =[UIColor colorWithRed:0.224 green:0.231 blue:0.231 alpha:1];
		table.separatorColor = [UIColor colorWithRed:0.102 green:0.102 blue:0.102 alpha:1];
		table.delegate=self;
		table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
		table.dataSource = self;
		[self.view addSubview:table];
        // Custom initialization
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	cell.backgroundColor = [UIColor clearColor];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Home";
			cell.imageView.image = [UIImage imageNamed:@"home"];
			break;
		case 1:
			cell.textLabel.text = @"Day Tripper";
			cell.imageView.image = [UIImage imageNamed:@"dt"];
			break;
		case 2:
			cell.textLabel.text = @"A Place to Stay";
			cell.imageView.image = [UIImage imageNamed:@"ptt"];
			break;
		case 3:
			cell.textLabel.text = @"In The Air";
			cell.imageView.image = [UIImage imageNamed:@"air"];
			break;
			
		case 4:
			cell.textLabel.text = @"Meet the Travelers";
			cell.imageView.image = [UIImage imageNamed:@"mtt"];
			break;
		case 5:
			cell.textLabel.text = @"Traveling Tips";
			cell.imageView.image = [UIImage imageNamed:@"tt"];
			break;
		case 6:
			cell.textLabel.text = @"Where To Go";
			cell.imageView.image = [UIImage imageNamed:@"wtg"];
			break;
	}
	UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:0.102 green:0.102 blue:0.102 alpha:1];
    cell.selectedBackgroundView =  customColorView;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 0:
			[vanbungkring setCenter:@"ceritaViewController" title:@"Flagig" cat:@""];
			break;
		case 1:
			//[netra setNewsContent:@"25"];
			[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Music" cat:@"65"];
	
			break;
		case 2:
			[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Movie" cat:@"18"];
			//[netra setNewsContent:@"132"];
			break;
			
		case 3:
			[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Fashion" cat:@"200"];
			//[netra setNewsContent:@"24"];
			break;
		case 4:
			[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Event" cat:@"71"];
			//[netra setNewsContent:@"134"];
			break;
		case 5:
			[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Tech" cat:@"1"];
			//[netra setNewsContent:@"26"];
			break;
		default:[vanbungkring setCenter:@"cerita_CategoryViewController" title:@"Tech" cat:@"15"];
			//[netra setNewsContent:@"26"];
			break;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
