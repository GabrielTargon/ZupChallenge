//
//  SearchDetailViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "Movie.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController
{
    NSData *posterData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    // Poster
    NSURL *posterURL = [NSURL URLWithString:self.movieSelected.posterImage];
    posterData = [[NSData alloc] initWithContentsOfURL:posterURL];
    
    // Use placeholder image if no image available
    if ([self.movieSelected.posterImage isEqual:@"N/A"]) {
        self.movieImage.image = [UIImage imageNamed:@"No_movie.png"];
        self.movieImage.backgroundColor = [UIColor whiteColor];
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

#pragma mark Core Data methods

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
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Movies" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    BOOL unique = YES;
    NSError  *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    //Check if item already exist on database
    if(items.count > 0){
        for(Movies *thisMovie in items){
            if([self.movieSelected.movieTitle isEqualToString: thisMovie.movieTitle]){
                unique = NO;
            }
        }
    }
    
    if(unique) {
        NSManagedObject *movieSaved = [NSEntityDescription insertNewObjectForEntityForName:@"Movies" inManagedObjectContext:context];
        //Save image
        NSData *dataImage = UIImagePNGRepresentation(self.movieImage.image);
        [movieSaved setValue:dataImage forKey:@"posterImage"];
        //Save info
        [movieSaved setValue:self.movieSelected.movieTitle forKey:@"movieTitle"];
        [movieSaved setValue:self.movieSelected.movieYear forKey:@"movieYear"];
        [movieSaved setValue:self.movieSelected.movieRuntime forKey:@"movieRuntime"];
        [movieSaved setValue:self.movieSelected.movieRating forKey:@"movieRating"];
        [movieSaved setValue:self.movieSelected.movieDirector forKey:@"movieDirector"];
        [movieSaved setValue:self.movieSelected.movieActors forKey:@"movieActors"];
        [movieSaved setValue:self.movieSelected.moviePlot forKey:@"moviePlot"];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            return;
        }
    }else {
        [self alertAlreadySaved];
    }
}

#pragma mark Other methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertAlreadySaved {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Already saved"
                                 message:@"This movie is on your favorite movie list"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
