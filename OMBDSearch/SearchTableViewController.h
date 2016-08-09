//
//  SearchTableViewController.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;


@end
