//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Stefan Wolfrum on 27.01.13.
//  Copyright (c) 2013 Stefan Wolfrum. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) NSInteger numberOfFlips;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberOfFlips;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayModeControl;
@end


@implementation CardGameViewController

- (CardMatchingGame *)game
{
   if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[[PlayingCardDeck alloc] init]];
   return _game;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
   _cardButtons = cardButtons;
   [self updateUI];
}

- (void)updateUI
{
   for (UIButton *cardButton in self.cardButtons) {
      Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
      [cardButton setTitle:card.contents forState:UIControlStateSelected];
      [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
      cardButton.selected = card.isFaceUp;
      cardButton.enabled = !card.isUnplayable;
      cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
   }
   self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.game.score];
   self.statusLabel.text = self.game.lastFlipResult;
}

- (void)setNumberOfFlips:(NSInteger)numberOfFlips
{
   _numberOfFlips = numberOfFlips;
   self.labelNumberOfFlips.text = [NSString stringWithFormat:@"Flips: %d", self.numberOfFlips];
}


- (IBAction)flipIt:(UIButton *)sender
{
   // if a new game just started (score==0) disable the 2-match/3-match switch
   if (self.numberOfFlips == 0)
      self.gamePlayModeControl.enabled = FALSE;
   
   [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
   self.numberOfFlips++;
   [self updateUI];
}


- (IBAction)newGame:(UIButton *)sender
{
   [self setGame:[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                   usingDeck:[[PlayingCardDeck alloc] init]]];
   self.numberOfFlips = 0;
   self.gamePlayModeControl.enabled = YES;
   [self updateUI];
}


- (IBAction)matchModeTapped:(UISegmentedControl *)sender
{
   [self.game setThreeCardMatchMode:[sender selectedSegmentIndex]==0 ? NO : YES];
}
@end
