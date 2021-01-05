.align $100

;==================================
; First $D000 page, 4k of room, room for 16
;		we dupe 5 of them as we don't have enough
;		that only occur in 1st half

;mah03:
.incbin "music/mock.ah.03"
;mbl02:
.incbin "music/mock.bl.02"
;mbl07:
.incbin "music/mock.bl.07"
;mbh07:
.incbin "music/mock.bh.07"
;mcl03:
.incbin "music/mock.cl.03"
;mch03:
.incbin "music/mock.ch.03"
;mnl03:
.incbin "music/mock.nl.03"
;mnh01:
.incbin "music/mock.nh.01"
;mnh02:
.incbin "music/mock.nh.02"
;mnh03:
.incbin "music/mock.nh.03"
;mnh07:
.incbin "music/mock.nh.07"
;==============5 dupes follow
mbh22:
.incbin "music/mock.bh.22"
mbh23:
.incbin "music/mock.bh.23"
mbl22:
.incbin "music/mock.bl.22"
mbl23:
.incbin "music/mock.bl.23"
mah11:
.incbin "music/mock.ah.11"





;================================
; 32 values to Load at $E000
;mbh01:
.incbin "music/mock.bh.01"
;mbh04:
.incbin "music/mock.bh.04"
;mbh05:
.incbin "music/mock.bh.05"
;mbh08:
.incbin "music/mock.bh.08"
;mbh10:
.incbin "music/mock.bh.10"
;mbh11:
.incbin "music/mock.bh.11"
;mcl04:
.incbin "music/mock.cl.04"
;mcl05:
.incbin "music/mock.cl.05"
;mcl07:
.incbin "music/mock.cl.07"
;mcl08:
.incbin "music/mock.cl.08"
;mcl09:
.incbin "music/mock.cl.09"
;mcl10:
.incbin "music/mock.cl.10"
;mcl11:
.incbin "music/mock.cl.11"




;mch04:
.incbin "music/mock.ch.04"
;mch05:
.incbin "music/mock.ch.05"
;mch07:
.incbin "music/mock.ch.07"
;mch08:
.incbin "music/mock.ch.08"
;mch09:
.incbin "music/mock.ch.09"
;mch10:
.incbin "music/mock.ch.10"
;mch11:
.incbin "music/mock.ch.11"



;7
;mnl04:
.incbin "music/mock.nl.04"
;mnl05:
.incbin "music/mock.nl.05"
;mnl07:
.incbin "music/mock.nl.07"
;mnl10:
.incbin "music/mock.nl.10"
;mnl11:
.incbin "music/mock.nl.11"



; 13
;mnh00:
.incbin "music/mock.nh.00"
;mnh04:
.incbin "music/mock.nh.04"
;mnh05:
.incbin "music/mock.nh.05"
;mnh08:
.incbin "music/mock.nh.08"
;mnh09:
.incbin "music/mock.nh.09"
;mnh10:
.incbin "music/mock.nh.10"
;mnh11:
.incbin "music/mock.nh.11"
