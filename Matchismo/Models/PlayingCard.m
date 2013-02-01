//
//  PlayingCard.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter AND getter

- (int)match:(NSArray *)otherCards
{
   int score = 0;
   if ([otherCards count] == 1) {
      // matching two cards
      PlayingCard *otherCard = [otherCards lastObject];
      if ([otherCard.suit isEqualToString:self.suit]) {
         score = 1;
      }
      else if (otherCard.rank == self.rank) {
         score = 4;
      }
   }
   else if ([otherCards count] == 2) {
      // matching three cards
      PlayingCard *secondCard = [otherCards objectAtIndex:0];
      PlayingCard *thirdCard = [otherCards objectAtIndex:1];
      // two ways of matching:
      //  either all three ranks are equal
      //  or all three suits are equal
      // exploiting the trasitivity of the equals relation here
      // ( if a=b and b=c then a=c, this all three are equal )
      if (([self.suit isEqualToString:secondCard.suit]) && ([secondCard.suit isEqualToString:thirdCard.suit])) {
         score = 6;
      }
      else if ((self.rank == secondCard.rank) && (secondCard.rank == thirdCard.rank)) {
         score = 15;
      }
   }
   return score;
}

- (NSString *)contents
{
   NSArray *rankStrings = [PlayingCard rankStrings];
   return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)validSuits
{
   return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
   if ([[PlayingCard validSuits] containsObject:suit]) {
      _suit = suit;
   }
}

- (NSString *)suit
{
   return _suit ? _suit : @"?";
}


- (void)setRank:(NSUInteger)rank
{
   if (rank <= [PlayingCard maxRank]) {
      _rank = rank;
   }
}


+ (NSArray *)rankStrings
{
   return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}


+ (NSUInteger)maxRank
{
   return [self rankStrings].count-1;
}
@end
