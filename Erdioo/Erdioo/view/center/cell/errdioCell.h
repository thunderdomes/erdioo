//
//  errdioCell.h
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface errdioCell : UITableViewCell{

}

@property(nonatomic,strong) UILabel *RadioName;
@property(nonatomic,strong) UILabel *Genre;
@property (nonatomic,strong) UIView *wrapper;
@property (nonatomic,strong) UIImageView *Logo;
@property (nonatomic,strong) UIImageView *location;
@property(nonatomic,strong) UILabel *location_text;
@property(nonatomic,strong) UIButton *snapped;

@end
