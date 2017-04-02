;#######################################################################################################################
;	AUTOMATIC PLANT IRRIGATOR
;#######################################################################################################################

 INCLUDE REG_51.PDF


	SEN1  EQU  P3.0		; TO FIND WET OR DRY	WET=1	DRY=0
	SEN2  EQU  P3.1
	SEN3  EQU  P3.2
	SEN4  EQU  P3.3

	LOAD  EQU  P1.6		; MOTOR
	
	L11		EQU	P1.0
	LOAD1		EQU	P1.4
	L12		EQU	P1.2

ORG 0000H

	MOV R0,#00H
	MOV R1,#00H



; *******************************************************************
; 		THE MAIN PROGRAM STARTS HERE
; *******************************************************************	
MAIN:
	SETB SEN1
	JB SEN1,D1
	JMP W1

D1:	INC R0
W1:	SETB SEN2
	JB SEN2,D2
	JMP W2

D2:	INC R0
W2:	SETB SEN3
	JB SEN3,D3
	JMP W3

D3:	INC R0
W3:	SETB SEN4
	JB SEN4,D4
	JMP W4

D4:	INC R0
W4:
	

	CJNE R0,#00H,L1		; WET=4		DRY=0		(ALL SENSORS ARE WET)
	SETB LOAD		; OFF LOAD
	CLR LOAD1
	CLR L11
	SETB L12
	MOV R1,#00H
	JMP LAST

L1:	CJNE R0,#01H,L2		; WET=3	 DRY=1  
    
	    CJNE R1,#00H,M1
	    SETB LOAD 		; OFF LOAD	    
	    CLR LOAD1
	    JMP LAST

	M1: CLR  LOAD		; ON LOAD
		CLR L12
		SETB L11
		SETB LOAD1
	    JMP LAST		

L2:	CJNE R0,#02H,L3		; WET=2		DRY=2
	CLR LOAD		; ON LOAD
	SETB LOAD1
	CLR L12
		SETB L11
	MOV R1,#01H
	JMP LAST


L3:	CJNE R0,#03H,L4		; WET=1		DRY=3
	CLR LOAD		; ON LOAD	
	SETB LOAD1
	CLR L12
		SETB L11
	MOV R1,#01H
	JMP LAST


L4:	CJNE R0,#04H,LAST	; WET=0		DRY=4		(ALL SENSORS ARE DRY)
	CLR LOAD		; ON LOAD
	SETB LOAD1
	CLR L12
		SETB L11
	MOV R1,#01H
	JMP LAST

	
LAST:	MOV R0,#00H	

	

	JMP MAIN
; *******************************************************************

	

END
 
