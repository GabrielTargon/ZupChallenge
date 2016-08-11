//
//  MovieSearchVC.h
//  OMDb Search
//
//  Created by Joseph Lau on 3/19/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchVC : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@end
