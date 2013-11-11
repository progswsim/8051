	ORG	000H		;WSKAZANIE ZE /LJMP POCZATEK/ JEST NA POCZATKU PAMIECI
	
	LJMP	POCZATEK
  
	ORG	00BH		;OBSLUGA PRZERWANIA TR0
	
	MOV	TH0,#0xFE
	MOV	TL0,#0xFF
	DEC	A
	RETI
	
	ORG	100H		;ADRES W PAMIECI OD KTOREGO ZACZYNA SIE NASZ PROGRAM
	
POCZATEK:
	MOV	TMOD,#0x01	;INCJACJA TIMERA 8+8,
	MOV	TH0,#0xFE	;USTAWIENIE WARTOSCI OD KTOREJ ZLICZA TIMER
	MOV	TL0,#0xFF	;USTAWIENIE WARTOSCI OD KTOREJ ZLICZA TIMER
	SETB	TR0		;WLACZENIE OBSLUGI PRZERWAN
	SETB	EA
	SETB	ET0
	MOV	A,#0x01		;POCZATKOWE USTAWIENIE AKUMULATORA
	 
START:

;JEDEN
	SETB	P3.3
	MOV	P1,#0xE7
	LCALL	WAIT
	
;DWA
	MOV	P1,#0x93
	CLR	P3.3
	LCALL	WAIT
	
;TRZY
	MOV	P1,#0xC3
	CLR	P3.3
	LCALL	WAIT
	
	LJMP	START	
	
WAIT:
	JNB	P3.2, STOP
	JNZ	WAIT
	MOV	A,#0x01
	RET	
	
STOP:
	LJMP	STOP
	END 
