// function VTM2PT3(PT3:PSpeccyModule;VTM:PModule;
// function PT32VTM

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>

static unsigned char buffer[65536];

static short ChPtr[3];
static unsigned char Skip[3];
static unsigned char SkipCounter[3];
static unsigned char PrevOrn[3];
static int NsBase;
static short pt3_pat_ptr;

struct additional_cmd_type {
	unsigned char Number;
	unsigned char Delay;
	unsigned char Parameter;

};

struct channel_line_type {
	int Note;
	unsigned char Sample;		// 0..31
	unsigned char Ornament;		// 0..15
	unsigned char Volume;		// {1-15 - vol, 0 - prev vol}
	unsigned char Envelope;		// {1-14 - R13, 15 - Envelope off, 0 - prev}
	struct additional_cmd_type Additional_Command;
};

struct item_type {
	unsigned char Noise;
	unsigned short Envelope;
	struct channel_line_type Channel[3];
};

struct pattern_type {
	int length;
	struct item_type Items[256];
} patterns[256];

static int debug=1;

void PatternInterpreter(int PatNum, int LnNum, int ChNum) {

	int quit;
	short tmp;

	quit=0;

	int initial;

	do {

		initial=buffer[ChPtr[ChNum]];

		switch(initial) {

		/* ???? */
		case 0xf0 ... 0xff:
			if (debug) printf("%x: ??\n",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope=
				15;
			PrevOrn[ChNum] = buffer[ChPtr[ChNum]] - 0xf0;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Ornament=
				PrevOrn[ChNum];
			ChPtr[ChNum]++;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Sample=
				buffer[ChPtr[ChNum]] / 2;
	           	break;
		/* Set Sample */
		case 0xd1 ... 0xef:
			if (debug) printf("%x: Sample ",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Sample=
				buffer[ChPtr[ChNum]]-0xd0;
			break;
		/* Nothing? */
		case 0xd0:
			if (debug) printf("%x: Nothing ",initial);
			quit=1;
			break;
		/* Volume */
		case 0xc1 ... 0xcf:
			if (debug) printf("%x: Volume ",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Volume=
				buffer[ChPtr[ChNum]]-0xc0;
			break;
		/* Sound off? */
		case 0xc0:
			patterns[PatNum].Items[LnNum].Channel[ChNum].Note=-2;
			quit=1;
			break;
		/* ??? */
		case 0xb2 ... 0xbf:
			patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope=
				buffer[ChPtr[ChNum]]-0xb1;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Ornament=
				PrevOrn[ChNum];
			ChPtr[ChNum]++;
			patterns[PatNum].Items[LnNum].Envelope=
				((short)buffer[ChPtr[ChNum]])<<8;
			ChPtr[ChNum]++;
			patterns[PatNum].Items[LnNum].Envelope+=
				buffer[ChPtr[ChNum]];
			break;

		/* ??? */
		case 0xb1:
			ChPtr[ChNum]++;
			Skip[ChNum]=buffer[ChPtr[ChNum]];
			break;
		/* ??? */
		case 0xb0:
			patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope=
				15;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Ornament=
				PrevOrn[ChNum];
			break;
		/* Set note */
		case 0x50 ... 0xaf:
			if (debug) printf("%x: Note ",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Note=
				buffer[ChPtr[ChNum]] - 0x50;
			quit=1;
			break;
		/* ??? */
		case 0x40 ... 0x4f:
			if (buffer[ChPtr[ChNum]]==0x40) {
				//  only for Orn #0 rom pt3.69
				if (patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope == 0) {
					patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope = 15;
				}
			}
			PrevOrn[ChNum] = buffer[ChPtr[ChNum]]-0x40;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Ornament=
				PrevOrn[ChNum];
			break;
		/* Set noise */
		case 0x20 ... 0x3f:
			if (debug) printf("%x: Noise ",initial);
			NsBase = buffer[ChPtr[ChNum]]-0x20;
			break;
		/* ?? */
		case 0x10 ... 0x1f:
			if (debug) printf("%x: ??? ",initial);
			if (buffer[ChPtr[ChNum]]==0x10) {
				patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope=15;
			}
			else {
				patterns[PatNum].Items[LnNum].Channel[ChNum].Envelope=buffer[ChPtr[ChNum]]-0x10;
				ChPtr[ChNum]++;
				patterns[PatNum].Items[LnNum].Envelope=((short)(buffer[ChPtr[ChNum]]))<<8;
				ChPtr[ChNum]++;
				patterns[PatNum].Items[LnNum].Envelope+=buffer[ChPtr[ChNum]];
			}
			patterns[PatNum].Items[LnNum].Channel[ChNum].Ornament = PrevOrn[ChNum];
			ChPtr[ChNum]++;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Sample=
				buffer[ChPtr[ChNum]] / 2;
			break;
		/* Additional Command Number */
		case 0x8 ... 0x9:
			if (debug) printf("%x: ??? ",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number=
				buffer[ChPtr[ChNum]];
			break;
		/* Additional Command Number */
		case 0x1 ... 0x5:
			if (debug) printf("%x: ??? ",initial);
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number=
				buffer[ChPtr[ChNum]];
			break;
		default:
			printf("UNKNOWN VALUE %x\n",initial);
			break;
		}

		ChPtr[ChNum]++;
	} while (!quit);

	/* Handle Additional Commands */
	initial=patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number;
	switch(initial) {
	case 1:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Delay=buffer[ChPtr[ChNum]];
		ChPtr[ChNum]++;
		memcpy(&tmp,&buffer[ChPtr[ChNum]],2);
		if (tmp<0) {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=-tmp;
		}
		else {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=tmp;
		}
		ChPtr[ChNum]+=2;
		break;
	case 2:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Delay=buffer[ChPtr[ChNum]];
		ChPtr[ChNum]+=3;
		memcpy(&tmp,&buffer[ChPtr[ChNum]],2);
		if (tmp < 0) {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter = -tmp;
		} else {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter = tmp;
		}
		ChPtr[ChNum]+=2;
		break;
	case 3:
	case 4:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=buffer[ChPtr[ChNum]];
		ChPtr[ChNum]++;
		break;
	case 5:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=
			buffer[ChPtr[ChNum]]<<4;
		ChPtr[ChNum]++;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter+=
			buffer[ChPtr[ChNum]];
		ChPtr[ChNum]++;
		break;
	case 8:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Delay=buffer[ChPtr[ChNum]];
		ChPtr[ChNum]++;
		memcpy(&tmp,&buffer[ChPtr[ChNum]],2);
		if (tmp<0) {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number++;
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=-tmp;
		} else {
			patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=tmp;
		}
		ChPtr[ChNum]+=2;
		break;
	case 9:
		printf("AC: %d\n",initial);
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Number=0xb;
		patterns[PatNum].Items[LnNum].Channel[ChNum].Additional_Command.Parameter=buffer[ChPtr[ChNum]];
        	ChPtr[ChNum]++;
		break;
	case 0:	/* do nothing? */
		break;
	default:
		printf("Unknown Additional Command %d!\n",initial);
		break;
	}
	SkipCounter[ChNum]=Skip[ChNum];

}

//TPattern = record
//   Length:integer;
//   Items:array[0..MaxPatLen-1] of record
//    Noise:byte;
//    Envelope:word;
//    Channel:array[0..2]of TChannelLine;
//   end;
//  end;

//TChannelLine = packed record
//   Note:shortint; {0..95} {-2 - Sound off (R--)} {-1 - No note (---)}
//   Sample:byte; {0..31}
//   Ornament:byte; {0..15}
//   Volume:shortint; {1-15 - vol, 0 - prev vol}
//   Envelope:byte; {1-14 - R13, 15 - Envelope off, 0 - prev}
//   Additional_Command:TAdditionalCommand;
//  end;



// ChPtr:packed array[0..2] of word;
// Skip:array[0..2] of byte;
// SkipCounter:array[0..2] of byte;
// PrevOrn:array[0..2] of byte;
// NsBase:integer;
// TS:integer;






#define MAXPATLEN	256

void DecodePattern(int j, int jj) {
	int i,k,quit,NsBase;

   	for(k=0;k<3;k++) {
		PrevOrn[k] = 0;
		SkipCounter[k] = 1;
		Skip[k] = 1;
	}

	memcpy( ChPtr, &buffer[pt3_pat_ptr+jj*6],6);
	printf("\tCopying 6 bytes at %x\n",pt3_pat_ptr+(jj*6));

	NsBase = 0;
	i = 0;
	quit = 0;

	while ((i < MAXPATLEN) && (!quit)) {
		for(k=0;k<3;k++) {
			SkipCounter[k]--;
			if (SkipCounter[k]==0) {
				if ((k == 0) && (buffer[ChPtr[0]]== 0)) {
					i--;
					quit = 1;
					break;
  				}
				PatternInterpreter(j,i,k);
       			}
		}
		patterns[j].Items[i].Noise = NsBase;
		i++;
	}
	patterns[j].length = i;
	printf("\tPattern: %d long\n",i);
}

int FoundPT36TS(void) {
#if 0
 function FoundPT36TS:boolean;
 var
  j1,j2,k,Pos:Integer;
 begin
 Result := False;
 if PT3.PT3_Name[13] <> '6' then exit;
 Pos := 0;
 while (Pos < 256) and (PT3.Index[Pos + $c9] <> 255) do
  begin
   j1 := PT3.Index[Pos + $c9] div 3;
   if j1 < $30/2 then exit;
   j2 := $30 - j1 - 1;
   move(PT3.Index[PT3.PT3_PatternsPointer + j2*6],ChPtr,6);
   for k := 0 to 2 do
    if (ChPtr[k] < 100) or (ChPtr[k] >= FSize - 4) then exit;
   Inc(Pos);
  end;
 if MessageDlg('This PT 3.6 module can contain Turbo Sound data. Try to import?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
 TS := $30;
 Result := True;
 end;
#endif
	return 1;
}

int main(int argc, char **argv) {

	int i;
	int fd,result;
	char pt3_name[100];
	char pt3_table,pt3_delay,pt3_numpos,pt3_looppos;
	short pt3_sample_ptrs[32];
	short pt3_ornament_ptrs[16];
	int found_pt36=0;

	char *filename="mockingbird.pt3";

	fd=open(filename,O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Error opening %s: %s\n",filename,strerror(errno));
		return -1;
	}
	result=read(fd,buffer,8192);
	close(fd);

	printf("Read %d bytes ($%04x) from %s\n",result,result,filename);

	strncpy(pt3_name,(char *)buffer,98);
	pt3_table=buffer[99];
	pt3_delay=buffer[100];
	pt3_numpos=buffer[101];
	pt3_looppos=buffer[102];
	pt3_pat_ptr=buffer[103]|buffer[104]<<8;

	for(i=0;i<32;i++) {
		pt3_sample_ptrs[i]=buffer[105+(2*i)]|buffer[106+(2*i)]<<8;
	}

	for(i=0;i<16;i++) {
		pt3_ornament_ptrs[i]=buffer[169+(2*i)]|buffer[170+(2*i)]<<8;
	}

	printf("PT3:\n");
	printf("\t%s\n",pt3_name);
	printf("\tTable: $%02x\n",pt3_table);
	printf("\tDelay: $%02x\n",pt3_delay);
	printf("\tNumPos: $%02x\n",pt3_numpos);
	printf("\tLoopPos: $%02x\n",pt3_looppos);
	printf("\tPatPtr: $%04x\n",pt3_pat_ptr);
	printf("\tSmplPtr: ");
		for(i=0;i<32;i++) printf(" $%04x",pt3_sample_ptrs[i]);
	printf("\n");

	printf("\tOrnamentPtr: ");
		for(i=0;i<16;i++) printf(" $%04x",pt3_ornament_ptrs[i]);
	printf("\n");

// File Format:
//	00..1e (  0.. 30) = "ProTracker 3.4 compilation of " or similar
//	1f..3e ( 31.. 63) = Title
//			  = " by "
//	43..62 (        ) = Author
//          63 (      99) = Table
//	    64 (     100) = Delay
//          65 (     101) = NumPos
//          66 (     102) = LoopPos
//      67..68 (103..104) = PatPtr
//	       (105..168)	32 Sample Pointer
//	       (169..200)	16 Ornament Pointers
//	    C9


 
//function PT32VTM;
//var
// ChPtr:packed array[0..2] of word;
// Skip:array[0..2] of byte;
// SkipCounter:array[0..2] of byte;
// PrevOrn:array[0..2] of byte;
// NsBase:integer;
// TS:integer;

//var
// i,j,k,kk,Pos:Integer;
// tset:boolean;
//begin
//Result := True;
//if DetectFeaturesLevel then
// begin
//  if StrLComp(@PT3.PT3_Name,'ProTracker 3.',13) = 0 then
//   case Ord(PT3.PT3_Name[13]) of
//   $30..$35: VTM1.FeaturesLevel :=  0;
//   $37..$39: VTM1.FeaturesLevel :=  2;
//   else VTM1.FeaturesLevel :=  1;
//   end
//  else if StrLComp(@PT3.PT3_Name,'Vortex Tracker II',17) = 0 then
//   VTM1.FeaturesLevel :=  1
//  else
//   VTM1.FeaturesLevel :=  0;
// end;
//if DetectModuleHeader then
// VTM1.VortexModule_Header := StrLComp(@PT3.PT3_Name,'ProTracker 3.',13) <> 0;


// Title
	//SetLength(VTM1.Title,32);
	//Move(PT3.PT3_Name[$1e],VTM1.Title[1],32);
	// VTM1.Title := TrimRight(VTM1.Title);
// Author
	//SetLength(VTM1.Author,32);
	// Move(PT3.PT3_Name[$42],VTM1.Author[1],32);
	// VTM1.Author := TrimRight(VTM1.Author);
// Table
	// VTM1.Ton_Table := PT3.PT3_Table;
// Delay
	// VTM1.Initial_Delay := PT3.PT3_Delay;
// LoopPos
	// VTM1.Positions.Loop := PT3.PT3_LoopPosition;

	// for i := 0 to 255 do
	// VTM1.Positions.Value[i] := 0;
// OrnamentPtrs
	// VTM1.Ornaments[0] := nil;
	// for i := 1 to 15 do
	// begin
	// if PT3.PT3_OrnamentPointers[i] = 0 then
	//  VTM1.Ornaments[i] := nil
	//  else
	//   begin
//   New(VTM1.Ornaments[i]);
//   VTM1.Ornaments[i].Loop := PT3.Index[PT3.PT3_OrnamentPointers[i]];
//   VTM1.Ornaments[i].Length := PT3.Index[PT3.PT3_OrnamentPointers[i] + 1];
//   for j := 0 to VTM1.Ornaments[i].Length - 1 do
//    VTM1.Ornaments[i].Items[j] := PT3.Index[PT3.PT3_OrnamentPointers[i] + 2 + j];
//  end;
// end;

// SamplePtrs
	// for i := 1 to 31 do
	// begin
	//  if PT3.PT3_SamplePointers[i]=0 then
	//   VTM1.Samples[i] := nil
	//  else
	//   begin
	//     New(VTM1.Samples[i]);
	//    VTM1.Samples[i].Loop := PT3.Index[PT3.PT3_SamplePointers[i]];
	//     VTM1.Samples[i].Length := PT3.Index[PT3.PT3_SamplePointers[i] + 1];
	//    for j := 0 to VTM1.Samples[i].Length - 1 do
	//     begin
//      VTM1.Samples[i].Items[j].Add_to_Ton :=
//                WordPtr(@PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 4])^;
//      VTM1.Samples[i].Items[j].Ton_Accumulation :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 3] and $40 <> 0;
//      VTM1.Samples[i].Items[j].Amplitude :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 3] and $f;
//      VTM1.Samples[i].Items[j].Amplitude_Sliding :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 2] and $80 <> 0;
//      VTM1.Samples[i].Items[j].Amplitude_Slide_Up :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 2] and $40 <> 0;
//      VTM1.Samples[i].Items[j].Envelope_Enabled :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 2] and 1 = 0;
//      VTM1.Samples[i].Items[j].Envelope_or_Noise_Accumulation :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 3] and $20 <> 0;
//      VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise :=
//                PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 2] shr 1;
//      if VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise and $10 <> 0 then
//       VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise :=
//         VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise or shortint($f0)
//      else
//       VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise :=
//         VTM1.Samples[i].Items[j].Add_to_Envelope_or_Noise and 15;
//       VTM1.Samples[i].Items[j].Mixer_Ton :=
//         PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 3] and $10 = 0;
//       VTM1.Samples[i].Items[j].Mixer_Noise :=
//         PT3.Index[PT3.PT3_SamplePointers[i] + j*4 + 3] and $80 = 0
//     end
//   end
// end;


//for i := 0 to MaxPatNum do
// VTM1.Patterns[i] := nil;

//VTM2 := nil; TS := Byte(PT3.PT3_Name[98]);

	if ((pt3_table!=0x20)) {
		if ((buffer[13]>='7') && (buffer[13]<='9')) {
			printf("Special case if PT3.6 or later\n");
		}
		if (found_pt36) {
			printf("Special case if PT3.6 or later\n");
		}

//if ((TS <> $20) and (PT3.PT3_Name[13] in ['7'..'9'])) or FoundPT36TS then
// begin
//  New(VTM2);
//  VTM2^ := VTM1^;
//  New(VTM2.Patterns[-1]);
//  VTM2.Patterns[-1]^ := VTM1.Patterns[-1]^;
//  for i := 1 to 15 do
//   if VTM1.Ornaments[i] <> nil then
//    begin
//     New(VTM2.Ornaments[i]);
//     VTM2.Ornaments[i]^ := VTM1.Ornaments[i]^;
//    end;
//  for i := 1 to 31 do
//   if VTM1.Samples[i] <> nil then
//    begin
//     New(VTM2.Samples[i]);
//     VTM2.Samples[i]^ := VTM1.Samples[i]^;
//    end;
// end;
	}

	int pos,j;

	pos=0;

	while((pos<256) && (buffer[pos+0xc9]!=255)) {

		j = buffer[pos + 0xc9] / 3;

		// if newer j=TS-j-1?
		printf("Positions[%d]=%d\n",pos,j);
		pos++;
#if 0

		if VTM2 <> nil then {
			DecodePattern(VTM2,j,j);
			DecodePattern(VTM1,j,TS - j - 1);
			for i := 0 to MaxPatLen - 1 do {
				tset := False;
				for k := 2 downto 0 do
				if VTM2.Patterns[j].Items[i].Channel[k].Additional_Command.Number = 11 then {
					for kk := 2 downto 0 do
					if VTM1.Patterns[j].Items[i].Channel[kk].Additional_Command.Number in [0,11] then {
						VTM1.Patterns[j].Items[i].Channel[kk].Additional_Command :=
						VTM2.Patterns[j].Items[i].Channel[k].Additional_Command;
						break;
					};
					tset := True;
					break;
				};
				if not tset then for k := 2 downto 0 do
				if VTM1.Patterns[j].Items[i].Channel[k].Additional_Command.Number = 11 then {
					for kk := 2 downto 0 do
					if VTM2.Patterns[j].Items[i].Channel[kk].Additional_Command.Number = 0 then {
						VTM2.Patterns[j].Items[i].Channel[kk].Additional_Command :=
						VTM1.Patterns[j].Items[i].Channel[k].Additional_Command;
						break;
					};
					break;
				};
			}
		}
		else {
#endif
   			DecodePattern(j,j);
#if 0
		}
#endif
	}
//	VTM1.Positions.Length := Pos;
//	if VTM2 <> nil then VTM2.Positions.Length := Pos;

	return 0;
}
