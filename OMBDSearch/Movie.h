//
//  Movie.h
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject <NSCoding>

@property (nonatomic) NSString *posterImage;
@property (nonatomic) NSString *movieTitle;
@property (nonatomic) NSString *movieYear;
@property (nonatomic) NSString *movieRuntime;

@property (nonatomic) NSString *movieRating;
@property (nonatomic) NSString *movieRatingTomatoes;
@property (nonatomic) NSString *movieRatingTomatoesCertificate;

@property (nonatomic) NSString *movieDirector;
@property (nonatomic) NSString *movieActors;

@property (nonatomic) NSString *movieReleased;

@property (nonatomic) NSString *moviePlot;

@property (nonatomic) NSString *movieRated;

@property (nonatomic) NSString *imdbID;

@end