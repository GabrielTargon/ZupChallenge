//
//  DetailViewController.m
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/13/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import "DetailViewController.h"
#import "MovieDescriptionTableViewCell.m"

@interface DetailViewController () {
}

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavbarButtons];
    
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
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupNavbarButtons
{
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonBack.frame = CGRectMake(10, 10, 22, 22);
    [buttonBack setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
}

- (IBAction)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (UIScrollView*)contentView{
//    textMovieRuntime = [[UITextView alloc] initWithFrame:CGRectZero];
//    textMovieRuntime.scrollEnabled = NO;
//    textMovieRuntime.editable = NO;
//    textMovieRuntime.text = self.movieSelected.movieRuntime;
//    textMovieRuntime.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    
    
//    textMoviePlot = [[UITextView alloc] initWithFrame:CGRectZero];
//    textMoviePlot.scrollEnabled = NO;
//    textMoviePlot.editable = NO;
//    textMoviePlot.text = self.movieSelected.moviePlot;
//    textMoviePlot.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 600);
    
//    return _tableViewMovie;
    
    //    self.movieRuntime.text = [NSString stringWithFormat:@"Runtime: %@", self.movieSelected.movieRuntime];
    //    self.movieRate.text = [NSString stringWithFormat:@"Rate: %@", self.movieSelected.movieRating];
    //    self.movieDirectors.text = self.movieSelected.movieDirector;
    //    self.movieActors.text = self.movieSelected.movieActors;
    //    self.movieDescription.text = self.movieSelected.moviePlot;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDescriptionTableViewCell *detailMovieCell = (MovieDescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellDetail"];
    detailMovieCell.labelMovieRuntime.text = self.movieSelected.movieRuntime;
    
    return detailMovieCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
