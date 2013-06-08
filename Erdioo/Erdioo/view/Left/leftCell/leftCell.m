//
//  leftCell.m
//  Erdioo
//
//  Created by Arie on 6/5/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "leftCell.h"

@implementation leftCell
@synthesize label=_label;
@synthesize icon=_icon;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.label=[[UILabel alloc]initWithFrame:CGRectMake(40, 2, 300, 40)];
		self.label.font=global_font_bold;
		self.label.textColor=[UIColor lightGrayColor];
		self.label.backgroundColor=[UIColor clearColor];
		
		self.icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
		[self.contentView addSubview:self.label];
		[self.contentView addSubview:self.icon];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	self.label.textColor=[UIColor whiteColor];

    // Configure the view for the selected state
}

@end
