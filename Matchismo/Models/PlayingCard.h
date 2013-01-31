//
//  PlayingCard.h
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
