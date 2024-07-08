;; Basic script-fu template.
;; 
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License.

(define (script-fu-roto img drawable)
    (gimp-image-undo-group-start img)
    (gimp-context-push)

    ;; Do stuff here

    (gimp-image-scale img 280 201)
    (gimp-image-crop img 280 192 0 0)
    (gimp-image-grid-set-spacing img 7 4)
    (gimp-image-grid-set-foreground-color img '(54 5 5))

	(gimp-floating-sel-anchor
		(car (gimp-edit-paste drawable TRUE)))

    ; create a new image:
 
	; car returns first item of list

;        (theImage (car
 ;                   (gimp-image-new
  ;                               280
   ;                              192
    ;                             RGB
     ;                           )
      ;                     )
;	)

	;create a new layer for the image:
;        (theLayer
 ;       	(car
  ;              	(gimp-layer-new
   ;                     	img
    ;                       	280
     ;                      	192
      ;                     	RGB-IMAGE
       ;                    	"layer 1"
        ;                   	100
         ;                 	LAYER-MODE-NORMAL
	;		)
	;	)
;	)
  
 ;   (gimp-image-insert-layer img theLayer 0 0)

    (gimp-context-pop)
    (gimp-image-undo-group-end img)
    (gimp-displays-flush)
)

(script-fu-register "script-fu-roto"
                    _"<Image>/Filters/Generic/vmw-roto"
                    _"rotoscoping"
                    "Vince Weaver"
                    "Copyright Owner"
                    "2024"
                    "*"    ; type of image, e.g. "RGB*", or "" for Xtns
                    ; List all parameters here, starting with
                    ; image and drawable if this script takes them:
                    SF-IMAGE       "Image"              0
                    SF-DRAWABLE    "Drawable"           0
)
