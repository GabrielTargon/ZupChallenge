//
//  DetailViewController.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/13/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JPBFloatingTextViewController.h>
#import "Movies.h"

@interface DetailViewController : JPBFloatingTextViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) Movies *movieSelected;


@end
