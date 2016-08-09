//
//  Movie.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import "Movie.h"

@implementation Movie

//Use encoder to save custom objects to NSUserDefaults. encode, then decode. to nsdata, from nsdata
                       
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_posterImage forKey:@"posterImage"];
    [aCoder encodeObject:_movieTitle forKey:@"movieTitle"];
    [aCoder encodeObject:_movieYear forKey:@"movieYear"];
    [aCoder encodeObject:_movieRuntime forKey:@"movieRuntime"];
    [aCoder encodeObject:_movieRating forKey:@"movieRating"];
    [aCoder encodeObject:_movieRatingTomatoes forKey:@"movieRatingTomatoes"];
    [aCoder encodeObject:_movieRatingTomatoesCertificate forKey:@"movieRatingTomatoesCertificate"];
    [aCoder encodeObject:_movieDirector forKey:@"movieDirector"];
    [aCoder encodeObject:_movieActors forKey:@"movieActors"];
    [aCoder encodeObject:_movieReleased forKey:@"movieReleased"];
    [aCoder encodeObject:_moviePlot forKey:@"moviePlot"];
    [aCoder encodeObject:_movieRated forKey:@"movieRated"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.posterImage = [aDecoder decodeObjectForKey:@"posterImage"];
        self.movieTitle = [aDecoder decodeObjectForKey:@"movieTitle"];
        self.movieYear = [aDecoder decodeObjectForKey:@"movieYear"];
        self.movieRuntime = [aDecoder decodeObjectForKey:@"movieRuntime"];
        self.movieRating = [aDecoder decodeObjectForKey:@"movieRating"];
        self.movieRatingTomatoes = [aDecoder decodeObjectForKey:@"movieRatingTomatoes"];
        self.movieRatingTomatoesCertificate = [aDecoder decodeObjectForKey:@"movieRatingTomatoesCertificate"];
        self.movieDirector = [aDecoder decodeObjectForKey:@"movieDirector"];
        self.movieActors = [aDecoder decodeObjectForKey:@"movieActors"];
        self.movieReleased = [aDecoder decodeObjectForKey:@"movieReleased"];
        self.moviePlot = [aDecoder decodeObjectForKey:@"moviePlot"];
        self.movieRated = [aDecoder decodeObjectForKey:@"movieRated"];
    }
    
    return self;
}

@end
