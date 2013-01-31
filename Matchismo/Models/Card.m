//
//  Card.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "Card.h"

@interface Card()

@end


@implementation Card

@synthesize contents = _contents;
@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

- (int)match:(NSArray *)otherCards
{
   int score = 0;
   
   for (Card *card in otherCards) {
      if([card.contents isEqualToString:self.contents]) {
         score = 1;
      }
   }
   return score;
}


@end
