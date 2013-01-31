//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
   self = [super init];
   
   if (self) {
      for (NSString *suit in [PlayingCard validSuits]) {
         for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            PlayingCard * card = [[PlayingCard alloc] init];
            card.rank = rank;
            card.suit = suit;
            [self addCard:card atTop:YES];
         }
      }
   }
   
   return self;
}

@end
