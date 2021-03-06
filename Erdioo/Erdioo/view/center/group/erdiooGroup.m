//
//  erdiooGroup.m
//  Erdioo
//
//  Created by Arie on 6/5/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "erdiooGroup.h"
#import "regionalCell.h"
#import "erdiooGroupDetail.h"
@interface erdiooGroup ()

@end

@implementation erdiooGroup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title=@"Radio Group";
		groupList=[[NSMutableArray alloc]init];
		
		self.view.backgroundColor=lightGray;
		
		group=[[UITableView alloc]init];
		group.delegate=self;
		group.hidden=YES;
		group.dataSource=self;
		[group setSeparatorColor:[UIColor colorWithRed:0.875 green:0.875 blue:0.875 alpha:1]];
		group.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44);
		//[erdiooCenter_table setSeparatorColor:[UIColor clearColor]];
		group.backgroundColor=[UIColor clearColor];
		
		[self.view addSubview:group];
		spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
        spinner.hidesWhenStopped = YES;
        [spinner setColor:[UIColor colorWithRed:0.769 green:0.416 blue:0.31 alpha:1]];
        [spinner setInnerRadius:10];
        [spinner setOuterRadius:20];
        [spinner setStrokeWidth:8];
		[spinner setCenter:CGPointMake(160.0,180.0)];
        [spinner setNumberOfStrokes:8];
        [spinner setPatternLineCap:kCGLineCapButt];
        [spinner setPatternStyle:TJActivityIndicatorPatternStyleBox];
		
		
		[self.view addSubview:spinner];

		
		UIImage* image = [UIImage imageNamed:@"left"];
		CGRect frame = CGRectMake(-5, 0, 44, 44);
		UIButton* leftbutton = [[UIButton alloc] initWithFrame:frame];
		[leftbutton setBackgroundImage:image forState:UIControlStateNormal];
		//[leftbutton setBackgroundImage:[UIImage imageNamed:@"left-push"] forState:UIControlStateHighlighted];
		[leftbutton addTarget:self action:@selector(lefbuttonPush) forControlEvents:UIControlEventTouchUpInside];
		
		UIView *leftbuttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
		leftbuttonView.backgroundColor=[UIColor clearColor];
		[leftbuttonView addSubview:leftbutton];
		UIBarButtonItem* leftbarbutton = [[UIBarButtonItem alloc] initWithCustomView:leftbuttonView];
		
		
		UIImage* image3 = [UIImage imageNamed:@"search"];
		CGRect frame3 = CGRectMake(5, 0, 44, 44);
		UIButton *searchbutton = [[UIButton alloc] initWithFrame:frame3];
		[searchbutton setBackgroundImage:image3 forState:UIControlStateNormal];
		//[searchbutton setBackgroundImage:[UIImage imageNamed:@"search-button-pressed"] forState:UIControlStateHighlighted];
		//[searchbutton addTarget:self action:@selector(searchRadio) forControlEvents:UIControlEventTouchUpInside];
		
		UIView *RightbuttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
		RightbuttonView.backgroundColor=[UIColor clearColor];
		[RightbuttonView addSubview:searchbutton];
		
		
		UIBarButtonItem* rightbarButton = [[UIBarButtonItem alloc] initWithCustomView:RightbuttonView];
		
		
		[self.navigationItem setRightBarButtonItem:rightbarButton];
		[self.navigationItem setLeftBarButtonItem:leftbarbutton];
		
		[rightbarButton release];
		[leftbarbutton release];
		
			[self fetchData];
		
    }
    return self;
}
-(void)lefbuttonPush{
	[self.sidePanelController showLeftPanelAnimated:YES];
}
-(void)searchRadio{
	//UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchWindow];
	//[self.navigationController presentModalViewController:navigationController animated:YES];
	
}
-(void)fetchData{
	group.hidden=YES;
	[groupList removeAllObjects];
	[spinner startAnimating];
	
	NSString * sURL = [NSString stringWithFormat:@"%@?do=group&key=%@",Global_url,API_key];
	NSLog(@"sURL--->%@",sURL);
	
	NSURL *URL=[NSURL URLWithString:sURL];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	
    AFJSONRequestOperation *operation=[[[AFJSONRequestOperation alloc] initWithRequest:request] autorelease];
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
	
    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"responseObject: %@", [responseObject objectForKey:@"data"]);
		
		
		for(id erdioDict in [responseObject objectForKey:@"data"]){
			groupRadio *groups=[[groupRadio alloc] initWithDictionary:erdioDict];
			[groupList addObject:groups];
			
			[groups release];
		}
		group.hidden=NO;
		[spinner stopAnimating];
		[group reloadData];
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
			group.hidden=YES;
			[spinner stopAnimating];
		}
        NSLog(@"error: %@", [error description]);
		
	}];
	[operation start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return groupList.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	groupRadio  *object_draw=[groupList objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"CountryCell";
    
    regionalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[regionalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
 	if(indexPath.row % 2==0){
		cell.contentView.backgroundColor=[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1];
	}
	else{
		cell.contentView.backgroundColor=[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1];
	}
	NSLog(@"object_draw.NamaGrup--->%@",object_draw.NamaGrup);
	cell.maps.hidden=YES;
	cell.NamaDaerah.text=object_draw.NamaGrup;
	cell.JumlahRadio.text=[NSString stringWithFormat:@"%@ Radio",object_draw.JumlahRadio];
	cell.selectionStyle=UITableViewCellEditingStyleNone;
	
	
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return  63;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	erdiooGroupDetail *detail=[[erdiooGroupDetail alloc]init];
	groupRadio  *object_draw=[groupList objectAtIndex:indexPath.row];
	detail.NamaPropinsi=object_draw.NamaGrup;
	detail.idPropinsi=object_draw.IdGrup;
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];

}


-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:navbar] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
