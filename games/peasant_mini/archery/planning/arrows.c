#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

#define SHOTS_PER_GAME	5

struct coord_type {
	int x,y;
	int scale;
	int xscale,yscale;
	int visible;
	int height;
};

struct collide_type {
	int visible;
};

static int origIndicatorY;

static int shotNum;
static int aimAllowed,shotAllowed,arrowFlying;
static int ar_gameOver,hits,gLastPointAmount;
static int buttonPress,meterDir,windDir=0;
static struct coord_type currentArrow_mc, arrowOriginalLoc;
static struct coord_type indicatorL,indicatorR;
static struct coord_type bow_mc,bowOriginalLoc;
static struct coord_type arrow_mc,meter_mc,hitmark_mc;

static struct collide_type bullseyeCollide_mc,targetCollide_mc;

static int success_visible[SHOTS_PER_GAME];

static int hitmarkCenter,vertOffset,horizOffset;

static void ar_endGame(void) {

	ar_gameOver = 1;
 	if (hits < 3) {
		printf("\"Sorry!\" says Dongolev.\n");
		if (hits == 1) {
			printf("\"Only 1 hit.\n");
		}
		else if(hits == 2) {
			printf("\"Only 2 hits.\n");
		}
		else {
			printf("\"Not a single hit.\n");
		}
		printf("Your game face must be on back-order.\n"
			"Maybe come back when your shipment comes in.\n");
		printf("\"But since you gave us this trinket,\n"
			"and you obviously don\'t have a prayer\n"
			"of winning, you can play again whenever\n"
			"you want.\"");
	}
	else {
		printf("\"Nice shootin! %d hits.\""
			" Says Mendelev. \"Here\'s your prize!\""
			" You got the SuperTime FunBow TM!\n"
			" We don\'t sell ammo, so you\'ll have\n"
			" to find your own arrows for it.",hits);
		gLastPointAmount = 3;
		// addEvent("scoreSomePoints",gCurrentShowString);
		//gameState.hasBow = true;
		//inventoryHistory.hasBow = true;
	}
	//gotoAndStop("ar_gameOver");
	//play();
	//trace("end game");
}

static void ar_updateWind(void) {

	int oldWind = windDir;

	while(windDir == oldWind) {
		windDir = random()%5;
	}
	// trace("ar_updateWind(): New wind direction chosen " + windDir);
	// trace("wind" + windDir);
	// flag_mc.gotoAndPlay("wind" + windDir);
	printf("windDir %d\n",windDir);

}


static int ar_initShot(void) {
	// trace(arrowOriginalLoc.x);
	// currentArrow_mc = arrowClip_mc.attachMovie("arrow_mc","arrow_mc" + shotNum,shotNum);
	// trace(currentArrow_mc._x);
	currentArrow_mc.x = arrowOriginalLoc.x;
	currentArrow_mc.y = arrowOriginalLoc.y;
	//trace(currentArrow_mc._x);
	currentArrow_mc.xscale = currentArrow_mc.yscale = arrowOriginalLoc.scale;
	shotNum++;

	if(shotNum > SHOTS_PER_GAME) {
		ar_endGame();

		// delete this.onEnterFrame;
		return  0;
	}
	aimAllowed = 1;
	shotAllowed = 1;
	ar_updateWind();
	buttonPress = 0;
	meterDir = -1;
	arrowFlying = 0;
	indicatorL.y = indicatorR.y = origIndicatorY;
	bow_mc.x = bowOriginalLoc.x;
	bow_mc.y = bowOriginalLoc.y;
	//this.onEnterFrame = ar_main;

	return 1;
}


static void ar_initArchery(void) {

	int i;

	shotNum = 0;

	origIndicatorY = indicatorL.y;
	arrowOriginalLoc.x = arrow_mc.x;
	arrowOriginalLoc.y = arrow_mc.y;
	arrowOriginalLoc.scale = arrow_mc.xscale;

	bow_mc.x = 256; /* think game assumes 512 wide window? */
	bowOriginalLoc.x = bow_mc.x;
	bow_mc.y = 320; /* this is a guess? */

	bowOriginalLoc.y = bow_mc.y;

	meter_mc.x=10;
	meter_mc.y=70;
	meter_mc.height=70;


	arrow_mc.visible = 0;
	ar_initShot();
	bullseyeCollide_mc.visible = 0;
	targetCollide_mc.visible = 0;

	for(i=0;i<5;i++) {
		success_visible[i]=0;
	}
	hits = 0;
	ar_gameOver = 0;
}

static void ar_shiftAim(int dir) {

	currentArrow_mc.x += dir;
	bow_mc.x += dir;
	if ((bow_mc.x < 80) || (bow_mc.x > 430)) {
		currentArrow_mc.x -= dir;
		bow_mc.x -= dir;
	}
	printf("Bow now at: %d,%d\n",bow_mc.x,bow_mc.y);
}

	/* erase arrows left as use up shots */
