//
//  OMDbModel.h
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OMDbModelDelegate <NSObject>

-(void)didGetMovies:(NSMutableArray *)moviesArray; // all delegates must adhere to this protocol method

@end

@interface OMDbModel : NSObject

@property (weak, nonatomic) id <OMDbModelDelegate> delegate; // property for the delegate

-(void)searchIMDb:(NSString *)forMovie;

@end
