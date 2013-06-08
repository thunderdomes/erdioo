//
//  erdiooCenter.m
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "erdiooCenter.h"

@interface erdiooCenter ()

@end
@implementation erdiooCenter
@synthesize erdiooCenter_table;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		indexpath_now=-1;
		searchWindow=[[search alloc]init];
		self.view.backgroundColor=lightGray;
		self.title=AppName;
		erdio=[[NSMutableArray alloc]init];
		
		erdiooCenter_table=[[UITableView alloc]init];
		erdiooCenter_table.delegate=self;
		erdiooCenter_table.dataSource=self;
		[erdiooCenter_table setSeparatorColor:[UIColor colorWithRed:0.875 green:0.875 blue:0.875 alpha:1]];
		erdiooCenter_table.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44);
		erdiooCenter_table.hidden=YES;
		//[erdiooCenter_table setSeparatorColor:[UIColor clearColor]];

		spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
        spinner.hidesWhenStopped = YES;
        [spinner setColor:[UIColor colorWithRed:0.769 green:0.416 blue:0.31 alpha:1]];
        [spinner setInnerRadius:10];
        [spinner setOuterRadius:20];
        [spinner setStrokeWidth:8];
		[spinner setCenter:CGPointMake(160.0,180.0)];
        [spinner setNumberOfStrokes:8];
        [spinner setPatternLineCap:kCGLineCapButt];
		//        [spinner setSegmentImage:[UIImage imageNamed:@"Stick.jpeg"]];
        [spinner setPatternStyle:TJActivityIndicatorPatternStyleBox];
		
		
		[self.view addSubview:spinner];

		
		
		[self.view addSubview:erdiooCenter_table];
		
		[self fetchData];
		
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
		CGRect frame3 = CGRectMake(50, 0, 44, 44);
		UIButton *searchbutton = [[UIButton alloc] initWithFrame:frame3];
		[searchbutton setBackgroundImage:image3 forState:UIControlStateNormal];
		//[searchbutton setBackgroundImage:[UIImage imageNamed:@"search-button-pressed"] forState:UIControlStateHighlighted];
		[searchbutton addTarget:self action:@selector(searchRadio) forControlEvents:UIControlEventTouchUpInside];
		
		UIView *RightbuttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
		RightbuttonView.backgroundColor=[UIColor clearColor];
		[RightbuttonView addSubview:searchbutton];
		
		
		UIBarButtonItem* rightbarButton = [[UIBarButtonItem alloc] initWithCustomView:RightbuttonView];
		
		
		[self.navigationItem setRightBarButtonItem:rightbarButton];
		[self.navigationItem setLeftBarButtonItem:leftbarbutton];
		
		[rightbarButton release];
		
		
		
		
    }
	
    return self;
}
-(void)lefbuttonPush{
	[self.sidePanelController showLeftPanelAnimated:YES];
}
-(void)searchRadio{
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchWindow];
	[self.navigationController presentModalViewController:navigationController animated:YES];
	
}
-(void)fetchData{
	[spinner startAnimating];
	[erdio removeAllObjects];
	NSString * sURL = [NSString stringWithFormat:@"%@?do=mostviewed&key=%@",Global_url,API_key];
	NSLog(@"sURL--->%@",sURL);
	
	NSURL *URL=[NSURL URLWithString:sURL];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	
    AFJSONRequestOperation *operation=[[[AFJSONRequestOperation alloc] initWithRequest:request] autorelease];
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
	
    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"responseObject: %@", [responseObject objectForKey:@"data"]);
		for(id erdioDict in [responseObject objectForKey:@"data"]){
			topViewObject *topView=[[topViewObject alloc] initWithDictionary:erdioDict];
			[erdio addObject:topView];
			
			[topView release];
		}
		[spinner stopAnimating];
		[erdiooCenter_table reloadData];
		[erdiooCenter_table setHidden:NO];
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
		}
        NSLog(@"error: %@", [error description]);
		
	}];
	[operation start];
	// [httpClient release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return erdio.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	topViewObject  *object_draw=[erdio objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"CountryCell";
    
    errdioCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[errdioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
 	if(indexPath.row % 2==0){
		cell.wrapper.backgroundColor=[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1];
	}
	else{
		cell.wrapper.backgroundColor=[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1];
	}
	
	cell.RadioName.text = object_draw.NamaRadio;
	cell.snapped.tag=indexPath.row;
	[cell.snapped addTarget:self action:@selector(snapped:) forControlEvents:UIControlEventTouchUpInside];
	
	cell.Genre.text = object_draw.Genre;
	[cell.Logo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.erdioo.com/icon/?id=%@",object_draw.IdRadio]]placeholderImage:[UIImage imageNamed:@"placeholder"]];
	cell.location_text.text=object_draw.Lokasi;
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	CGFloat cellHeight = 79;
	if (indexpath_now==indexPath.row) {
		cellHeight = 130;
	}
	return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	topViewObject  *object_draw=[erdio objectAtIndex:indexPath.row];
	//[self stream:[NSString stringWithFormat:@"%@",[object_draw.IdRadio]];
	[self stream:object_draw.IdRadio];
	
}
-(void)snapped:(id)sender{
	
	UIButton* button = (UIButton*)sender;
	//UIButton* button2 = (UIButton*)indexpath_now;
 
	if(indexpath_now==[sender tag]){
		indexpath_now=-1;
		button.selected = !button.selected;
		//button2.selected=!button2.selected;
		[erdiooCenter_table beginUpdates];
		[erdiooCenter_table endUpdates];
	
	}
	else{
		indexpath_now=[sender tag];
		   button.selected = !button.selected;
		//button2.selected=!button2.selected;
		[erdiooCenter_table beginUpdates];
		[erdiooCenter_table endUpdates];
	}
	
}
-(void)stream:(NSString*)radioNumber{
	
	
	NSString * sURL = [NSString stringWithFormat:@"%@?id=%@&key=%@",Global_url,radioNumber,API_key];
	
	NSURL *URL=[NSURL URLWithString:sURL];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	
    AFJSONRequestOperation *operation=[[[AFJSONRequestOperation alloc] initWithRequest:request] autorelease];
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];

    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"response object---->%@",responseObject );
		NSString *escapedValue =
		[(NSString *)CFURLCreateStringByAddingPercentEscapes(
															 nil,
															 (CFStringRef)[responseObject objectForKey:@"URLStreaming"],
															 NULL,
															 NULL,
															 kCFStringEncodingUTF8)
		 autorelease];
		
		NSURL *url = [NSURL URLWithString:escapedValue];
		AudioStreamer *stremaer = [[AudioStreamer alloc] initWithURL:url];
		if([stremaer isPlaying]){
			[stremaer stop];
		}
		[stremaer start];
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
		}
        NSLog(@"error: %@", [error description]);
		
	}];
	[operation start];
	
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
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
