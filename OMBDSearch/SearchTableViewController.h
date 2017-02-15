//
//  SearchTableViewController.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/7/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;


@end
