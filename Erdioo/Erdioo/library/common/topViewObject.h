//
//  topViewObject.h
//  Erdioo
//
//  Created by Arie on 6/4/13.
//  Copyright (c) 2013 kumel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface topViewObject : NSObject
@property(nonatomic,strong) NSString *IdRadio;
@property(nonatomic,strong) NSString *NamaRadio;
@property(nonatomic,strong) NSString *Genre;
@property(nonatomic,strong) NSString *Logo;
@property(nonatomic,strong) NSString *twitter;
@property(nonatomic,strong) NSString *Lokasi;

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