static void ar_updateShotsMeter(void) {
	printf("Shots left: %d\n",SHOTS_PER_GAME - (shotNum-1));
	//eval("arrowsLeft" + (SHOTS_PER_GAME - (shotNum - 1)))._visible = false;
}

static int ar_hitMovieClip(struct collide_type the_mc) {
//	var arrowTip = new Object({x:currentArrow_mc.arrowCollide_mc._x,y:currentArrow_mc.arrowCollide_mc._y});
//	currentArrow_mc.localToGlobal(arrowTip);
//	return the_mc.hitTest(arrowTip.x,arrowTip.y,true);
	return 0;
}

static void ar_shootArrow(void) {

	if (!arrowFlying) {
		arrowFlying = 1;
		// bow_mc.gotoAndStop("idle");
		// currentArrow_mc.gotoAndPlay("shoot");

		printf("playSound arrowshoot\n");

		/* update number of arrows in pile */
		ar_updateShotsMeter();

		horizOffset = (indicatorL.y - indicatorR.y) / 5;
		if (horizOffset > 15) {
			horizOffset = 15;
		}
		if (horizOffset < -15) {
			horizOffset = -15;
		}

		printf("horizOffset %d\n",horizOffset);

		hitmarkCenter = hitmark_mc.y + hitmark_mc.height / 2;

		printf("hitmarkCenter %d\n",hitmarkCenter);

		vertOffset = (- (hitmarkCenter - indicatorL.y +
				(hitmarkCenter - indicatorR.y))) / 3;

		if (vertOffset > 15) {
			vertOffset = 15;
		}
		if (vertOffset < -15) {
			vertOffset = -15;
		}

		printf("vertOffset %d\n",vertOffset);
	}

	switch(windDir) {

		case 0:
			currentArrow_mc.x -= 12;
			break;
		case 1:
			currentArrow_mc.x -= 6;
			break;
		case 2:
			break;
		case 3:
			currentArrow_mc.x += 6;
			break;
		case 4:
			currentArrow_mc.x += 12;
			break;
	}

	currentArrow_mc.x += horizOffset;
	currentArrow_mc.y += vertOffset;

	printf("Arrow %d,%d\n",currentArrow_mc.x,currentArrow_mc.y);

	//void ar_doneShooting(void) {
	//delete this.onEnterFrame;

	if (ar_hitMovieClip(bullseyeCollide_mc)) {
		printf("playSound bullseye\n");
		success_visible[hits]=1;
		hits++;
		// eval("Success" + hits)._visible = true;
	}
	else {
		printf("playSound mudsplat\n");
	}
	ar_initShot();

}

static void ar_updateMeter(void) {

	if (buttonPress == 1) {
		indicatorL.y += 10 * meterDir;
		indicatorR.y += 10 * meterDir;
	}
	else {
		indicatorR.y += 12 * meterDir;
	}

	if (indicatorR.y < meter_mc.y) {
		meterDir = 1;
		indicatorR.y = meter_mc.y;
	}

	if (indicatorL.y < meter_mc.y) {
		indicatorL.y = meter_mc.y;
	}

	printf("Meter: %d %d\n",indicatorL.y,indicatorR.y);

	if (indicatorR.y > meter_mc.y + meter_mc.height) {
		buttonPress++;
		indicatorL.y = indicatorR.y = origIndicatorY;
		ar_shootArrow();
	}

	usleep(100000);
}

int main(int argc, char **argv) {

	struct termios old_attr, new_attr;

	int ch=0;

	tcgetattr (0, &old_attr);
	tcgetattr (0, &new_attr);
	new_attr.c_lflag &= ~ICANON;
	new_attr.c_cc[VMIN] = 1;
	new_attr.c_lflag &= ~ECHO;
	tcsetattr (0, TCSANOW, &new_attr);
	fcntl (0, F_SETFL, fcntl (0, F_GETFL) | O_NONBLOCK);

	ar_initArchery();

	while(1) {
		ch=getchar();

		if (aimAllowed) {
			//if (Key.isDown(37)) {
			if (ch=='a') { // left
				ar_shiftAim(-2);
				printf("Left!\n");
			}
			//if (Key.isDown(39)) {
			if (ch=='d') { // right
				ar_shiftAim(2);
				printf("Right!\n");
			}
		}


		if (ch=='q') {
			break;
		}

		if (ch==' ') {

			// void ar_spacePressed(void) {

			if (!ar_gameOver) {
				// bow_mc.gotoAndStop("cocked");
				if (buttonPress >= 2) {
					ar_shootArrow();
				}
				buttonPress++;
			}
		}

		if (buttonPress > 0) {
			ar_updateMeter();
		}
		if (ar_gameOver) break;
	}

	tcsetattr (0, TCSANOW, &old_attr);

}

void ar_targetLevelReached(void) {

//	if (ar_hitMovieClip(targetCollide_mc)) {
//		currentArrow_mc.gotoAndPlay("hit");
//	}
//	else {
//		currentArrow_mc.gotoAndPlay("miss");
//	}
}
