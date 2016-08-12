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
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = self.view.center;
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
    
    // Poster - use SDWebImage framework to download and load images asynchronously using provided URL's, set placeholder image
    NSURL *posterURL = [NSURL URLWithString:self.moviesList.posterImage];
    [searchMovieCell.movieImage sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"No_movie.png"]];
    
    // Title-Year
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

#pragma mark Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




//- (IBAction)save:(id)sender {
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    // Create a new managed object
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
//    [newDevice setValue:self.nameTextField.text forKey:@"name"];
//    [newDevice setValue:self.versionTextField.text forKey:@"version"];
//    [newDevice setValue:self.companyTextField.text forKey:@"company"];
//    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
