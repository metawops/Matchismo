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
      if (!card.isFaceUp) {    // eine verdeckte Karte wurde angetippt
         
         for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
               // we found another card that is faceup and still in the game

               int matchScore = [card match:@[otherCard]];
               if (matchScore) {
                  // there's some kind of match between these two cards
                  // no check for a possible matching 3rd card if we're in a 3-match-game
                  if (self.isThreeCardMatchMode) {
                     for (Card *thirdCard in self.cards) {
                        if (thirdCard.isFaceUp && !thirdCard.isUnplayable && !([otherCard.contents isEqualToString:thirdCard.contents])) {
                           // we have a candidate (faceup & still in the game & not == the 2nd card)
                           // now check the match score for all three cards
                           int matchThreeScore = [card match:@[otherCard, thirdCard]];
                           if (matchThreeScore) {
                              // yay! all three cards match (in rank or suit)
                              card.unplayable = YES;
                              otherCard.unplayable = YES;
                              thirdCard.unplayable = YES;
                              self.score += matchThreeScore * MATCH_BONUS;
                              self.lastFlipResult = [NSString stringWithFormat:@"Matched %@, %@ & %@ for %d points", card.contents, otherCard.contents, thirdCard.contents, matchThreeScore * MATCH_BONUS];
                              pertainLastResult = YES;
                           }
                           else {
                              // no three-card-match
                              otherCard.faceUp = NO;
                              thirdCard.faceUp = NO;
                              self.score -= MISMATCH_PENALTY;
                              self.lastFlipResult = [NSString stringWithFormat:@"%@, %@ & %@ don't match! %d point penalty!", card.contents, otherCard.contents, thirdCard.contents, MISMATCH_PENALTY];
                              pertainLastResult = YES;                              
                           }
                           break;
                        }
                     }
                  }
                  else {
                     // we are in a 2-match-game, the 2 cards matched
                     card.unplayable = YES;
                     otherCard.unplayable = YES;
                     self.score += matchScore * MATCH_BONUS;
                     self.lastFlipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                  }
                  pertainLastResult = YES;
               } else {
                  // otherCard.faceUp = NO;
                  for (Card *aCard in self.cards)
                     if (![aCard.contents isEqualToString:card.contents] && !aCard.isUnplayable)
                        aCard.faceUp = NO;
                  self.score -= MISMATCH_PENALTY;
                  self.lastFlipResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                  pertainLastResult = YES;
               }
               break;

            }
            self.lastFlipResult = nil;
         }
         self.score -= FLIP_COST;
         if (!pertainLastResult)
            self.lastFlipResult = [NSString stringWithFormat:@"Fliped up %@", card.contents];
      }
      // Falls eine umgedrehte ("FaceUp") Karte angetippt wurde,
      // wird sie einfach wieder umgedreht, so dass sie dann "FaceDown" ist.
      // Anderenfalls (es wurde eine "FaceDown" Karte angetippt und der
      // gesamte obige if-Block durchlaufen) wird sie hierdurch auch noch
      // auf "FaceUp" umgeswitcht.
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
      self.threeCardMatchMode = FALSE;
   }
   
   return self;
}

@end
