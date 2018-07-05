#define ACTION_NONE	0
#define ACTION_ITEM1	1
#define ACTION_ITEM2	2
#define ACTION_ITEM3	3
#define ACTION_TIME	4


#define DIALOG_LIZ_WILL		0
#define DIALOG_PETE		1
#define DIALOG_KENJESU		2
#define DIALOG_MATHEMAGICIAN	3
#define DIALOG_DARTH_TATER	4

#define DIALOG_OSCAR		5
#define DIALOG_NICOLE		6
#define DIALOG_CINDY		7
#define DIALOG_ELAINE		8
#define DIALOG_CAFETERIA_LADY	9

#define DIALOG_METRO_WORKER	10
#define DIALOG_TINY_CAPABARA	11
#define DIALOG_GIANT_GUINEA_PIG	12
#define DIALOG_LARGE_BIRD	13

#define DIALOG_MERMAID		14

#define DIALOG_CMW		15
#define DIALOG_MALL		16
#define DIALOG_MINIGOLF		17

#define DIALOG_SCARYNUN		18
#define DIALOG_GUS		19
#define DIALOG_RAISTLIN		20
#define DIALOG_FORD		21

#define DIALOG_CAPTAIN_STEVE	22
#define DIALOG_BRIGHID		23
#define DIALOG_RACHAEL		24
#define DIALOG_MREE		25

#define DIALOG_NIRE		26
#define DIALOG_AGENT_S		27
#define DIALOG_AGENT_G		28
#define DIALOG_AGENT_AP		29
#define DIALOG_FRAU		30

struct dialog_words {
	char *words;
	int next;
	int action;
	int item;
};

struct dialog_type {
	int count;
	struct dialog_words statement[5];
};

struct dialog_type dialog[100]={

	// Talbot Hall
	[DIALOG_LIZ_WILL] = {
		.statement[0].words="Let\'s discuss cool things in the lounge.",
		.statement[0].next=0,
		.statement[1].words="YES!",
		.statement[1].next=0,
		.statement[2].words="Sorry, need to do engineering homework.",
		.statement[2].next=0,
		/* FOUR HOURS PASS */
		.statement[2].action=ACTION_TIME,
	},
	[DIALOG_PETE] = {
		.statement[0].words="Your journey takes you toward Bel Air.",
		.statement[0].next=1,
		.statement[1].words="PLOT!",
		.statement[1].next=1,
	},
	[DIALOG_KENJESU] = {
		.statement[0].words="Have you found your lost guinea pig?",
		.statement[0].next=0,
	},
	[DIALOG_MATHEMAGICIAN] = {
		.statement[0].words="Have you tried finding the eigenvalues?",
		.statement[0].next=0,
	},
	[DIALOG_DARTH_TATER] = {
		.statement[0].words="In Talbot 0101B",
		.statement[0].next=1,
		.statement[1].words="There lived a big giant bee",
		.statement[1].next=2,
		.statement[2].action=ACTION_ITEM2,
		.statement[2].item=ITEM_5K_RESISTOR,
	},
	// Dining Hall
	[DIALOG_OSCAR]= {
		.statement[0].words="Beware the killer crabs",
		.statement[0].next=1,
		.statement[1].words="They want to meet you",
		.statement[1].next=2,
		.statement[2].words="They want to eat you",
		.statement[2].next=0,
	},
	[DIALOG_NICOLE]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_CINDY]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_ELAINE]= {
		.statement[0].words="Remember Ohm\'s Law",
		.statement[0].next=0,
		.statement[1].words="Twinkle Twinkle Little Star",
		.statement[1].next=0,
		.statement[2].words="V is equal to IR",
		.statement[2].next=0,
	},
	[DIALOG_CAFETERIA_LADY]= {
		.statement[0].words="Happpy Birthday!",
		.statement[0].next=2,
		.statement[1].words="Have a cupcake",
		.statement[1].next=0,
	},
	// Metro Station
	[DIALOG_METRO_WORKER]= {
		.statement[0].words="Would you like to buy at SmartPass?",
		.statement[0].next=1,
		.statement[1].words="Sorry, all trains cancelled.  SmartTrip.",
		.statement[0].next=0,
	},
	[DIALOG_TINY_CAPABARA]= {
		.statement[0].words="GRONK",
		.statement[0].next=0,
	},
	[DIALOG_GIANT_GUINEA_PIG]= {
		.statement[0].words="SQUEAK?",
		.statement[0].next=0,
//		-> YES
//		-> NO
	},
	[DIALOG_LARGE_BIRD]= {
		.statement[0].words="WARK?",
		.statement[0].next=0,
//		-> YES
//		-> NO
	},
	// FOUNTAIN
	[DIALOG_MERMAID]= {
		.statement[0].words="Did ye put bubbles in yon fountain?",
		.statement[0].next=0,
		// restore heatlh?
	},
	// BEL AIR
	[DIALOG_CMW]= {
		.statement[0].words="No admittance without black trenchcoat",
		.statement[0].next=0,
	},
	[DIALOG_MALL]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_MINIGOLF]= {
		.statement[0].words="Closed for the season",
		.statement[0].next=0,
	},
	// VIDEO HOMEROOM
	[DIALOG_SCARYNUN]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_GUS]= {
		.statement[0].words="I found this...",
		.statement[0].next=0,
	},
	[DIALOG_RAISTLIN]= {
		.statement[0].words="This may aid you on your journey",
		.statement[0].next=0,
		// AMIGA?
	},
	[DIALOG_FORD]= {
		.statement[0].words="557-0868 Utopia BBS is really great!",
		.statement[0].next=0,
	},
