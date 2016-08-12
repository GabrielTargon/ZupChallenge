//
//  IMDbModel.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import "IMDbModel.h"
#import "Movie.h"

@interface IMDbModel ()

//@property (weak, nonatomic) NSMutableArray *moviesArray;

@end

@implementation IMDbModel
{
    NSMutableArray *movieIDArray;
    NSMutableArray *moviesArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        movieIDArray = [@[] mutableCopy];
        moviesArray = [@[] mutableCopy];
    }
    return self;
}

// first search
-(void)searchIMDb:(NSString *)forMovie
{
    // Empty out movieIDArray
    [movieIDArray removeAllObjects];
    
    // Convert user input to string without spaces
    NSString *movieStringWithoutSpaces = [forMovie stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
   
    // Convert input string into URL
    NSURL *movieListURL = [NSURL URLWithString:[NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&type=movie", movieStringWithoutSpaces]];
   
    // Get JSON data from web, done asynchronously
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:movieListURL]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        // If no error
        if (!error) {
            
            // get the array from dictionary parsed from JSON
            NSArray *moviesList = [self fetchData:data];
            
            if (moviesList) {
                
                for (NSDictionary *simplifiedMovieDetails in moviesList) {
                    
                    // set the movieIDArray with movie ID's to be used later to avoid duplication of movies displayed
                    [movieIDArray addObject:simplifiedMovieDetails[@"imdbID"]];
                }
                
                // search for movies based on ID
                [self detailedSearch:movieIDArray];
            }
        } else {
            
            // Error
            UIAlertView *failedAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [failedAlertView show];
            NSLog(@"Failed");
        }
    }];
}

- (NSArray *)fetchData:(NSData *)response
{
    NSError *error = nil;
    
    // Parse JSON
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error.description);
        return nil;
    }
    
    // Get array within dictionary
    NSArray *simplifiedMoviesList = parsedData[@"Search"];
    
    return simplifiedMoviesList;
}

// Search for movies with detailed information
-(void)detailedSearch:(NSArray *)movieIDs
{
    // Iterate through movieID's array
    for(int i = 0; i <movieIDs.count; i++) {
        
        // Search web with movie ID's
        NSURL *movieListURL = [NSURL URLWithString:[NSString stringWithFormat: @"http://www.omdbapi.com/?i=%@&type=movie&plot=full&tomatoes=true", movieIDArray[i]]];
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:movieListURL]
                                           queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response2, NSData *data2, NSError *error2)
         {
             if (!error2) {
                 
                 // for each movie, call fetch data to parse into dictionary, so to pass dictionary data into movie object
                 [self fetchData2:data2];
             }
         }];
    }
    
    // call delegate method
    [self performSelectorOnMainThread:@selector(callDelegateMethod) withObject:nil waitUntilDone:NO];
}

- (void)fetchData2:(NSData *)response2
{
    NSError *error = nil;
    
    // Parse JSON
    NSDictionary *movieDictionary = [NSJSONSerialization JSONObjectWithData:response2 options:NSJSONReadingMutableContainers error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error.description);
    }
    // Pass dictionary data into new Movie object
    Movie *movie = [[Movie alloc] init];
    movie.posterImage = movieDictionary[@"Poster"];
    movie.movieTitle = movieDictionary[@"Title"];
    movie.movieYear = movieDictionary[@"Year"];
    movie.movieRuntime = movieDictionary[@"Runtime"];
    movie.movieRating = movieDictionary[@"imdbRating"];
    movie.movieDirector = movieDictionary[@"Director"];
    movie.movieActors = movieDictionary[@"Actors"];
    movie.movieReleased = movieDictionary[@"Released"];
    movie.moviePlot = movieDictionary[@"Plot"];
    movie.movieRatingTomatoes = movieDictionary[@"tomatoMeter"];
    movie.movieRatingTomatoesCertificate = movieDictionary[@"tomatoImage"];
    movie.movieRated = movieDictionary[@"Rated"];
    movie.imdbID = movieDictionary[@"imdbID"];
    
    // Add new Movie object to moviesArray
    [moviesArray addObject:movie];
    
    
}

-(void)callDelegateMethod
{
    // pass in updated moviesArray
    [self.delegate didGetMovies:moviesArray];
}

@end
