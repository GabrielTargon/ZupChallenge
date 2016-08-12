//
//  MovieDetailViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/12/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Use placeholder image if no image available
    if ([self.movieSelected.posterImage isEqual:@"N/A"]) {
        self.movieImage.image = [UIImage imageNamed:@"No_movie.png"];
        self.movieImage.backgroundColor = [UIColor whiteColor];
    } else {
        [self.movieImage setImage:[UIImage imageWithData:[self.movieSelected valueForKey:@"posterImage"]]];
    }
    //Display information
    self.movieTitle.text = self.movieSelected.movieTitle;
    self.movieReleased.text = [NSString stringWithFormat:@"Released: %@", self.movieSelected.movieYear];
    self.movieRuntime.text = [NSString stringWithFormat:@"Runtime: %@", self.movieSelected.movieRuntime];
    self.movieRate.text = [NSString stringWithFormat:@"Rate: %@", self.movieSelected.movieRating];
    self.movieDirectors.text = self.movieSelected.movieDirector;
    self.movieActors.text = self.movieSelected.movieActors;
    self.movieDescription.text = self.movieSelected.moviePlot;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeMovie:(id)sender {
    //Delete movie from core data
    NSManagedObject *aManagedObject = self.movieSelected;
    NSManagedObjectContext *context = [aManagedObject managedObjectContext];
    [context deleteObject:aManagedObject];
    NSError *error;
    [self.navigationController popToRootViewControllerAnimated:YES];
    if (![context save:&error]) {
        NSLog(@"Couldn't delete");
    }
}


@end
