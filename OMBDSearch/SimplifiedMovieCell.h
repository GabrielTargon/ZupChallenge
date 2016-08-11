//
//  SimplifiedMovieCell.h
//  OMDb Search
//
//  Created by Joseph Lau on 3/24/15.
//  Copyright (c) 2015 Joseph Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimplifiedMovieCell : UITableViewCell

@property (nonatomic) UIImageView *posterImageView;

@property (nonatomic) UILabel *movieTitleAndYearLabel;

@property (nonatomic) UILabel *movieRatingLabel;

@property (nonatomic) UIImageView *imdbLogoImageView;

@property (nonatomic) UILabel *movieRatingTomatoesLabel;

@property (nonatomic) UIImageView *movieRatingTomatoesCerticateImageView;

@end
