//
//  errdioCell.m
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "errdioCell.h"

@implementation errdioCell
@synthesize wrapper=_wrapper;
@synthesize RadioName=_RadioName;
@synthesize Genre=_Genre;
@synthesize location=_location;
@synthesize location_text=_location_text;
@synthesize Logo=_Logo;
@synthesize snapped=_snapped;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
        // Initialization code
		_wrapper=[[UIView alloc]init];
		_wrapper.frame=CGRectMake(0, 0, 320, 79);
		_wrapper.backgroundColor=cell_color;

		
		_RadioName=[[UILabel alloc]init];
		_RadioName.backgroundColor=[UIColor clearColor];
		_RadioName.frame=CGRectMake(90, 5, 180, 20);
		_RadioName.lineBreakMode=NSLineBreakByCharWrapping;
		_RadioName.font=global_font_bold;
		_RadioName.textColor=dark_gray;
		
		_Logo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
		_Logo.backgroundColor=[UIColor clearColor];
		_Logo.layer.cornerRadius = 5.0;
		_Logo.layer.masksToBounds = YES;
		_Logo.layer.borderColor = [UIColor lightGrayColor].CGColor;
		_Logo.layer.borderWidth = 1.0;
		_Logo.hidden=NO;
		
		_snapped=[UIButton buttonWithType:UIButtonTypeCustom];
		[_snapped setBackgroundImage:[UIImage imageNamed:@"shadow"] forState:UIControlStateNormal];
		[_snapped setBackgroundImage:[UIImage imageNamed:@"shadow_push"] forState:UIControlStateHighlighted];
		
		[_snapped setFrame:CGRectMake(10, 5, 70, 70)];
		
		
				
		_Genre=[[UILabel alloc]init];
		_Genre.backgroundColor=[UIColor clearColor];
		_Genre.frame=CGRectMake(90, 25, 180, 20);
		_Genre.font=global_font_medium;
		_Genre.lineBreakMode=NSLineBreakByCharWrapping;
		_Genre.textColor=dark_gray;
		
		_location_text=[[UILabel alloc]init];
		_location_text.backgroundColor=[UIColor clearColor];
		_location_text.frame=CGRectMake(105, 47, 180, 20);
		_location_text.font=global_font_medium_light;
		_location_text.lineBreakMode=NSLineBreakByCharWrapping;
		_location_text.textColor=dark_gray;

		
		_location=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"location_small"]];
		_location.frame=CGRectMake(90, 50, 14, 14);
		_location.backgroundColor=[UIColor clearColor];
		
		[_wrapper addSubview:_RadioName];
		[_wrapper addSubview:_location];
		[_wrapper addSubview:_Genre];
		[_wrapper addSubview:_location_text];
		[_wrapper addSubview:_Logo];
		[_wrapper addSubview:_snapped];
		[self.contentView addSubview:_wrapper];
		[self.contentView setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	[_snapped setBackgroundImage:[UIImage imageNamed:@"shadow_push"] forState:UIControlStateSelected];

    // Configure the view for the selected state
}

@end
