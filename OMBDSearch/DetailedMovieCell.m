//
//  DetailedMovieCell.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "DetailedMovieCell.h"

@implementation DetailedMovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setUserInteractionEnabled:NO];
        
        self.textLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:0.067f green:0.235f blue:0.333f alpha:1.0f];
        
        // Dividers
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
        divider.backgroundColor = [UIColor grayColor];
        [self addSubview:divider];
        
        UIView *divider2 = [[UIView alloc] initWithFrame:CGRectMake(0, 272, SCREEN_WIDTH, 0.5)];
        divider2.backgroundColor = [UIColor grayColor];
        [self addSubview:divider2];
        
        // Poster
        self.posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 130, 197)];
        self.posterImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.posterImageView];
        
        // Title
        self.movieTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 55)];
        self.movieTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.movieTitleLabel.numberOfLines = 0;
        self.movieTitleLabel.backgroundColor = [UIColor clearColor];
        self.movieTitleLabel.textColor = [UIColor whiteColor];
        self.movieTitleLabel.userInteractionEnabled = NO;
        self.movieTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.movieTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
        [self addSubview:self.movieTitleLabel];
        
        // Released
        self.movieReleasedLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 90, 80, 25)];
        self.movieReleasedLabel.textColor = [UIColor whiteColor];
        [self.movieReleasedLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieReleasedLabel.text = @"Released:";
        [self addSubview:self.movieReleasedLabel];
        
        self.movieReleased = [[UILabel alloc] initWithFrame:CGRectMake(220, 90, 100, 25)];
        [self.movieRatedLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.movieReleased.textColor = [UIColor whiteColor];
        [self addSubview:self.movieReleased];
        
        // Runtime
        self.movieRuntimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 120, 80, 25)];
        [self.movieRuntimeLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieRuntimeLabel.textColor = [UIColor whiteColor];
        self.movieRuntimeLabel.text = @"Runtime:";
        [self addSubview:self.movieRuntimeLabel];
        
        self.movieRunTime = [[UILabel alloc] initWithFrame:CGRectMake(215, 120, 100, 25)];
        [self.movieRatedLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.movieRunTime.textColor = [UIColor whiteColor];
        [self addSubview:self.movieRunTime];
        
        // Rated
        self.movieRatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 80, 25)];
        [self.movieRatedLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieRatedLabel.textColor = [UIColor whiteColor];
        self.movieRatedLabel.text = @"Rated:";
        [self addSubview:self.movieRatedLabel];
        
        self.movieRated = [[UILabel alloc] initWithFrame:CGRectMake(195, 150, 100, 25)];
        [self.movieRatedLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.movieRated.textColor = [UIColor whiteColor];
        [self addSubview:self.movieRated];
        
        // IMDB
        self.imdbLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 200, 40, 40)];
        self.imdbLogoImageView.image = [UIImage imageNamed:@"IMDbLogo.png"];
        self.imdbLogoImageView.layer.masksToBounds = YES;
        self.imdbLogoImageView.layer.cornerRadius = 5;
        [self addSubview:self.imdbLogoImageView];
        
        self.movieRatingLabel = [[UILabel alloc] initWithFrame:CGRectMake(185, 200, 40, 40)];
        self.movieRatingLabel.textColor = [UIColor whiteColor];
        [self.movieRatingLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22]];
        [self addSubview:self.movieRatingLabel];
        
        // Rotten Tomatoes
        self.movieRatingTomatoesCerticateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 200, 40, 40)];
        [self addSubview:self.movieRatingTomatoesCerticateImageView];
        
        self.movieRatingTomatoesLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 200, 40, 40)];
        self.movieRatingTomatoesLabel.textColor = [UIColor whiteColor];
        [self.movieRatingTomatoesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22]];
        [self addSubview:self.movieRatingTomatoesLabel];
        
        // Director
        self.movieDirectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 100, 25)];
        self.movieDirectorLabel.textColor = [UIColor whiteColor];
        [self.movieDirectorLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieDirectorLabel.text = @"Directed by:";
        [self addSubview:self.movieDirectorLabel];
        
        self.movieDirector = [[UILabel alloc] initWithFrame:CGRectMake(25, 330, SCREEN_WIDTH - 45, 25)];
        [self.movieDirector setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.movieDirector.textColor = [UIColor whiteColor];
        [self addSubview:self.movieDirector];
        
        // Cast
        self.movieActorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, 100, 25)];
        self.movieActorsLabel.textColor = [UIColor whiteColor];
        [self.movieActorsLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieActorsLabel.text = @"Actors:";
        [self addSubview:self.movieActorsLabel];
        
        self.movieActors = [[UITextView alloc] initWithFrame:CGRectMake(25, 390, SCREEN_WIDTH - 45, 75)];
        self.movieActors.textColor = [UIColor whiteColor];
        self.movieActors.backgroundColor = [UIColor clearColor];
        [self.movieActors setFont:[UIFont fontWithName:@"Arial" size:16]];
        [self addSubview:self.movieActors];

        // Plot
        self.moviePlotLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 455, 100, 25)];
        self.moviePlotLabel.textColor = [UIColor whiteColor];
        [self.moviePlotLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.moviePlotLabel.text = @"Plot:";
        [self addSubview:self.moviePlotLabel];
        
        self.moviePlot = [[UITextView alloc] initWithFrame:CGRectMake(25, 480, SCREEN_WIDTH - 45, 1000)];
        self.moviePlot.textColor = [UIColor whiteColor];
        self.moviePlot.backgroundColor = [UIColor clearColor];
        [self.moviePlot setFont:[UIFont fontWithName:@"Arial" size:16]];
        [self addSubview:self.moviePlot];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
