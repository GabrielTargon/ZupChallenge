//
//  MovieCollectionViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/6/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "MovieCollectionViewCell.h"
#import "DetailViewController.h"

@interface MovieCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *moviesArray;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"CellCollection";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moviesArray = [@[] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Fetch the movies from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Movies"];
    self.moviesArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (self.moviesArray) {
        return self.moviesArray.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCollectionViewCell *movieCell = (MovieCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSManagedObject *movie = [self.moviesArray objectAtIndex:indexPath.row];
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //Set imagerr
    if (![movie valueForKey:@"posterImage"]) {
        [movieCell.movieImage setImage: [UIImage imageNamed:@"No_movie.png"]];
        movieCell.movieImage.backgroundColor = [UIColor whiteColor];
    } else {
        [movieCell.movieImage setImage:[UIImage imageWithData:[movie valueForKey:@"posterImage"]]];
    }
//    movieCell.movieImage.layer.cornerRadius = 5.0;
    movieCell.movieImage.layer.masksToBounds = YES;
    //Set title
    [movieCell.movieTitle setText:[NSString stringWithFormat:@"%@ (%@)", [movie valueForKey:@"movieTitle"], [movie valueForKey:@"movieYear"]]];
    
    return movieCell;
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell
//    
//    return cell;
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
        DetailViewController *destination = [segue destinationViewController];
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        destination.movieSelected = [self.moviesArray objectAtIndex:indexPath.row];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