#if 0
	AP CALCULUS, TEAM I-1
		PADRINO
			I MET SOMEONE AT THE DOG SHOW
			SHE WAS HOLDING MY LEFT ARM
		JENNI
			NEED TO GO TO ART ROOM
			JEN JENNY JENNO AND JENN WAITING
		MR. APPLEBY	ROAR
		KATHY
			LOW D-HIGH LESS HIGH D-LOW
			DRAW A LINE AND DOWN BELOW
			DENOMINATOR SQUARED MUST GO
		LIZBETH
		BLUME
			VINCE CON PATILLAS
#endif
	//DEUTSCH
	[DIALOG_NIRE]= {
		.statement[0].words="Vince, what are you doing!",
		.statement[0].next=0,
		// Sue you?
	},
	[DIALOG_AGENT_S]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_AGENT_G]= {
		.statement[0].words="Cultural experience on Friday!",
		.statement[0].next=0,
	},
	[DIALOG_AGENT_AP]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_FRAU]= {
		.statement[0].words="Immer mit der Ruhe!",
		.statement[0].next=0,
		.statement[1].words="Karte Spiel",
		.statement[1].next=0,
	},
#if 0
	HOMEROOM
		TRAPANI
			WEAVE!
			MAN THAT PARTY WAS SOMETHING ELSE
		WARWICK
			MARIOKART PARTY AT MY HOUSE
		WARGO
			WARWICK! AMAZING SWIMMER MUSCLES
			*SWOON*

		MEAN LADY
#endif
	// MATH OFFICE (ACADEMIC TEAM)
	[DIALOG_CAPTAIN_STEVE]= {
		.statement[0].words="Remember Reyerson\'s Rule",
		.statement[0].next=0,
		.statement[1].words="Any given team can be beaten",
		.statement[1].next=0,
		.statement[2].words="on any given day.",
		.statement[2].next=0,
	},
	[DIALOG_BRIGHID]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_RACHAEL]= {
		.statement[0].words="AP Bio Lab Partners must stick together",
		.statement[0].next=0,
	},
	[DIALOG_MREE]= {
		.statement[0].words="I\'m not evil",
		.statement[0].next=0,
		.statement[1].words="No esta aqui",
		.statement[1].next=0,
	},
#if 0
	PATRIOT ROOM:
		AGENT N
		GRABOWSKI
		FRESHMAN STEVE
		FRESHMAN JENNY


	OFFICE:
		ACTING PRINCIPAL ROBOKNEE
			SINCE WE HAVE NO ELECTRICITY WE HAVE NO LIGHTS
		SUSIE: Squeak
PUZZLE:

	Need wire, 
	670nm
	1.9ma		V=IR	
	9V, 4.7k

WHICH LED?
WHICH RESISTOR?
WHICH BATTERY?

ZAPPO, FREE THE GUINEA PIG
	(in cage?)
	show zapping through cloud of school

	GUINEA PIG joins your party

Then RK attack

#endif

};
