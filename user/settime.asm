
		.include 'user.inc'

; set the time time

		lds #USERSTACKEND

		lda #0x11
		leax spibuffer,pcr
clear:		clr ,x+
		deca
		bne clear

		leay spibuffer,pcr
		lda #0x80		; msb set for writes
		sta ,y

		leax promptmsg,pcr
		jsr jioputstr

		leax hourmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 3,y

		leax minmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 2,y

		leax secmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 1,y

		leax daymsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 5,y

		leax monthmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 6,y

		leax yearmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 7,y

		leax dayofweekmsg,pcr
		jsr jioputstr
		jsr jiogetbyte
		sta 4,y

		lda #0xfe
		jsr jspistart		; mark with start

		leax spibuffer,pcr
		ldy #0x11

		jsr jspiwriteblock	; write address 0

		jsr jspistop		; mark with stop

		swi			; back to monitor

; variables

spibuffer:	.rmb 0x11

; messages

promptmsg:	.asciz 'Enter the time and date:\r\n\r\n'
hourmsg:	.asciz 'Hour? (00-23) '
minmsg:		.asciz 'Minute? (00-59) '
secmsg:		.asciz 'Second? (00-59) '
daymsg:		.asciz 'Day? (01-31) '
monthmsg:	.asciz 'Month? (01-12) '
yearmsg:	.asciz 'Year? (00-99) '
dayofweekmsg:	.asciz 'Day number? (01=Sun-07=Sat) '
