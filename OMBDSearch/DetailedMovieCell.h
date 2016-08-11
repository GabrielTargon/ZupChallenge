//
//  DetailedMovieCell.h
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedMovieCell : UITableViewCell

@property (nonatomic) UIImageView *posterImageView;

@property (nonatomic) UILabel *movieTitleLabel;

@property (nonatomic) UILabel *movieRuntimeLabel;
@property (nonatomic) UILabel *movieRunTime;

@property (nonatomic) UILabel *movieRatingLabel;
@property (nonatomic) UIImageView *imdbLogoImageView;

@property (nonatomic) UILabel *movieRatingTomatoesLabel;
@property (nonatomic) UIImageView *movieRatingTomatoesCerticateImageView;

@property (nonatomic) UILabel *movieReleasedLabel;
@property (nonatomic) UILabel *movieReleased;

@property (nonatomic) UILabel *moviePlotLabel;
@property (nonatomic) UITextView *moviePlot;

@property (nonatomic) UILabel *movieDirectorLabel;
@property (nonatomic) UILabel *movieDirector;

@property (nonatomic) UILabel *movieActorsLabel;
@property (nonatomic) UITextView *movieActors;

@property (nonatomic) UILabel *movieRatedLabel;
@property (nonatomic) UILabel *movieRated;

@end
