//
//  netra.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/12/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "netra.h"

@implementation netra
@synthesize newsT;
@synthesize newsC;
static netra *sharedObject;
+ (netra*)sharedInstance
{
    if (sharedObject == nil) {
        sharedObject = [[super allocWithZone:NULL] init];
		sharedObject.array = [[NSMutableArray alloc]init];
    }
    return sharedObject;
}

+(NSString *) getNewsTitle{
	netra *shared = [netra sharedInstance];
	
	return shared.newsT;
}
+(NSString *) getContent{
	netra *shared = [netra sharedInstance];
	return shared.newsC;
}
+(NSString *) getPage{
	netra *shared = [netra sharedInstance];
	NSLog(@"page->%@",shared.page);
	return shared.page;
}
+(NSString *) getUrl{
	netra *shared = [netra sharedInstance];
	return shared.url;
}
+(void) setNewsTitle:(NSString *)setNewsTitle{
	netra *shared = [netra sharedInstance];
    shared.newsT = setNewsTitle;
}
+(void) setNewsContent:(NSString *)newsContent{
	netra *shared = [netra sharedInstance];
    shared.newsC = newsContent;
}
+(void) setUrl:(NSString *)url{
	netra *shared = [netra sharedInstance];
    shared.url = url;
}
+(void) setList:(NSString *)list{
	netra *shared = [netra sharedInstance];
	[shared.array addObject:list];
}
+(void) setPage:(NSString *)page{
	NSLog(@"page->%@",page);
	netra *shared = [netra sharedInstance];
	shared.page = page;
}
+(NSMutableArray *) getList{
	netra *shared = [netra sharedInstance];
	return shared.array;
}
@end

