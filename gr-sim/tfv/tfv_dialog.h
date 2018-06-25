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
		.statement[0].words="Your journey may take you to darkest Bel Air.",
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
#if 0
DINING HALL
	OSCAR
		BEWARE THE KILLER CRABS
		THEY WANT TO MEET YOU
		THEY WANT TO EAT YOU
	NICOLE
	CINDY
	ELAINE
		REMEMBER OHMS LAW
		TWINKLE TWINKLE LITTLE STAR
		V IS EQUAL TO IR
	CAFETERIA LADY
		HAPPY BIRTHDAY

METRO STATION
	METRO WORKER
		WOULD YOU LIKE TO BUY A SMARTPASS
		SORRY ALL TRAINS CANCELLED: SMARTTRIP
	TINY CAPABARA
		GRONK
	GIANT GUINEA PIG
		SQUEAK?
		-> YES
		-> NO
	LARGE BIRD
		WARK?
		-> YES
		-> NO

FOUNTAIN -- drink from it restore heatlh?
	MERMAID
		Did ye put bubbles in yon fountain?



BEL AIR

CMW
	NO ADMITTANCE WITHOUT TRENCHCOAT

MALL

MINIGOLF
	CLOSED FOR THE SEASON

JC



	VIDEO HOMEROOM
		SISTER SCARYNUN
		GUS	I FOUND THIS
		RAISTLIN
			THIS MAY AID YOU ON YOUR JOURNEY
			AMIGA
		FORD
			557-0868 UTOPIA BBS IS REALLY GREAT

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
	DEUTSCH
		AGENT G
		AGENT AP
		AGENT S
		NIRE
		FRAU: DER DIE DAS

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

	MATH OFFICE (ACADEMIC TEAM)
		CAPTAIN STEVE
			"REMEMBER REYERSON\'S RULE"
			ANY GIVEN TEAM CAN BE BEATEN
			ON ANY GIVEN DAY
		BRIGHID
		RACHAEL YRBK
			AP BIO LAB PARTNERS
			MUST STICK TOGETHER
		MREE
			"I\'M NOT EVIL"
			NO ESTA AQUI

	PATRIOT ROOM
		AGENT N
		ACTING PRINCIPAL ROBOKNEE
			SINCE WE HAVE NO ELECTRICITY WE HAVE NO LIGHTS

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



