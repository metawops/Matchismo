//
//  Deck.h
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
