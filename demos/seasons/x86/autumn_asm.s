
	.globl _start

_start:
#	mov	$0x4f02,%ax		# set super VGA mode
#	mov	$0x107,%bx		# 1280x1024, 256 colors
#	int	$0x10			# set the mode

	mov	$0x04f,%ax

l108:	shl	%ax
	push   %cx
	sub    %dx,%cx
	sar    %cx
	pop    %di
	add    %di,%dx
	sar    %dx
	rcr    %ebp
	jb     l11f
	inc    %ax
	add    $0x3,%ch
	neg    %dx
l11f:	aam    $0x29
	and    $0xfc,%al
	xor    $0x12,%al
	test   $0x80,%dh
	jne    l108
	test   $0xf0,%ch
	jne    l108
put_pixel:
	push   %ax
	and    $0xf,%al		# al = color
	mov    $0xc,%ah		# ah = 0xc = putpixel
#	int    $0x10		# bh=page number, cx=x,dx=y
	pop    %ax
check_keyboard:
	mov    $0x1,%ah
#	int    $0x16
#	je     0x108
#	ret
	jmp	l108
