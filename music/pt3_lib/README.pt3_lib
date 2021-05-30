The PT3_player Library	version 0.3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	by Vince "Deater" Weaver <vince@deater.net>
	http://www.deater.net/weave/vmwprod/pt3_lib/

	Last Update: 30 May 2021

	Plays Vortex Tracker II .pt3 files on the Apple II

Background:
~~~~~~~~~~~

This code is meant as a relatively simple, reasonably optimized version
of the PT3 Vortex-Tracker player for use in other programs.

For some more background on this you can watch the talk I gave
at Demosplash 2019 on this topic.


What is a PT3 file?
~~~~~~~~~~~~~~~~~~~

A PT3 file is a tracker format with a compact file size used on systems
with AY-3-8910 based audio.  This is most commonly the ZX-spectrum
and Atari ST machines.

Originally most PT3 players were in z80 assembly language for use on Z80
based machines.  I have written code that will play the files on modern
systems (using C) and also the included code designed for the 6502-based
Apple II machines with Mockingboard sound cards installed.

You can find many pt3 files on the internet, or you can use the
VortexTracker tracker to write your own.


Using the Code (irq driven):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See the "pt3_test.s" example.

The code is in cc65 6502 assembly language but should be relatively 
easy to port to other assemblers.

To get a pt3 file playing:
	+ Optionally include "pt3_lib_mockingboard_detect.s" and
		call "mockingboard_detect" and "mockingboard_patch" if
		you want to auto-detect which slot the mockingboard is in.
		Otherwise it will default to Slot#4
		The patch code does a vaguely unsafe find/replace of $C4
		live patch of the slot values, if you want a safer (but much
		larger) version you can go into the file and ifdef out
		the right code.
	+ Be sure to either include the pt3 file as a binary, or load
		it from disk to a buffer pointed to by PT3_LOC.
		Not the beginning of the song needs to be aligned on
		a page boundary (this makes the decode code a bit
		more simple)
	+ If you want to make the code more compact but use a lot of
		the zero page, you can set PT3_USE_ZERO_PAGE in
		"pt3_lib_core.s"  This will use zp $80-$FF
		but make the pt3 code a bit faster/smaller
	+ You can set the interrupt speed in pt3_lib_mockingboard_setup.s
		Generally files you find online are 50Hz.
		For less overhead you can set something like 25Hz but
		in that case you'll want to adjust the speed in the
		tracker otherwise the songs will play at the wrong speed.
	+ Vortex tracker by default assumes a system with a 1.77MHz
		clock and sets frequencies accordingly.  The Mockingboard
		runs at 1MHz, so the pt3_lib converts on the fly.
		For less overhead you can have the tracker generate
		1MHz music and strip out the 1.77MHz conversion code.
	+ If you want the music to Loop then set the LOOP value to 1.
	

Notes on Using on a IIc
~~~~~~~~~~~~~~~~~~~~~~~
I usually test this code mostly on a II+ and IIe.

Version 0.3 adds support for the IIc as well (having Mockingboards in a
IIc was rare due to the lack of expansion port, but you can get mockingboard
compatible cards that plug into the CPU socket)

This does involve adding some Apple II model detection code to the pt3 player
which does increase the size a bit.

Things that are different on IIc:
	+ For the board to get detected you have to touch the slot4
		registers for some reason
	+ IRQ support is much more complex on the IIc.  We support things
		by switching out the default ROM IRQ handler with
		language-card RAM and place our own handler where the
		stock handler would be.

		This does mean if you use ROM routines they will break,
		so the code also copies the $D000-$F000 ROM into the
		language card too.  If your code doesn't use ROM routines
		you can skip this.  The ROM copy hack uses $400 (text page 1)
		as a temporary buffer for the copy, feel free to use something
		else if that's a problem.

		Finally we patch out loading the A register from $45 at
		the end of the IRQ handler.
		Older Apple IIs needed to do this, but on a IIc this
		will break things.


Notes on Using on a IIgs
~~~~~~~~~~~~~~~~~~~~~~~~
I have not tested this on a IIgs with Mockingboard, I'm guessing it probably
doesn't work.


Cycle-counted version (not finished):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I started work on a cycle-counted (deterministic cycle count) pt3
decoder, but it turned out to be large and complex enough to not be
worth the trouble.

You can still use pt3 files in cycle-counted demos.  See the
../demosplash2019/ directory for an example.  What this code does
is decode the pt3 files to memory during non-cycle-counted times,
and then use a deterministic playback function to play back this music.
Each frame of music decodes to 11bytes of register info, which means
at 60Hz you can get roughly 4s of music per 3kB of RAM.


Overhead:
~~~~~~~~~

It depends exactly on what features you use, but in general it will use
around 3KB of RAM plus the size of the PT3 file (which is often a few K).
Playback overhead depends on the complexity of the sound file but is typically
in the 10% to 15% range when playing back at 50Hz.

The player also uses 26 zero-page locations.  More compact/faster code
can be generated if you're willing to sacrifice 128+ zero page locations.



