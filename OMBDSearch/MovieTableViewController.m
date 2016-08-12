//
//  MovieTableViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDetailViewController.h"

@interface MovieTableViewController ()

@property (strong, nonatomic) NSMutableArray *moviesArray;

@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moviesArray = [@[] mutableCopy];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the movies from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Movies"];
    self.moviesArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.moviesArray) {
        return self.moviesArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *movieCell = (MovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSManagedObject *movie = [self.moviesArray objectAtIndex:indexPath.row];
    
    //Set image
    if (![movie valueForKey:@"posterImage"]) {
        [movieCell.movieImage setImage: [UIImage imageNamed:@"No_movie.png"]];
        movieCell.movieImage.backgroundColor = [UIColor whiteColor];
    } else {
        [movieCell.movieImage setImage:[UIImage imageWithData:[movie valueForKey:@"posterImage"]]];
    }
    //Set title
    [movieCell.movieTitle setText:[NSString stringWithFormat:@"%@ (%@)", [movie valueForKey:@"movieTitle"], [movie valueForKey:@"movieYear"]]];
    
    return movieCell;
}

#pragma mark Other methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailTwo"]) {
        MovieDetailViewController *destination = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destination.movieSelected = [self.moviesArray objectAtIndex:indexPath.row];
    }
}

@end
