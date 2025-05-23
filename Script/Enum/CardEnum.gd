extends Node

class_name card_enum

enum FLOPPY_DISK_ENUM {
	Attack, 
	Skill, 
	Power, 
	Innate,
	Debilitate
}

enum BATTERY_ENUM {
	Empty, 
	Low, 
	Medium, 
	Full, 
	OverchargeLow, 
	OverchargeMed, 
	OverchargeFull
}

enum CARD_STATE_ENUM {
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawnCardToHand,
	ReorganizeHand
}
