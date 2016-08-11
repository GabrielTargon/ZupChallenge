//
//  MovieSearchVC.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/19/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import "IMDbModel.h"
#import "Movie.h"

#import "SimplifiedMovieCell.h"

#import "MovieSearchVC.h"
#import "MovieDetailsTVC.h"
#import "MovieFavoritesTVC.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MovieSearchVC () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, IMDbModelDelegate>

@end

@implementation MovieSearchVC
{
    // Model
    IMDbModel *imdbModel;
    NSMutableArray *movies;
    NSUserDefaults *defaults;
    
    // View
    UIBarButtonItem *favoriteButton;
    UIActivityIndicatorView *spinner;
    NSTimer *timer;
    
    // Controller
    MovieDetailsTVC *movieDetailsTVC;
    MovieFavoritesTVC *movieFavoritesTVC;
}

- (void)awakeFromNib
{
    self.title = @"IMDb Search";
    self.view.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    
    // Replace back button text with empty string
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // IMDb API Model
    imdbModel = [[IMDbModel alloc] init];
    imdbModel.delegate = self;
    
    // Temporary Array for Search Results
    movies = [@[] mutableCopy];
    
    // Persistent Storage
    defaults = [NSUserDefaults standardUserDefaults];
    
    // Search bar
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal; // removes border
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search movies";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}]; // text color
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor:[UIColor whiteColor]]; // background color
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor lightGrayColor]]; // cursor color
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    
    // Table view
    self.movieTableView.delegate = self;
    self.movieTableView.dataSource = self;
    self.movieTableView.tableFooterView = [[UIView alloc] init]; // hide empty cells
    self.movieTableView.backgroundColor = [UIColor clearColor];
    
    // Favorite Button
    favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"heart.png"]
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(goToFavorites)];
    self.navigationItem.rightBarButtonItem = favoriteButton;
    
    // Spinner
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = self.view.center;
    [self.view addSubview:spinner];
    
    // Controllers
    movieFavoritesTVC = [[MovieFavoritesTVC alloc] init];
    movieDetailsTVC = [[MovieDetailsTVC alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    // To do: passing in fake data to prevent crash. needs to be fixed later.
    
    // if favorites array doesn't exist in NSUserDefaults, create empty array and save to NSUserDefaults
    // To do: pass in random object as placeholder - must be fixed later
    if ([defaults objectForKey:@"favoriteMovies"] == nil) {
        
        Movie *fakeMovie = [[Movie alloc] init];
        fakeMovie.posterImage = @"Poster";
        fakeMovie.movieTitle = @"Title";
        fakeMovie.movieYear = @"Year";
        fakeMovie.movieRating = @"imdbRating";
        fakeMovie.movieRatingTomatoes = @"tomatoMeter";
        fakeMovie.movieRatingTomatoesCertificate = @"tomatoImage";
        
        NSMutableArray *favoriteMovies = [@[fakeMovie] mutableCopy];
        
        [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:favoriteMovies] forKey:@"favoriteMovies"];
        [defaults synchronize];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    // stop timer
    [timer invalidate];
}

#pragma mark Navigation

- (void)goToFavorites
{
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:movieFavoritesTVC];
    [self.navigationController presentViewController:navC animated:YES completion:nil];
}

#pragma mark Table View Data Source Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (movies) {
        return movies.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimplifiedMovieCell *simplifiedMovieCell = (SimplifiedMovieCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (simplifiedMovieCell == nil) {
        simplifiedMovieCell = [[SimplifiedMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // Create new movie object, passing in movie info at index
    Movie *movie = movies[indexPath.row];
    
    // Poster - use SDWebImage framework to download and load images asynchronously using provided URL's, set placeholder image
    NSURL *posterURL = [NSURL URLWithString:movie.posterImage];
    [simplifiedMovieCell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"no_movie.png"]];
    
    // Title-Year, IMDb Rating, Rotten Tomatoes Rating
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
        tomatoImage = [UIImage imageNamed:@"gray_tomato"]; // N/A
    }
    simplifiedMovieCell.movieRatingTomatoesCerticateImageView.image = tomatoImage;
    
    return simplifiedMovieCell;
}

#pragma mark Table View Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove table cell highlight
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Save selected movie object to NSUserDefaults, archive it
    Movie *movie = movies[indexPath.row];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:movie] forKey:@"movieObject"];
    [defaults synchronize];
    
    // Navigate to Movie Info page
    [self.navigationController pushViewController:movieDetailsTVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When cells are done loading...
    if (indexPath.row == ((NSIndexPath *)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        
        // Stop timer
//        [timer invalidate];
        
        // Stop spinner
        [spinner stopAnimating];
    }
}

#pragma mark UISearchBar Delegate Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // Search database
    [imdbModel searchIMDb:searchBar.text];
    
    // Remove keyboard
    [searchBar resignFirstResponder];
    
    // Animate Spinner
    [spinner startAnimating];
    
    // Empty out movies array
    [movies removeAllObjects];
    
    // Remove any preexisting timers - set timer to refresh page every 0.1 second
    // To do: not a good method, must fix later
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)reloadTableView
{
    [self.movieTableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // When textfield is empty or 'x' is tapped
    if ([searchText isEqualToString:@""]) {
        
        // Stop timer
        [timer invalidate];
        
        // Stop spinner
        [spinner stopAnimating];
        
        // Empty out movies array
        [movies removeAllObjects];
        
        // Refresh page
        [self.movieTableView reloadData];
    }
}

#pragma mark IMDb Model Delegate Method

-(void)didGetMovies:(NSMutableArray *)moviesArray
{
    // Pass in moviesArray into temporary array to be used in current view
    movies = moviesArray;
}

#pragma mark Other

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // White status bar
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
