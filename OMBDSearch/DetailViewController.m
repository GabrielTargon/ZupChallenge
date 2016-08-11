//
//  DetailViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import "DetailViewController.h"
#import "Movie.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
{
    NSData *posterData;
    NSMutableArray *favoriteMovies;
    NSUserDefaults * defaults;
    
    UIBarButtonItem *favoriteButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    // Unarchive movie data into object
//    favoriteMovies = [@[] mutableCopy];
    
    // Poster
    NSURL *posterURL = [NSURL URLWithString:self.movieSelected.posterImage];
    posterData = [[NSData alloc] initWithContentsOfURL:posterURL];
    
//    // Create new movie object, passing in movie info at index
//    Movies *moviesList = movies[indexPath.row];
//    
//    // Poster - use SDWebImage framework to download and load images asynchronously using provided URL's, set placeholder image
//    NSURL *posterURL = [NSURL URLWithString:moviesList.posterImage];
//    [searchMovieCell.movieImage sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"No_movie.png"]];
//    
//    // Title-Year
//    searchMovieCell.movieTitle.text = [NSString stringWithFormat:@"%@ (%@)", moviesList.movieTitle, moviesList.movieYear];
//    
    
    
    // Use placeholder image if no image available
    if ([self.movieSelected.posterImage isEqualToString:@"N/A"]) {
        self.movieImage.image = [UIImage imageNamed:@"No_movie.png"];
        self.movieImage.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
    } else {
        self.movieImage.image = [UIImage imageWithData:posterData];
    }
    
    //Information
    self.movieTitle.text = self.movieSelected.movieTitle;
    self.movieReleased.text = [NSString stringWithFormat:@"Released: %@", self.movieSelected.movieYear];
    self.movieRuntime.text = [NSString stringWithFormat:@"Runtime: %@", self.movieSelected.movieRuntime];
    self.movieRate.text = [NSString stringWithFormat:@"Rate: %@", self.movieSelected.movieRating];
    self.movieDirectors.text = self.movieSelected.movieDirector;
    self.movieActors.text = self.movieSelected.movieActors;
    self.movieDescription.text = self.movieSelected.moviePlot;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)saveMovie:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *movieSaved = [NSEntityDescription insertNewObjectForEntityForName:@"Movies" inManagedObjectContext:context];
//    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:_movieSelected];
    
    [movieSaved setValue:self.movieSelected.posterImage forKey:@"posterImage"];
    [movieSaved setValue:self.movieSelected.movieTitle forKey:@"movieTitle"];
    [movieSaved setValue:self.movieSelected.movieYear forKey:@"movieYear"];
    [movieSaved setValue:self.movieSelected.movieRuntime forKey:@"movieRuntime"];
    [movieSaved setValue:self.movieSelected.movieRating forKey:@"movieRating"];
    [movieSaved setValue:self.movieSelected.movieDirector forKey:@"movieDirector"];
    [movieSaved setValue:self.movieSelected.movieActors forKey:@"movieActors"];
    [movieSaved setValue:self.movieSelected.moviePlot forKey:@"moviePlot"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    else {
        NSLog(@"AEWWWWWW SUCESSO");
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
