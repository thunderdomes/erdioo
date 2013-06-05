//
//  topViewObject.m
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import "topViewObject.h"

@implementation topViewObject
@synthesize IdRadio=_IdRadio;
@synthesize NamaRadio=_NamaRadio;
@synthesize Genre=_Genre;
@synthesize twitter=_twitter;
@synthesize Logo=_Logo;
@synthesize Lokasi=_Lokasi;
-(id)initWithDictionary:(NSDictionary *)dictionary{
	self=[super init];
	if(self){
		self.IdRadio=[dictionary objectForKey:@"IdRadio"];
		self.NamaRadio=[dictionary objectForKey:@"NamaRadio"];
		self.Genre=[dictionary objectForKey:@"Genre"];
		self.twitter=[dictionary objectForKey:@"twitter"];
		self.Lokasi=[dictionary objectForKey:@"Lokasi"];
		self.Logo=[dictionary objectForKey:@"Logo"];
	
				
	}
	return self;
	
}
@end
