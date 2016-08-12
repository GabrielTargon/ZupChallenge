//
//  SearchTableViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import "SearchTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "Movie.h"
#import "IMDbModel.h"
#import "SearchTableViewCell.h"
#import "SearchDetailViewController.h"


@interface SearchTableViewController ()

@property (weak, nonatomic) Movie *moviesList;

@end

@implementation SearchTableViewController
{
    // Model
    IMDbModel *imdbModel;
    NSMutableArray *movies;
    
    // View
    UIBarButtonItem *favoriteButton;
    UIActivityIndicatorView *spinner;
    NSTimer *timer;
    
    // Controller
    SearchDetailViewController *movieDetailController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // IMDb API Model
    imdbModel = [[IMDbModel alloc] init];
    imdbModel.delegate = self;
    
    // Temporary Array for Search Results
    movies = [@[] mutableCopy];
    
    // Spinner
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // stop timer
    [timer invalidate];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (movies) {
        return movies.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *searchMovieCell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // Create new movie object, passing in movie info at index
    self.moviesList = movies[indexPath.row];
    
    // Use SDWebImage framework to download and load images
    NSURL *posterURL = [NSURL URLWithString:self.moviesList.posterImage];
    [searchMovieCell.movieImage sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"No_movie.png"]];
    searchMovieCell.movieImage.layer.cornerRadius = 5.0;
    searchMovieCell.movieImage.layer.masksToBounds = YES;
    // Get title and year
    searchMovieCell.movieTitle.text = [NSString stringWithFormat:@"%@ (%@)", self.moviesList.movieTitle, self.moviesList.movieYear];
    
    return searchMovieCell;
}

#pragma mark Table View Delegate Methods

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When cells are done loading...
    if (indexPath.row == ((NSIndexPath *)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        // Stop spinner
        [spinner stopAnimating];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        SearchDetailViewController *destination = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destination.movieSelected = [movies objectAtIndex:indexPath.row];
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
    [self.searchTableView reloadData];
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
        [self.searchTableView reloadData];
    }
}

#pragma mark IMDb Model Delegate Method

-(void)didGetMovies:(NSMutableArray *)moviesArray
{
    // Pass in moviesArray into temporary array to be used in current view
    movies = moviesArray;
}

#pragma mark Other methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
