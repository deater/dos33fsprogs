#include <stdio.h>

#include "tfv_dialog.h"
#include "tfv_items.h"

struct dialog_type dialog[MAX_DIALOG]={

	// Talbot Hall
	[DIALOG_LIZ_WILL] = {
		.statement[0].words="Let\'s discuss cool things in the lounge.",
		.statement[0].next=1,
		.statement[0].action=ACTION_QUERY,
		.statement[1].words="YES!",
		.statement[1].next=3,
		.statement[2].words="Sorry, need to do engineering homework.",
		.statement[2].next=4,
		.statement[3].words="Four hours pass...",
		.statement[3].action=ACTION_TIME,
		.statement[3].next=0,
		.statement[4].words="Maybe next time.",
		.statement[4].next=0,
	},
	[DIALOG_PETE] = {
		.statement[0].words="Your journey takes you toward Bel Air.",
		.statement[0].next=1,
		.statement[1].words="Hari Seldon predicted this!",
		.statement[1].next=2,
		.statement[2].words="PLOT!",
		.statement[2].next=2,

	},
	[DIALOG_KENJESU] = {
		.statement[0].words="Have you found your lost guinea pig?",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_VORTEXCANNON,
	},
	[DIALOG_MATHEMAGICIAN] = {
		.statement[0].words="Have you tried finding the eigenvalues?",
		.statement[0].next=0,
	},
	[DIALOG_DARTH_TATER] = {
		.statement[0].words="In Talbot 0101C",
		.statement[0].next=1,
		.statement[1].words="There lived a big giant bee",
		.statement[1].next=1,
		.statement[1].action=ACTION_ITEM,
		.statement[1].item=ITEM_5K_RESISTOR,
	},
	// Dining Hall
	[DIALOG_OSCAR]= {
		.statement[0].words="Beware the killer crabs",
		.statement[0].next=1,
		.statement[1].words="They want to meet you",
		.statement[1].next=2,
		.statement[2].words="They want to eat you",
		.statement[2].next=0,
		.statement[2].action=ACTION_ITEM,
		.statement[2].item=ITEM_CHEX_MIX,
	},
	[DIALOG_NICOLE]= {
		.statement[0].words="Have something from my homeland.",
		.statement[0].next=1,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_VEGEMITE,
		.statement[1].words="Not New Jersey, the other one.",
		.statement[1].next=0,
	},
	[DIALOG_CINDY]= {
		.statement[0].words="...",
		.statement[0].next=0,
	},
	[DIALOG_ELAINE]= {
		.statement[0].words="Remember Ohm\'s Law",
		.statement[0].next=1,
		.statement[1].words="Twinkle Twinkle Little Star",
		.statement[1].next=2,
		.statement[2].words="V is equal to IR",
		.statement[2].next=0,
		.statement[2].action=ACTION_ITEM,
		.statement[2].item=ITEM_1K_RESISTOR,
	},
	[DIALOG_CAFETERIA_LADY]= {
		.statement[0].words="Happpy Birthday!",
		.statement[0].next=1,
		.statement[1].words="Have a cupcake",
		.statement[1].next=0,
		.statement[1].action=ACTION_ITEM,
		.statement[1].item=ITEM_CUPCAKE,
	},
	// Metro Station
	[DIALOG_METRO_WORKER]= {
		.statement[0].words="Would you like to buy at SmartPass?",
		.statement[0].next=1,
		.statement[0].action=ACTION_QUERY,
		.statement[1].words="YES",
		.statement[1].next=3,
		.statement[2].words="NO",
		.statement[2].next=4,
		.statement[3].words="That will be $5",
		.statement[3].action=ACTION_SMARTPASS,
		.statement[3].next=4,
		.statement[4].words="Sorry, all trains cancelled. SmartTrip",
		.statement[4].next=4,
	},
	[DIALOG_TINY_CAPABARA]= {
		.statement[0].words="GRONK",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_CARROT,
	},
	[DIALOG_GIANT_GUINEA_PIG]= {
		.statement[0].words="SQUEAK?",
		.statement[0].next=0,
	},
	[DIALOG_LARGE_BIRD]= {
		.statement[0].words="WARK?",
		.statement[0].next=0,
		.statement[0].action=ACTION_QUERY,
		.statement[1].words="YES",
		.statement[1].next=3,
		.statement[2].words="NO",
		.statement[2].next=4,
		.statement[3].words="WARK!",
		.statement[3].action=ACTION_BIRD,
		.statement[3].next=0,
		.statement[4].words="Poot-tee-tweet",
		.statement[4].next=0,
	},
	// FOUNTAIN
	[DIALOG_MERMAID]= {
		.statement[0].words="Did ye put bubbles in yon fountain?",
		.statement[0].next=0,
		.statement[0].action=ACTION_QUERY,
		.statement[1].words="YES",
		.statement[1].next=3,
		.statement[2].words="NO",
		.statement[2].next=4,
		.statement[3].words="Begone, wastrel!",
		.statement[3].next=0,
		.statement[4].words="Must have been those band knaves.",
		.statement[4].next=0,
		.statement[4].action=ACTION_RESTORE,
	},
	// BEL AIR
	[DIALOG_CMW]= {
		.statement[0].words="No admittance without black trenchcoat",
		.statement[0].next=0,
	},
	[DIALOG_MALL]= {
		.statement[0].words="Closed for rennovation",
		.statement[0].next=0,
	},
	[DIALOG_MINIGOLF]= {
		.statement[0].words="Closed for the season",
		.statement[0].next=0,
	},
	// VIDEO HOMEROOM
	[DIALOG_SCARYNUN]= {
		.statement[0].words="No talking in the library.",
		.statement[0].next=0,
	},
	[DIALOG_GUS]= {
		.statement[0].words="I found this...",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_GLAMDRING,
	},
	[DIALOG_RAISTLIN]= {
		.statement[0].words="This may aid you on your journey",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_LINUX_CD,
		.statement[1].words="Should I sell my Amiga for an SGI Indigo2",
		.statement[1].next=0,
	},
	[DIALOG_FORD]= {
		.statement[0].words="557-0868 Utopia BBS is really great!",
		.statement[0].next=0,
	},
	// AP-CALCULUS
	[DIALOG_APPLEBY]= {
		.statement[0].words="ROAR!",
		.statement[0].next=0,
	},
	[DIALOG_PADRINO]= {
		.statement[0].words="I MET SOMEONE AT THE DOG SHOW",
		.statement[0].next=1,
		.statement[1].words="SHE WAS HOLDING MY LEFT ARM",
		.statement[1].next=0,
	},
	[DIALOG_JENNI]= {
		.statement[0].words="I need to get to the art room.",
		.statement[0].next=1,
		.statement[1].words="Jen, Jenny, Jenno and Jenn waiting",
		.statement[1].next=0,

	},
	[DIALOG_KATHY]= {
		.statement[0].words="LOW D-HIGH LESS HIGH D-LOW",
		.statement[0].next=1,
		.statement[1].words="DRAW A LINE AND DOWN BELOW",
		.statement[1].next=2,
		.statement[2].words="DENOMINATOR SQUARED MUST GO",
		.statement[2].next=0,
		.statement[2].action=ACTION_ITEM,
		.statement[2].item=ITEM_9V_BATTERY,
	},
	// HALLWAY
	[DIALOG_LIZBETH]={
		.statement[0].words="Let's start a guinea pig and goat farm.",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_LIZBETH_STAR,
	},
	[DIALOG_BLUME]={
		.statement[0].words="Deater con patillas",
		.statement[0].next=0,
	},
	//DEUTSCH
	[DIALOG_NIRE]= {
		.statement[0].words="What are you doing now?",
		.statement[0].next=1,
		.statement[1].words="No more lawsuits.",
		.statement[1].next=0,
		.statement[1].action=ACTION_ITEM,
		.statement[1].item=ITEM_AA_BATTERY,
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
		.statement[0].words="Gehen wir zum Schinken und Bonbon Cafe",
		.statement[0].next=0,
	},
	[DIALOG_FRAU]= {
		.statement[0].words="Immer mit der Ruhe!",
		.statement[0].next=1,
		.statement[1].words="Karte Spiel!",
		.statement[1].next=0,
		.statement[1].action=ACTION_ITEM,
		.statement[1].item=ITEM_KARTE_SPIEL,
	},
	// HOMEROOM
	[DIALOG_MEAN_LADY]= {
		.statement[0].words="Time for homeroom cleanup!",
		.statement[0].next=0,
		// PUFFS PLUS
	},
	[DIALOG_TRAPANI]= {
		.statement[0].words="WEAVE!",
		.statement[0].next=1,
		.statement[1].words="MAN THAT PARTY WAS SOMETHING ELSE",
		.statement[1].next=0,
	},
	[DIALOG_WARWICK]={
		.statement[0].words="MARIOKART PARTY AT MY HOUSE",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_BLUE_LED,
	},
	[DIALOG_WARGO]={
		.statement[0].words="WARWICK! AMAZING SWIMMER MUSCLES",
		.statement[0].next=1,
		.statement[1].words="*SWOON*",
		.statement[1].next=1,
	},
	// MATH OFFICE (ACADEMIC TEAM)
	[DIALOG_CAPTAIN_STEVE]= {
		.statement[0].words="Remember Reyerson\'s Rule",
		.statement[0].next=1,
		.statement[1].words="Any given team can be beaten",
		.statement[1].next=0,
		.statement[2].words="on any given day.",
		.statement[2].next=0,
		.statement[2].action=ACTION_ITEM,
		.statement[2].action=ITEM_ARMY_KNIFE,
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
		.statement[0].next=1,
		.statement[1].words="No esta aqui",
		.statement[1].next=0,
		.statement[1].action=ACTION_ITEM,
		.statement[1].item=ITEM_ELF_RUNES,
	},
	// Patriot Room
	[DIALOG_MAC]= {
		.statement[0].words="File not found",
		.statement[0].next=1,
		.statement[1].words="Abort, Retry, Fail",
		.statement[1].next=2,
		.statement[2].words="Do you like my DOS impression?",
		.statement[2].next=3,
		.statement[3].words="Shall we play a game?",
		.statement[3].next=3,
	},
	[DIALOG_AGENT_N]= {
		.statement[0].words="Not another Starfleet Mission.",
		.statement[0].next=0,
		.statement[0].action=ACTION_ITEM,
		.statement[0].item=ITEM_RED_LED,
	},
	[DIALOG_STEVE2]= {
		.statement[0].words="How bout them O\'s",
		.statement[0].next=1,
		.statement[1].words="Want to hear about Fantasy Baseball?",
		.statement[1].next=0,
	},
	[DIALOG_GRABOWSKI]= {
		.statement[0].words="Ahhh, Mr. Bombem.",
		.statement[0].next=0,
	},

#if 0
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


void init_dialog(void) {
	int i;

	for(i=0;i<MAX_DIALOG;i++) {
		dialog[i].count=-1;
	}
}
