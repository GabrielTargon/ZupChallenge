//
//  DetailViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/13/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    UITextView *textView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Use placeholder image if no image available
    if ([self.movieSelected.posterImage isEqual:@"N/A"]) {
        [self setHeaderImage:[UIImage imageNamed:@"No_movie.png"]];
    } else {
        [self setHeaderImage:[UIImage imageWithData:[self.movieSelected valueForKey:@"posterImage"]]];
    }
    
    //Display information
    [self setTitleText:self.movieSelected.movieTitle];
    [self setSubtitleText:self.movieSelected.movieYear];
    [self setLabelBackgroundGradientColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
    
    //Navigation item - Delete
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                     target:self
                                     action:@selector(removeMovie)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIScrollView*)contentView{
    textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.scrollEnabled = NO;
    textView.editable = NO;
    [textView setBackgroundColor:[UIColor blackColor]];
    [textView setTextColor:[UIColor whiteColor]];
    [textView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
    textView.text = [NSString stringWithFormat:@"Runtime: %@\n\nRate: %@\n\nDirect by:\n%@ \n\nActors:\n%@ \n\nDescription:\n%@", self.movieSelected.movieRuntime, self.movieSelected.movieRating, self.movieSelected.movieDirector, self.movieSelected.movieActors, self.movieSelected.moviePlot];
    textView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 1000);
    
    return textView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeMovie {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
