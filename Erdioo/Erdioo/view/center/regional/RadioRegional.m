//
//  RadioRegional.m
//  Erdioo
//
//  Created by Arie on 6/7/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "RadioRegional.h"

@interface RadioRegional ()

@end

@implementation RadioRegional

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)] autorelease];
		[backButton setBackgroundImage:[UIImage imageNamed:back] forState:UIControlStateNormal];
		[backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem * backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
		self.navigationItem.leftBarButtonItem = backButtonItem;
        // Custom initialization
		regional=[[NSMutableArray alloc]init];
		
		self.view.backgroundColor=lightGray;
		
		regional_table=[[UITableView alloc]init];
		regional_table.delegate=self;
		regional_table.dataSource=self;
		[regional_table setSeparatorColor:[UIColor colorWithRed:0.875 green:0.875 blue:0.875 alpha:1]];
		regional_table.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44);
		//[erdiooCenter_table setSeparatorColor:[UIColor clearColor]];
		regional_table.backgroundColor=[UIColor clearColor];
		
		[self.view addSubview:regional_table];
		
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
	self.title=self.NamaPropinsi;
	[self fetchData:self.idPropinsi];
}
-(void)fetchData:(NSString*)idPropinsi{
	[regional removeAllObjects];
	NSString * sURL = [NSString stringWithFormat:@"%@?do=listPropinsi&id=%@&key=%@",Global_url,idPropinsi,API_key];
	NSLog(@"sURL--->%@",sURL);
	
	NSURL *URL=[NSURL URLWithString:sURL];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	
    AFJSONRequestOperation *operation=[[[AFJSONRequestOperation alloc] initWithRequest:request] autorelease];
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
	
    //AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"responseObject: %@", [responseObject objectForKey:@"data"]);
		
		
		for(id erdioDict in [responseObject objectForKey:@"data"]){
			topViewObject *radioDaerah=[[topViewObject alloc] initWithDictionary:erdioDict];
			[regional addObject:radioDaerah];
			
			[radioDaerah release];
		}
		
		[regional_table reloadData];
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(error){
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
	return regional.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	topViewObject  *object_draw=[regional objectAtIndex:indexPath.row];
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
	
	cell.Genre.text = object_draw.Genre;
	[cell.Logo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.erdioo.com/icon/?id=%@",object_draw.IdRadio]]placeholderImage:[UIImage imageNamed:@"placeholder"]];
	cell.location_text.text=object_draw.Lokasi;
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return  79;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)dealloc{
	[super dealloc];
	[self.idPropinsi release];
	[self.NamaPropinsi release];
	[self.title release];
	
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
