//
//  Movies+CoreDataProperties.h
//  OMBDSearch
//
//  Created by Gabriel Targon on 8/9/16.
//  Copyright © 2016 gabrieltargon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Movies.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movies (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *movieImage;
@property (nullable, nonatomic, retain) NSString *movieTitle;
@property (nullable, nonatomic, retain) NSString *movieYear;
@property (nullable, nonatomic, retain) NSString *movieRuntime;
@property (nullable, nonatomic, retain) NSString *movieRating;
@property (nullable, nonatomic, retain) NSString *movieDirector;
@property (nullable, nonatomic, retain) NSString *movieActors;
@property (nullable, nonatomic, retain) NSString *movieDescription;
@property (nullable, nonatomic, retain) NSString *omdbID;

@end

NS_ASSUME_NONNULL_END
