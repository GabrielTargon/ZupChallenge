//
//  MovieFavoritesTVC.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/26/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "MovieFavoritesTVC.h"
#import "SimplifiedMovieCell.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieFavoritesTVC ()

@end

@implementation MovieFavoritesTVC
{
    NSMutableArray *favoriteMovies;
    NSData *posterData;
    NSUserDefaults *defaults;
    
    UIBarButtonItem *exitButton;
    UILabel *noFavoritesLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Persistent Storage
    defaults = [NSUserDefaults standardUserDefaults];
    
    // Title
    self.title = @"Favorites";
    
    // Exit Button
    exitButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"]
                                    landscapeImagePhone:nil
                                                  style:UIBarButtonItemStylePlain
                                                 target:self
                                                 action:@selector(exitButtonPressed)];
    self.navigationItem.rightBarButtonItem = exitButton;
    
    // No Favorites
    noFavoritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 50, 100, 30)];
    noFavoritesLabel.text = @"No Favorites";
    noFavoritesLabel.textColor = [UIColor grayColor];
    [noFavoritesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
}

-(void)viewWillAppear:(BOOL)animated
{
    // Unarchive favoriteMovies into temporary array if exists
    if ([defaults objectForKey:@"favoriteMovies"] != nil) {
        NSData *data2 = [defaults objectForKey:@"favoriteMovies"];
        if ([NSKeyedUnarchiver unarchiveObjectWithData:data2]) {
            favoriteMovies = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
        }
    }
    NSLog(@"Fav count - %ld", (unsigned long)favoriteMovies.count);
    
    // Navigation items color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Hide empty cells
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // Set TableView background color
    self.tableView.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
    
    // Add No Favorites Label if empty
    if (favoriteMovies.count < 1) {
        [self.view addSubview:noFavoritesLabel];
    }
    
    // Refresh data
    [self.tableView reloadData];
}

#pragma mark Table View Datasource Method

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (favoriteMovies.count) {
        return favoriteMovies.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimplifiedMovieCell *simplifiedMovieCell = (SimplifiedMovieCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (simplifiedMovieCell == nil) {
        simplifiedMovieCell = [[SimplifiedMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Movie *movie = favoriteMovies[indexPath.row];
    
    // Poster
    NSURL *posterURL = [NSURL URLWithString:movie.posterImage];
    [simplifiedMovieCell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"no_movie.png"]];
    
    simplifiedMovieCell.movieTitleAndYearLabel.text = [NSString stringWithFormat:@"%@ (%@)", movie.movieTitle, movie.movieYear];
    simplifiedMovieCell.movieRatingLabel.text = [NSString stringWithFormat: @"%@", movie.movieRating];
    simplifiedMovieCell.movieRatingTomatoesLabel.text = movie.movieRatingTomatoes;
    
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
    simplifiedMovieCell.movieRatingTomatoesCerticateImageView.image = tomatoImage;
    
    return simplifiedMovieCell;
}

#pragma TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // To do: go to Movie Info page
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // To do: delete cell
}

#pragma mark Navigation Method

-(void)exitButtonPressed
{
    // Exit view
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
