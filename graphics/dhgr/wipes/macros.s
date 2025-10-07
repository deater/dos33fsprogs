;license:MIT
;(c) 2019-2022 by 4am
;

;!ifndef _FX_MACROS_ {
.ifndef _FX_MACROS_
;         !source "src/macros.a"
	.include "main_macros.s"
;         !source "src/fx/macros.hgr.a"
	.include "macros.hgr.s"
;         !source "src/fx/macros.dhgr.a"
;         !source "src/fx/macros.shr.a"
;         !source "src/fx/macros.copybit.a"
	.include "macros.copybit.s"
;         !source "src/fx/macros.misc.a"
	.include "macros.misc.s"

_FX_MACROS_=*
.endif

;_FX_MACROS_=*
;}
