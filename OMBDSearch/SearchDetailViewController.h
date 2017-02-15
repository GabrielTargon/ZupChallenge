//
//  SearchDetailViewController.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/7/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movies.h"

@interface SearchDetailViewController : UIViewController

@property (weak, nonatomic) Movies *movieSelected;

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieReleased;
@property (weak, nonatomic) IBOutlet UILabel *movieRuntime;
@property (weak, nonatomic) IBOutlet UILabel *movieRate;
@property (weak, nonatomic) IBOutlet UILabel *movieDirectors;
@property (weak, nonatomic) IBOutlet UILabel *movieActors;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;

- (IBAction)saveMovie:(id)sender;

@end
