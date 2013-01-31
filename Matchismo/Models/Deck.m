//
//  Deck.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

@synthesize cards = _cards;

- (NSMutableArray *)cards
{
   if (!_cards) _cards = [[NSMutableArray alloc] init];
   return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
   if (atTop) {
      [self.cards insertObject:card atIndex:0];
   } else {
      [self.cards addObject:card];
   }
}


- (Card *)drawRandomCard
{
   Card *randomCard = nil;
   
   unsigned index = arc4random() % self.cards.count;
   randomCard = self.cards[index];
   [self.cards removeObjectAtIndex:index];
   
   return randomCard;
}



@end
