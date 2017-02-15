//
//  MovieCollectionViewCell.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 2/10/17.
//  Copyright © 2017 gabrieltargon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@end
