//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 31.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score; // readwrite is the default but used here to make clear against the public API where this property is just readonly
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
   if (!_cards) _cards = [[NSMutableArray alloc] init];
   return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
   Card *card = [self cardAtIndex:index];
   
   if (card && !card.isUnplayable) {
      if (!card.isFaceUp) {
         for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
               int matchScore = [card match:@[otherCard]];
               if (matchScore) {
                  card.unplayable = YES;
                  otherCard.unplayable = YES;
                  self.score += matchScore * MATCH_BONUS;
               } else {
                  otherCard.faceUp = NO;
                  self.score -= MISMATCH_PENALTY;
               }
               break;
            }
         }
         self.score -= FLIP_COST;
      }
      card.faceUp = !card.isFaceUp;
   }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
   return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
   // rule: in your designated initializer, call the super class's designated initializer
   self = [super init];
   
   if (self) {
      for (int i = 0; i < count; i++) {
         Card *card = [deck drawRandomCard];
         if (card) {
            self.cards[i] = card;
         }
         else {
            self = nil;
            break;
         }
      }
   }
   
   return self;
}

@end
