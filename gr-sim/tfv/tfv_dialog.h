#define ACTION_NONE	0
#define ACTION_ITEM	1
#define ACTION_TIME	2
#define ACTION_QUERY	3
#define ACTION_BIRD	4
#define ACTION_SMARTPASS	5
#define ACTION_RESTORE	6

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

#define DIALOG_MAC		31
#define DIALOG_AGENT_N		32
#define DIALOG_STEVE2		33
#define DIALOG_GRABOWSKI	34

#define DIALOG_LIZBETH		35
#define DIALOG_BLUME		36

#define DIALOG_APPLEBY		37
#define DIALOG_PADRINO		38
#define DIALOG_JENNI		39
#define DIALOG_KATHY		40

#define DIALOG_MEAN_LADY	41
#define DIALOG_TRAPANI		42
#define DIALOG_WARWICK		43
#define DIALOG_WARGO		44

#define MAX_DIALOG		45

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

extern struct dialog_type dialog[MAX_DIALOG];

void init_dialog(void);
