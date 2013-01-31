//
//  Card.h
//  Matchismo
//
//  Created by Stefan Wolfrum on 28.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
