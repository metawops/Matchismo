//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Stefan Wolfrum on 31.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer (ie, the one that must be called)
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, strong, nonatomic) NSString *lastFlipResult;


@end
