; contains extra data that goes into $A000 that will get over-written
; this frees up some room at start

title_hgr:
	.incbin "graphics/ms_title.hgr.zx02"

logo1_main:
	.incbin "graphics/logo_grafA.bin.zx02"

ms_audio:
	.incbin "sound/ms.btc.zx02"
