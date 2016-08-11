//
//  MovieDetailsTVC.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/25/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import "MovieDetailsTVC.h"
#import "Movie.h"
#import "DetailedMovieCell.h"
#import "MovieSearchVC.h"
#import "Movie.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MovieDetailsTVC ()

@end

@implementation MovieDetailsTVC
{
    Movie *movie;
    NSData *posterData;
    NSMutableArray *favoriteMovies;
    NSMutableArray *arr; // To Do: rename
    NSUserDefaults * defaults;
    
    UIBarButtonItem *favoriteButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Persistent Storage
    defaults = [NSUserDefaults standardUserDefaults];
    
    self.title = @"Movie Info";
    self.view.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Favorite Button
    favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"heart.png"]
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(addToFavorites)];
    self.navigationItem.rightBarButtonItem = favoriteButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    // Unarchive movie data into object
    NSData *data = [defaults objectForKey:@"movieObject"];
    movie = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // To Do: do i need this?
    favoriteMovies = [@[] mutableCopy];
    
/*
    CRASHES!
 
    // Unarchive favoriteMovies into temporary array if exists
    arr = [[defaults objectForKey:@"favoriteMovies"] mutableCopy];
    if (arr.count > 0) {
        NSData *data2 = [defaults objectForKey:@"favoriteMovies"];
        favoriteMovies = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    }
    NSLog(@"%ld", arr.count);
*/

    // Set back button color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    // Poster
    NSURL *posterURL = [NSURL URLWithString:movie.posterImage];
    posterData = [[NSData alloc] initWithContentsOfURL:posterURL];
    
    // Scroll to top
    [self.tableView setContentOffset:CGPointZero animated:NO];
    
    // Refresh data
    [self.tableView reloadData];
}

#pragma mark Table View Datasource Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TO DO: needs to be dynamically adjusted to plot length
    return 800;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailedMovieCell *detailedMovieCell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (detailedMovieCell == nil) {
        detailedMovieCell = [[DetailedMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    // Use placeholder image if no image available
    if ([movie.posterImage isEqualToString:@"N/A"]) {
        detailedMovieCell.posterImageView.image = [UIImage imageNamed:@"no_movie.png"];
        detailedMovieCell.posterImageView.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
    } else {
        detailedMovieCell.posterImageView.image = [UIImage imageWithData:posterData];
    }
    
    // Info
    detailedMovieCell.movieTitleLabel.text = movie.movieTitle;
    detailedMovieCell.movieReleased.text = movie.movieReleased;
    detailedMovieCell.movieRunTime.text = movie.movieRuntime;
    detailedMovieCell.movieRated.text = movie.movieRated;
    detailedMovieCell.movieRatingLabel.text = movie.movieRating;
    detailedMovieCell.movieRatingTomatoesLabel.text = movie.movieRatingTomatoes;
    detailedMovieCell.movieDirector.text = movie.movieDirector;
    detailedMovieCell.movieActors.text = movie.movieActors;
    detailedMovieCell.moviePlot.text = movie.moviePlot;

    // Tomato Image
    UIImage *tomatoImage;
    if ([movie.movieRatingTomatoesCertificate isEqualToString:@"certified"]) {
        tomatoImage = [UIImage imageNamed:@"certified_fresh.png"];
    } else if ([movie.movieRatingTomatoesCertificate isEqualToString:@"fresh"]) {
        tomatoImage = [UIImage imageNamed:@"tomato.png"];
    } else if ([movie.movieRatingTomatoesCertificate isEqualToString:@"rotten"]) {
        tomatoImage = [UIImage imageNamed:@"splat.png"];
    } else {
        tomatoImage = [UIImage imageNamed:@"gray_tomato"];
    }
    detailedMovieCell.movieRatingTomatoesCerticateImageView.image = tomatoImage;
    
    return detailedMovieCell;
}

#pragma mark Save Data
-(void)addToFavorites
{
    // save current movie object to NSUserDefaults, archive it - if doesn't already exist in favorites
    if (favoriteMovies.count > 0) {
        Movie *movie2 = favoriteMovies[favoriteMovies.count - 1]; // last index of array, is it same as current selection?
        if (![movie2.imdbID isEqualToString: movie.imdbID]) {
            [favoriteMovies addObject:movie];
            [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:favoriteMovies] forKey:@"favoriteMovies"];
        }
    } else {
        [favoriteMovies addObject:movie];
        [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:favoriteMovies] forKey:@"favoriteMovies"];
    }
    
    [defaults synchronize];
    
    NSLog(@"%ld", favoriteMovies.count);
    
    // TO DO: change heart color to red if exists in favorites
}

#pragma mark Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
