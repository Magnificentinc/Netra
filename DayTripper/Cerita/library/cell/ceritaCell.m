//
//  ceritaCell.m
//  Cerita
//
//  Created by Yazid Bustomi on 10/12/13.
//  Copyright (c) 2013 netra. All rights reserved.
//

#import "ceritaCell.h"

@implementation ceritaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.title = [[UILabel alloc]initWithFrame:CGRectMake(60, 210, 245, 20)];
		self.title.textColor = [UIColor blackColor];
		self.title.numberOfLines = 2;
		self.title.lineBreakMode = NSLineBreakByWordWrapping;
		self.title.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
		
		self.excerpt = [[UILabel alloc]initWithFrame:CGRectMake(60, 230, 200, 20)];
		self.excerpt.textColor = [UIColor darkGrayColor];
		self.excerpt.numberOfLines = 3;
		self.excerpt.lineBreakMode = NSLineBreakByWordWrapping;
		self.excerpt.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
		
		self.thumbnail = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 190)];
		self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
		self.thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
		self.thumbnail.layer.borderWidth = 1.0;
		
		self.avatar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 210, 40, 40)];
		self.avatar.backgroundColor = [UIColor lightGrayColor];
		self.avatar.layer.cornerRadius = 40/2;
		self.avatar.layer.masksToBounds = YES;
		
		self.thumbnail.clipsToBounds = YES;
		[self.contentView addSubview:self.thumbnail];
		[self.contentView addSubview:self.title];
		[self.contentView addSubview:self.avatar];
		[self.contentView addSubview:self.excerpt];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
