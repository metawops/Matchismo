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
@property (readwrite, strong, nonatomic) NSString *lastFlipResult;

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
   
   BOOL pertainLastResult = NO;
   
   if (card && !card.isUnplayable) {
      if (!card.isFaceUp) {
         for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
               int matchScore = [card match:@[otherCard]];
               if (matchScore) {
                  card.unplayable = YES;
                  otherCard.unplayable = YES;
                  self.score += matchScore * MATCH_BONUS;
                  self.lastFlipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                  pertainLastResult = YES;
               } else {
                  otherCard.faceUp = NO;
                  self.score -= MISMATCH_PENALTY;
                  self.lastFlipResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                  pertainLastResult = YES;
               }
               break;
            }
            self.lastFlipResult = nil;
         }
         self.score -= FLIP_COST;
         //         self.lastFlipResult = [NSString stringWithFormat:@"Flipping card face up costed %d points.", FLIP_COST];
         if (!pertainLastResult)
            self.lastFlipResult = [NSString stringWithFormat:@"Fliped up %@.", card.contents];
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
