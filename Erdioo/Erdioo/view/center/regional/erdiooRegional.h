//
//  erdiooRegional.h
//  Erdioo
//
//  Created by Arie on 6/5/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface erdiooRegional : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	UITableView *regional_radioList;
	NSMutableArray *provinsi;
	TJSpinner *spinner;
	
}
@end
