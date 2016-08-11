//
//  SimplifiedMovieCell.m
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "SimplifiedMovieCell.h"

@implementation SimplifiedMovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // Poster
        self.posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 54, 80)];
        self.posterImageView.layer.masksToBounds = YES;
        self.posterImageView.layer.cornerRadius = 5;
        [self addSubview:self.posterImageView];
        
        // Title and Year
        self.movieTitleAndYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, SCREEN_WIDTH - 110, 45)];
        self.movieTitleAndYearLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.movieTitleAndYearLabel.numberOfLines = 0;
        self.movieTitleAndYearLabel.backgroundColor = [UIColor clearColor];
        self.movieTitleAndYearLabel.textColor = [UIColor whiteColor];
        [self.movieTitleAndYearLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        self.movieTitleAndYearLabel.userInteractionEnabled = NO;
        [self addSubview:self.movieTitleAndYearLabel];
        
        // IMDB
        self.imdbLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 25, 25)];
        self.imdbLogoImageView.image = [UIImage imageNamed:@"IMDbLogo.png"];
        self.imdbLogoImageView.layer.cornerRadius = 5;
        self.imdbLogoImageView.layer.masksToBounds = YES;
        [self addSubview:self.imdbLogoImageView];
        
        self.movieRatingLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 50, 30)];
        self.movieRatingLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.movieRatingLabel];
        
        // Rotten Tomatoes
        self.movieRatingTomatoesLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 60, 50, 30)];
        self.movieRatingTomatoesLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.movieRatingTomatoesLabel];
        
        self.movieRatingTomatoesCerticateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, 60, 25, 25)];
        [self addSubview:self.movieRatingTomatoesCerticateImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
