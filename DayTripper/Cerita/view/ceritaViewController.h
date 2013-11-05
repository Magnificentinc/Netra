//
//  ceritaViewController.h
//  Cerita
//
//  Created by Yazid Bustomi on 10/12/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detail2.h"
#import "detailViewController.h"
@interface ceritaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	UITableView *cerita;
	NSMutableArray *news_array;
	NSInteger current_page;
	NSInteger total_page;
	NSTimer *workTimer;
	detailViewController *details;
	detail2 *detail;
}
@end
