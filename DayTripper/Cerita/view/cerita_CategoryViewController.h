//
//  cerita_CategoryViewController.h
//  Cerita
//
//  Created by Yazid Bustomi on 10/27/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detail2.h"
@interface cerita_CategoryViewController :  UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	UITableView *cerita;
	NSMutableArray *news_array;

	NSInteger total_page;
	NSTimer *workTimer;
	detail2 *detail;
}@end
