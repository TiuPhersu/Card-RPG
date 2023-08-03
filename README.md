#Companion Card Battler RPG Design Document

## High Concept
A hardcore single player RPG using a deck of cards with inctricately designed levels in a 2.5D perspective using a controller/keyboard to control the character and select cards, mouse implementation will be secondary however will rethink about the option when usings cards. Combat will be a card based battler where you draw cards from a deck into your hand and you will have a limited amount of energy to use those cards and hands will be discarded after committing your action. When your turn starts then you can play cards into a pool and those cards will be played in the order you have put them, the damage plus block you use will be calculated for the player. The enemy will also show their intent and the player can act upon what actions the opponent will do. Once you put cards into a pool you cannot undo your actions however there is a limited UNDO you can do which will restart the turn. A companion/pet card based battler where you the character will also join in the combat and is built around 3 companion/pet to be used during combat, however only one will be used, but they can be switched mid combat. The deck is built around you the character and your companion/pet each unit will have a set of cards and when you add a companion/pet to your party then their cards are added to the deck to be used in combat. There is a recruitment involved when expanding your team/deck and is a very involved process of doing puzzles, secrets, and/or quests to recruit the companion/pet, there will be only one of those unit to be recruited and can no longer be recruited again. There will be permadeath as a core part of the game after a companion/pet is defeated then you can no longer use the unit and will be lost for the entire game session (add option to turn off for more casual play). The player is the only exception to permadeath when they are knocked out the battle still goes on however the player will suffer a penalty as an example they can no longer fight so cards associated with the player will be removed and energy to use for cards will be reduced. Units can "evolve" which is a term used to power up particular cards in certain ways and can "metaphorphosize" which is to change to a stronger and powered up form. There is also a card called innate card, these cards are associated with the player and units they are drawn at the beginning of combat, they are conditionally strong.

## Gameplay
### MOVEMENT
The player can move in a 3d dimension and can jump in the overworld.

### CARD BATTLER
#### DECK
- The player character will start with 10 card set.
- The pet/companion will have a 5 card set.

#### ENERGY
- The player starts with 5 energy.
- The pet/companion increases the energy count by 1.

#### HAND
- Draw 7 cards.
- Max hand size of 20.

#### ACTION
- Player will place cards in the pool.
- The card will be played in sequential order to when they are played.
- Commit to the actions and will execute the cards in the order that is in the pool.
- COOL FIGHT ANIMATION when committing the action

#### DISCARD
- When cards are used they are sent to the discard pile
- When the deck is emptied then the discard pile will be shuffled back into the deck

#### CARDS
##### ATTACK
- Cards that does damage

##### SKILL
- Cards that has special effects (generally buff or debuff)

##### DEFENSE
- Cards that increases block to lower or even negate damage

##### INNATE
- Special cards that is tied to the unit
- They are not in the deck
- Special condtions tied to the unit must be met to obtain the card
- Player character innate card is PROTECT, there is no condition and will be added to the hand every turn. The effect is that the player will take all damage their pet/companion will take

#### HEALTH
- Player and pet/companion will have their own  seperate health pool
- Pet/companion will permanently die when they lose all their health
- Player will not die however will be knocked out which will give a demerit of removing the players cards, lower the energy count, and lower the card draw

## SOUND
Use FMOD for dynamic music implementation, when on the card selection phase the music will be lofi thinking music then when commiting an action the music will change to a more exhilarating music.

## Reference Material
- https://www.youtube.com/watch?v=WrMORzl3g1U&t=114s&ab_channel=Chris%27Tutorials
- https://www.youtube.com/watch?v=NZ7EP1Kt_sI&ab_channel=GamedevAki
- https://www.youtube.com/watch?v=S60pMTsePqI&ab_channel=Bramwell
