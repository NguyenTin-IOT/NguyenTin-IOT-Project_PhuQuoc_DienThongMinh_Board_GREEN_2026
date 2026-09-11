_xuat_32bit:
;init.c,2 :: 		void xuat_32bit(unsigned long data_dich){
MOV	R1, R0
; data_dich start address is: 4 (R1)
;init.c,3 :: 		unsigned char vt_dich=32;
MOVS	R0, #32
;init.c,4 :: 		unsigned long shift_data=data_dich;
; shift_data start address is: 12 (R3)
MOV	R3, R1
; data_dich end address is: 4 (R1)
;init.c,5 :: 		OE=1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
; shift_data end address is: 12 (R3)
UXTB	R1, R0
MOV	R0, R3
;init.c,6 :: 		do{
IT	AL
BAL	L_xuat_32bit0
L__xuat_32bit424:
;init.c,10 :: 		}while(vt_dich>0);
UXTB	R1, R4
;init.c,6 :: 		do{
L_xuat_32bit0:
;init.c,7 :: 		vt_dich--;
; vt_dich start address is: 16 (R4)
; vt_dich start address is: 4 (R1)
SUBS	R3, R1, #1
UXTB	R3, R3
; vt_dich end address is: 4 (R1)
; vt_dich start address is: 16 (R4)
UXTB	R4, R3
; vt_dich end address is: 16 (R4)
;init.c,8 :: 		DS=(shift_data>>vt_dich);
LSR	R2, R0, R3
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,9 :: 		xung_dich
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
;init.c,10 :: 		}while(vt_dich>0);
CMP	R3, #0
IT	HI
BHI	L__xuat_32bit424
; vt_dich end address is: 16 (R4)
;init.c,11 :: 		OE=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,12 :: 		xung_xuat
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,13 :: 		}
L_end_xuat_32bit:
BX	LR
; end of _xuat_32bit
_timer1_init:
;init.c,15 :: 		void timer1_init(){ //20 ms
;init.c,16 :: 		TIM1_CR1bits.DIR_=0;  // directon 0:upcounter, 1: down
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,17 :: 		TIM1_CR1bits.ARPE=0; // auto-reload Preload Enable
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,18 :: 		TIM1_CR1bits.OPM=0;     // one pulse mode / 0: counter non-stop; 1: stop when CEN bit clear
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,19 :: 		TIM1_PSC=10000;  // PRESCALE VALUE(16bit)  frequency = Fclk/(PSC+1)
MOVW	R1, #10000
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;init.c,20 :: 		TIM1_ARR=144;    // AUTO-RELOAD VALUE
MOVS	R1, #144
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;init.c,23 :: 		TIM1_CNT=0;      // counter value
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CNT+0)
MOVT	R0, #hi_addr(TIM1_CNT+0)
STR	R1, [R0, #0]
;init.c,24 :: 		TIM1_DIERbits.UIE=1;  // DMA interrup enable Register  - UIE: update interrup enable
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(TIM1_DIERbits+0)
MOVT	R0, #hi_addr(TIM1_DIERbits+0)
STR	R3, [R0, #0]
;init.c,25 :: 		NVIC_SETENA0bits.SETENA25=1;
MOVW	R1, #lo_addr(NVIC_SETENA0bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA0bits+0)
LDR	R0, [R1, #0]
BFI	R0, R3, #25, #1
STR	R0, [R1, #0]
;init.c,26 :: 		NVIC_IP6bits.PRI_25=0x00;
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP6bits+0)
MOVT	R1, #hi_addr(NVIC_IP6bits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #8
STRH	R0, [R1, #0]
;init.c,27 :: 		TIM1_CR1bits.CEN=1;    //1 enable counter
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R3, [R0, #0]
;init.c,28 :: 		NVIC_IP8bits.PRI_32=0xf0; // priority
MOVS	R2, #240
MOVW	R1, #lo_addr(NVIC_IP8bits+0)
MOVT	R1, #hi_addr(NVIC_IP8bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,29 :: 		}
L_end_timer1_init:
BX	LR
; end of _timer1_init
_usart1_init:
;init.c,31 :: 		void usart1_init(){
;init.c,32 :: 		USART1_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,33 :: 		USART1_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,34 :: 		USART1_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,35 :: 		USART1_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,36 :: 		USART1_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,37 :: 		USART1_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,38 :: 		USART1_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;init.c,39 :: 		USART1_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;init.c,40 :: 		USART1_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;init.c,42 :: 		NVIC_SETENA1bits.SETENA37=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #5, #1
STR	R0, [R1, #0]
;init.c,43 :: 		NVIC_IP11bits.PRI_44=0x10; // priority
MOVS	R2, #16
MOVW	R1, #lo_addr(NVIC_IP11bits+0)
MOVT	R1, #hi_addr(NVIC_IP11bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,44 :: 		}
L_end_usart1_init:
BX	LR
; end of _usart1_init
_uart1_chr:
;init.c,46 :: 		void uart1_chr(unsigned char data_usart1_tx){
;init.c,47 :: 		while(USART1_SRbits.TC==0);
L_uart1_chr3:
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart1_chr4
IT	AL
BAL	L_uart1_chr3
L_uart1_chr4:
;init.c,48 :: 		USART1_DRbits.DR=data_usart1_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(USART1_DRbits+0)
MOVT	R2, #hi_addr(USART1_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,49 :: 		}
L_end_uart1_chr:
BX	LR
; end of _uart1_chr
_uart1_string:
;init.c,50 :: 		void uart1_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,51 :: 		while(*s){
L_uart1_string5:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart1_string6
;init.c,52 :: 		uart1_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart1_chr+0
ADDS	R4, R4, #1
;init.c,53 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart1_string5
L_uart1_string6:
;init.c,54 :: 		}
L_end_uart1_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart1_string
_uart4__init:
;init.c,56 :: 		void uart4__init(){
;init.c,58 :: 		UART4_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,59 :: 		UART4_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,60 :: 		UART4_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,61 :: 		UART4_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,62 :: 		UART4_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,63 :: 		UART4_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,66 :: 		UART4_BRR=0X0271;   // bauld=115200
MOVW	R1, #625
MOVW	R0, #lo_addr(UART4_BRR+0)
MOVT	R0, #hi_addr(UART4_BRR+0)
STR	R1, [R0, #0]
;init.c,67 :: 		UART4_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR2+0)
MOVT	R0, #hi_addr(UART4_CR2+0)
STR	R1, [R0, #0]
;init.c,68 :: 		UART4_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR3+0)
MOVT	R0, #hi_addr(UART4_CR3+0)
STR	R1, [R0, #0]
;init.c,70 :: 		NVIC_SETENA1bits.SETENA52=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #1
STR	R0, [R1, #0]
;init.c,71 :: 		NVIC_IP14bits.PRI_59=0x00; // priority
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP14bits+0)
MOVT	R1, #hi_addr(NVIC_IP14bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #24, #8
STR	R0, [R1, #0]
;init.c,72 :: 		}
L_end_uart4__init:
BX	LR
; end of _uart4__init
_uart4_chr:
;init.c,74 :: 		void uart4_chr(unsigned char data_usart4_tx){
;init.c,75 :: 		while(UART4_SRbits.TC==0);
L_uart4_chr7:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart4_chr8
IT	AL
BAL	L_uart4_chr7
L_uart4_chr8:
;init.c,76 :: 		UART4_DRbits.DR=data_usart4_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,77 :: 		}
L_end_uart4_chr:
BX	LR
; end of _uart4_chr
_rs485_u4:
;init.c,79 :: 		void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
; count_buf start address is: 4 (R1)
; count_buf end address is: 4 (R1)
; count_buf start address is: 4 (R1)
;init.c,80 :: 		unsigned char i = 0;
;init.c,81 :: 		UART4_CR1bits.RE=0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,82 :: 		TRAN_4
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,83 :: 		for (i = 0; i < count_buf; i++) {
; i start address is: 20 (R5)
MOVS	R5, #0
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
L_rs485_u49:
; i start address is: 20 (R5)
; count_buf start address is: 4 (R1)
CMP	R5, R1
IT	CS
BCS	L_rs485_u410
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
;init.c,84 :: 		while(UART4_SRbits.TC==0);
L_rs485_u412:
; count_buf start address is: 4 (R1)
; i start address is: 20 (R5)
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u413
IT	AL
BAL	L_rs485_u412
L_rs485_u413:
;init.c,85 :: 		UART4_DRbits.DR = buf_rs4[i];
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
UXTB	R4, R2
MOVW	R3, #lo_addr(UART4_DRbits+0)
MOVT	R3, #hi_addr(UART4_DRbits+0)
LDRH	R2, [R3, #0]
BFI	R2, R4, #0, #9
STRH	R2, [R3, #0]
;init.c,83 :: 		for (i = 0; i < count_buf; i++) {
ADDS	R5, R5, #1
UXTB	R5, R5
;init.c,87 :: 		}
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
IT	AL
BAL	L_rs485_u49
L_rs485_u410:
;init.c,88 :: 		while(UART4_SRbits.TC==0);
L_rs485_u414:
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u415
IT	AL
BAL	L_rs485_u414
L_rs485_u415:
;init.c,89 :: 		REC_4
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,90 :: 		UART4_CR1bits.RE=1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,91 :: 		}
L_end_rs485_u4:
BX	LR
; end of _rs485_u4
_uart4_string:
;init.c,93 :: 		void uart4_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,94 :: 		while(*s){
L_uart4_string16:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart4_string17
;init.c,95 :: 		uart4_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart4_chr+0
ADDS	R4, R4, #1
;init.c,96 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart4_string16
L_uart4_string17:
;init.c,97 :: 		}
L_end_uart4_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart4_string
_usart2_init:
;init.c,99 :: 		void usart2_init(){
;init.c,100 :: 		USART2_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,101 :: 		USART2_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART2_BRR+0)
MOVT	R0, #hi_addr(USART2_BRR+0)
STR	R1, [R0, #0]
;init.c,102 :: 		USART2_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,103 :: 		USART2_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,104 :: 		USART2_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,105 :: 		USART2_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,106 :: 		USART2_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,107 :: 		USART2_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR2+0)
MOVT	R0, #hi_addr(USART2_CR2+0)
STR	R1, [R0, #0]
;init.c,108 :: 		USART2_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR3+0)
MOVT	R0, #hi_addr(USART2_CR3+0)
STR	R1, [R0, #0]
;init.c,112 :: 		}
L_end_usart2_init:
BX	LR
; end of _usart2_init
_uart2_chr:
;init.c,114 :: 		void uart2_chr(unsigned char data_usart2_tx){
;init.c,115 :: 		while(USART2_SRbits.TC==0);
L_uart2_chr18:
MOVW	R2, #lo_addr(USART2_SRbits+0)
MOVT	R2, #hi_addr(USART2_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart2_chr19
IT	AL
BAL	L_uart2_chr18
L_uart2_chr19:
;init.c,116 :: 		USART2_DR=data_usart2_tx;
MOVW	R1, #lo_addr(USART2_DR+0)
MOVT	R1, #hi_addr(USART2_DR+0)
STR	R0, [R1, #0]
;init.c,117 :: 		}
L_end_uart2_chr:
BX	LR
; end of _uart2_chr
_uart2_string:
;init.c,118 :: 		void uart2_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R3, R0
;init.c,119 :: 		while(*s){
L_uart2_string20:
; s start address is: 12 (R3)
LDRB	R1, [R3, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart2_string21
;init.c,120 :: 		uart2_chr(*s++);
LDRB	R1, [R3, #0]
UXTB	R0, R1
BL	_uart2_chr+0
ADDS	R3, R3, #1
;init.c,121 :: 		}
; s end address is: 12 (R3)
IT	AL
BAL	L_uart2_string20
L_uart2_string21:
;init.c,122 :: 		}
L_end_uart2_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart2_string
_set_value_dim:
;init.c,124 :: 		void set_value_dim(unsigned char value_dim,unsigned char channel){
; channel start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; channel end address is: 4 (R1)
; channel start address is: 4 (R1)
;init.c,125 :: 		unsigned char data_dim[3]={0xfa,0x00,0x00},k;
MOVS	R2, #250
STRB	R2, [SP, #4]
MOVS	R2, #0
STRB	R2, [SP, #5]
MOVS	R2, #0
STRB	R2, [SP, #6]
;init.c,126 :: 		data_dim[1]=channel;
ADD	R3, SP, #4
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; channel end address is: 4 (R1)
;init.c,127 :: 		data_dim[2]=value_dim;
ADDS	R2, R3, #2
STRB	R0, [R2, #0]
;init.c,128 :: 		for(k=0;k<3;k++){
; k start address is: 12 (R3)
MOVS	R3, #0
; k end address is: 12 (R3)
L_set_value_dim22:
; k start address is: 12 (R3)
CMP	R3, #3
IT	CS
BCS	L_set_value_dim23
;init.c,129 :: 		uart2_chr(data_dim[k]);
ADD	R2, SP, #4
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
UXTB	R0, R2
BL	_uart2_chr+0
;init.c,128 :: 		for(k=0;k<3;k++){
ADDS	R3, R3, #1
UXTB	R3, R3
;init.c,130 :: 		}
; k end address is: 12 (R3)
IT	AL
BAL	L_set_value_dim22
L_set_value_dim23:
;init.c,131 :: 		}
L_end_set_value_dim:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_value_dim
_gpio_init:
;init.c,133 :: 		void gpio_init(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init.c,134 :: 		RCC_APB2ENR=(1<<AFIOEN)|(1<<IOPAEN)|(1<<IOPBEN)|(1<<IOPCEN)|(1<<IOPDEN)|(1<<IOPEEN)|(1<<TIM1EN)|(1<<SPI1EN)|(1<<USART1EN);
MOVW	R1, #22653
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;init.c,135 :: 		RCC_APB1ENR=(1<<UART4EN)|(1<<USART2EN);
MOV	R1, #655360
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;init.c,137 :: 		AFIO_MAPR|=0x02000000;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #33554432
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;init.c,139 :: 		GPIOA_CRL&=0xffff0000;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #65535
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,140 :: 		GPIOA_CRL|=0x00004938;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #18744
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,141 :: 		GPIOA_CRH&=0x0ff00000;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #267386880
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,142 :: 		GPIOA_CRH|=0x30003490;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #13456
MOVT	R0, #12288
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,143 :: 		GPIOA_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,144 :: 		GPIOA_ODR|=0B0000000000000001;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,146 :: 		GPIOB_CRL&=0x00fff000;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #61440
MOVT	R0, #255
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,147 :: 		GPIOB_CRL|=0x38000383;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #899
MOVT	R0, #14336
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,148 :: 		GPIOB_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,149 :: 		GPIOB_CRH|=0x83838338;
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #33592
MOVT	R0, #33667
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,150 :: 		GPIOB_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,151 :: 		GPIOB_ODR|=0B1010100101000010;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43330
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,153 :: 		GPIOC_CRL&=0x000f0000;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #983040
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,154 :: 		GPIOC_CRL|=0x83803838;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #33664
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,155 :: 		GPIOC_CRH&=0xff0000f0;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #240
MOVT	R0, #65280
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,156 :: 		GPIOC_CRH|=0x00234903;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #18691
MOVT	R0, #35
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,157 :: 		GPIOC_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,158 :: 		GPIOC_ODR|=0B0000000010100101;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #165
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,160 :: 		GPIOD_CRL&=0xff000000;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-16777216
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,161 :: 		GPIOD_CRL|=0x00833333;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #13107
MOVT	R0, #131
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,162 :: 		GPIOD_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,163 :: 		GPIOD_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,164 :: 		GPIOD_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,165 :: 		GPIOD_ODR|=0B1010101000100000;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43552
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,167 :: 		GPIOE_CRL=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,168 :: 		GPIOE_CRL|=0x88383838;
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #34872
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,169 :: 		GPIOE_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,170 :: 		GPIOE_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,171 :: 		GPIOE_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,172 :: 		GPIOE_ODR|=0B1010101011010101;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43733
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,173 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_7);
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;init.c,174 :: 		}
L_end_gpio_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _gpio_init
_chuoi_so:
;init.c,175 :: 		unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt){
; vt_kt start address is: 8 (R2)
; vt_bd start address is: 4 (R1)
UXTB	R3, R2
; vt_kt end address is: 8 (R2)
; vt_bd end address is: 4 (R1)
; vt_bd start address is: 4 (R1)
; vt_kt start address is: 12 (R3)
;init.c,178 :: 		gt_so=0;
; gt_so start address is: 20 (R5)
MOVS	R5, #0
;init.c,179 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
; sb start address is: 8 (R2)
UXTB	R2, R1
; vt_bd end address is: 4 (R1)
; vt_kt end address is: 12 (R3)
; gt_so end address is: 20 (R5)
; sb end address is: 8 (R2)
MOV	R1, R0
UXTB	R0, R3
L_chuoi_so25:
; sb start address is: 8 (R2)
; so start address is: 4 (R1)
; gt_so start address is: 20 (R5)
; so start address is: 4 (R1)
; so end address is: 4 (R1)
CMP	R2, R0
IT	HI
BHI	L_chuoi_so26
; so end address is: 4 (R1)
;init.c,180 :: 		gt_so*=10;
; so start address is: 4 (R1)
MOVS	R3, #10
MUL	R4, R5, R3
; gt_so end address is: 20 (R5)
;init.c,181 :: 		gt_so+=(*(so+sb)-0x30);
ADDS	R3, R1, R2
LDRB	R3, [R3, #0]
SUBS	R3, #48
SXTH	R3, R3
ADDS	R3, R4, R3
; gt_so start address is: 20 (R5)
MOV	R5, R3
;init.c,179 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
ADDS	R2, R2, #1
UXTB	R2, R2
;init.c,182 :: 		}
; so end address is: 4 (R1)
; sb end address is: 8 (R2)
IT	AL
BAL	L_chuoi_so25
L_chuoi_so26:
;init.c,183 :: 		return gt_so;
MOV	R0, R5
; gt_so end address is: 20 (R5)
;init.c,184 :: 		}
L_end_chuoi_so:
BX	LR
; end of _chuoi_so
_get_point:
;init.c,185 :: 		unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end){
; end start address is: 8 (R2)
; start start address is: 4 (R1)
UXTB	R3, R2
UXTB	R2, R1
; end end address is: 8 (R2)
; start end address is: 4 (R1)
; start start address is: 8 (R2)
; end start address is: 12 (R3)
;init.c,186 :: 		unsigned char locate_point=0;
;init.c,187 :: 		for(locate_point=start;locate_point<end;locate_point++){
; locate_point start address is: 4 (R1)
UXTB	R1, R2
; end end address is: 12 (R3)
; locate_point end address is: 4 (R1)
MOV	R4, R0
UXTB	R0, R3
L_get_point28:
; locate_point start address is: 4 (R1)
; start start address is: 8 (R2)
; start end address is: 8 (R2)
; s start address is: 16 (R4)
CMP	R1, R0
IT	CS
BCS	L_get_point29
; start end address is: 8 (R2)
;init.c,188 :: 		if((*(s+start)=='.')||(*(s+start)==' ')){
; start start address is: 8 (R2)
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #46
IT	EQ
BEQ	L__get_point427
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #32
IT	EQ
BEQ	L__get_point426
IT	AL
BAL	L_get_point33
; start end address is: 8 (R2)
; s end address is: 16 (R4)
L__get_point427:
L__get_point426:
;init.c,189 :: 		break;
IT	AL
BAL	L_get_point29
;init.c,190 :: 		}
L_get_point33:
;init.c,191 :: 		s++;
; s start address is: 16 (R4)
; start start address is: 8 (R2)
ADDS	R4, R4, #1
;init.c,187 :: 		for(locate_point=start;locate_point<end;locate_point++){
ADDS	R1, R1, #1
UXTB	R1, R1
;init.c,192 :: 		}
; start end address is: 8 (R2)
; s end address is: 16 (R4)
IT	AL
BAL	L_get_point28
L_get_point29:
;init.c,193 :: 		return locate_point;
UXTB	R0, R1
; locate_point end address is: 4 (R1)
;init.c,194 :: 		}
L_end_get_point:
BX	LR
; end of _get_point
_settingEthenet:
;botrungtam.c,113 :: 		void settingEthenet(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;botrungtam.c,114 :: 		ptr = (unsigned long*)Address;
MOVW	R2, #lo_addr(_Address+0)
MOVT	R2, #hi_addr(_Address+0)
LDR	R1, [R2, #0]
MOVW	R0, #lo_addr(_ptr+0)
MOVT	R0, #hi_addr(_ptr+0)
STR	R1, [R0, #0]
;botrungtam.c,115 :: 		i=*ptr;
MOV	R0, R2
LDR	R0, [R0, #0]
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STR	R1, [R0, #0]
;botrungtam.c,116 :: 		if(i==0xffffffff){    // khi moi nap frimware thi dia chi ip se la fffffff
CMP	R1, #-1
IT	NE
BNE	L_settingEthenet34
;botrungtam.c,117 :: 		FLASH_ErasePage(Address);
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
BL	_FLASH_ErasePage+0
;botrungtam.c,123 :: 		FLASH_Write_Word(Address,0xC0A80178);     // c0:a8:01:7c  = 192.168.1.124
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
MOVW	R1, #376
MOVT	R1, #49320
BL	_FLASH_Write_Word+0
;botrungtam.c,124 :: 		}
L_settingEthenet34:
;botrungtam.c,125 :: 		i=0xC0A8017A ;       // hop sua lai i= ma ko can flash address
MOVW	R0, #378
MOVT	R0, #49320
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
STR	R0, [R1, #0]
;botrungtam.c,126 :: 		myIpAddr[0]=i>>24;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #24
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
STRB	R0, [R4, #0]
;botrungtam.c,127 :: 		myIpAddr[1]=i>>16;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #16
MOVW	R3, #lo_addr(_myIpAddr+1)
MOVT	R3, #hi_addr(_myIpAddr+1)
STRB	R0, [R3, #0]
;botrungtam.c,128 :: 		myIpAddr[2]=i>>8;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
MOVW	R2, #lo_addr(_myIpAddr+2)
MOVT	R2, #hi_addr(_myIpAddr+2)
STRB	R0, [R2, #0]
;botrungtam.c,129 :: 		myIpAddr[3]=i;
MOVS	R1, #122
MOVW	R0, #lo_addr(_myIpAddr+3)
MOVT	R0, #hi_addr(_myIpAddr+3)
STRB	R1, [R0, #0]
;botrungtam.c,130 :: 		gwIpAddr[0]=myIpAddr[0];
MOV	R0, R4
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+0)
MOVT	R0, #hi_addr(_gwIpAddr+0)
STRB	R1, [R0, #0]
;botrungtam.c,131 :: 		gwIpAddr[1]=myIpAddr[1];
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+1)
MOVT	R0, #hi_addr(_gwIpAddr+1)
STRB	R1, [R0, #0]
;botrungtam.c,132 :: 		gwIpAddr[2]=myIpAddr[2];
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+2)
MOVT	R0, #hi_addr(_gwIpAddr+2)
STRB	R1, [R0, #0]
;botrungtam.c,133 :: 		gwIpAddr[3]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_gwIpAddr+3)
MOVT	R0, #hi_addr(_gwIpAddr+3)
STRB	R1, [R0, #0]
;botrungtam.c,134 :: 		SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
MOVS	R2, #1
MOVW	R1, #lo_addr(_myIpAddr+0)
MOVT	R1, #hi_addr(_myIpAddr+0)
MOVW	R0, #lo_addr(_myMacAddr+0)
MOVT	R0, #hi_addr(_myMacAddr+0)
BL	_SPI_Ethernet_Init+0
;botrungtam.c,135 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
MOVW	R2, #lo_addr(_dnsIpAddr+0)
MOVT	R2, #hi_addr(_dnsIpAddr+0)
MOVW	R1, #lo_addr(_gwIpAddr+0)
MOVT	R1, #hi_addr(_gwIpAddr+0)
MOVW	R0, #lo_addr(_ipMask+0)
MOVT	R0, #hi_addr(_ipMask+0)
BL	_SPI_Ethernet_confNetwork+0
;botrungtam.c,136 :: 		}
L_end_settingEthenet:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _settingEthenet
_putChar:
;botrungtam.c,137 :: 		void putChar(unsigned char c){
;botrungtam.c,138 :: 		while(UART4_SRbits.TC==0);
L_putChar35:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_putChar36
IT	AL
BAL	L_putChar35
L_putChar36:
;botrungtam.c,139 :: 		UART4_DRbits.DR = c;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;botrungtam.c,140 :: 		}
L_end_putChar:
BX	LR
; end of _putChar
_saveIP:
;botrungtam.c,141 :: 		void saveIP(unsigned char buf[]){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;botrungtam.c,143 :: 		unsigned char i=0,j,pos=0;
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
;botrungtam.c,144 :: 		while(i<39){
L_saveIP37:
; i start address is: 8 (R2)
CMP	R2, #39
IT	CS
BCS	L_saveIP38
;botrungtam.c,145 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
ADDS	R1, R0, R2
LDRB	R1, [R1, #0]
CMP	R1, #105
IT	NE
BNE	L__saveIP457
ADDS	R1, R2, #1
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #112
IT	NE
BNE	L__saveIP458
L__saveIP436:
;botrungtam.c,146 :: 		for(j=0;j<4;j++){
MOVS	R1, #0
STRB	R1, [SP, #12]
; i end address is: 8 (R2)
UXTB	R5, R2
L_saveIP42:
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
CMP	R1, #4
IT	CS
BCS	L_saveIP43
;botrungtam.c,147 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP440
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP439
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP438
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP437
IT	AL
BAL	L_saveIP49
L__saveIP438:
L__saveIP437:
L__saveIP434:
;botrungtam.c,148 :: 		ipAddress[j]=buf[i+4]-48;
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R2, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
STRB	R1, [R2, #0]
;botrungtam.c,149 :: 		i+=2;
ADDS	R1, R5, #2
UXTB	R5, R1
;botrungtam.c,150 :: 		}
IT	AL
BAL	L_saveIP50
L_saveIP49:
;botrungtam.c,147 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
L__saveIP440:
L__saveIP439:
;botrungtam.c,151 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP446
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP445
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP442
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP441
IT	AL
BAL	L_saveIP57
L__saveIP442:
L__saveIP441:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP444
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP443
IT	AL
BAL	L_saveIP57
L__saveIP444:
L__saveIP443:
L__saveIP431:
;botrungtam.c,152 :: 		ipAddress[j]=10*(buf[i+4]-48)+(buf[i+5]-48);
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R3, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
MULS	R2, R1, R2
SXTH	R2, R2
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
SXTH	R1, R1
ADDS	R1, R2, R1
STRB	R1, [R3, #0]
;botrungtam.c,153 :: 		i+=3;
ADDS	R1, R5, #3
; i end address is: 20 (R5)
; i start address is: 4 (R1)
UXTB	R1, R1
;botrungtam.c,154 :: 		}
UXTB	R5, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_saveIP58
L_saveIP57:
;botrungtam.c,151 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
; i start address is: 20 (R5)
L__saveIP446:
L__saveIP445:
;botrungtam.c,155 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP455
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP456
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP448
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP447
UXTB	R1, R5
IT	AL
BAL	L_saveIP65
L__saveIP448:
L__saveIP447:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP450
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP449
UXTB	R1, R5
IT	AL
BAL	L_saveIP65
L__saveIP450:
L__saveIP449:
L__saveIP428:
;botrungtam.c,156 :: 		ipAddress[j]=100*(buf[i+4]-48)+10*(buf[i+5]-48)+(buf[i+6]-48);
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R4, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #100
SXTH	R1, R1
MUL	R3, R1, R2
SXTH	R3, R3
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
ADDS	R2, R3, R1
SXTH	R2, R2
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
SXTH	R1, R1
ADDS	R1, R2, R1
STRB	R1, [R4, #0]
;botrungtam.c,157 :: 		i+=4;
ADDS	R1, R5, #4
; i end address is: 20 (R5)
; i start address is: 8 (R2)
UXTB	R2, R1
; i end address is: 8 (R2)
UXTB	R1, R2
;botrungtam.c,158 :: 		}
L_saveIP65:
;botrungtam.c,155 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP452
L__saveIP455:
UXTB	R1, R5
L__saveIP452:
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP451
L__saveIP456:
UXTB	R1, R5
L__saveIP451:
;botrungtam.c,158 :: 		}
; i start address is: 4 (R1)
UXTB	R5, R1
; i end address is: 4 (R1)
L_saveIP58:
; i start address is: 20 (R5)
; i end address is: 20 (R5)
L_saveIP50:
;botrungtam.c,146 :: 		for(j=0;j<4;j++){
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
ADDS	R1, R1, #1
STRB	R1, [SP, #12]
;botrungtam.c,159 :: 		}
IT	AL
BAL	L_saveIP42
L_saveIP43:
;botrungtam.c,160 :: 		FLASH_ErasePage(Address);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
BL	_FLASH_ErasePage+0
;botrungtam.c,161 :: 		ipword=(((unsigned long)ipAddress[0])<<24)|(((unsigned long)ipAddress[1])<<16)|(((unsigned long)ipAddress[2])<<8)|(((unsigned long)ipAddress[3]));
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #24
MOVW	R1, #lo_addr(_ipAddress+1)
MOVT	R1, #hi_addr(_ipAddress+1)
LDRB	R1, [R1, #0]
LSLS	R1, R1, #16
ORRS	R2, R1
MOVW	R1, #lo_addr(_ipAddress+2)
MOVT	R1, #hi_addr(_ipAddress+2)
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
ORRS	R2, R1
MOVW	R1, #lo_addr(_ipAddress+3)
MOVT	R1, #hi_addr(_ipAddress+3)
LDRB	R1, [R1, #0]
ORRS	R2, R1
;botrungtam.c,162 :: 		FLASH_Write_Word(Address,ipWord);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
MOV	R0, R1
MOV	R1, R2
BL	_FLASH_Write_Word+0
LDR	R0, [SP, #4]
;botrungtam.c,163 :: 		settingEthenet();
STRB	R5, [SP, #4]
; i end address is: 20 (R5)
STR	R0, [SP, #8]
BL	_settingEthenet+0
LDR	R0, [SP, #8]
LDRB	R5, [SP, #4]
MOV	R1, R0
UXTB	R0, R5
;botrungtam.c,145 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
IT	AL
BAL	L__saveIP454
L__saveIP457:
MOV	R1, R0
UXTB	R0, R2
L__saveIP454:
; buf start address is: 4 (R1)
UXTB	R2, R0
; buf end address is: 4 (R1)
MOV	R0, R1
IT	AL
BAL	L__saveIP453
L__saveIP458:
L__saveIP453:
;botrungtam.c,165 :: 		i++;
; i start address is: 8 (R2)
ADDS	R2, R2, #1
UXTB	R2, R2
;botrungtam.c,166 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_saveIP37
L_saveIP38:
;botrungtam.c,167 :: 		}
L_end_saveIP:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _saveIP
_copyBuf:
;botrungtam.c,168 :: 		void copyBuf(unsigned char a[],unsigned char b[],unsigned char size){
; size start address is: 8 (R2)
; b start address is: 4 (R1)
SUB	SP, SP, #4
; size end address is: 8 (R2)
; b end address is: 4 (R1)
; b start address is: 4 (R1)
; size start address is: 8 (R2)
;botrungtam.c,170 :: 		for(index=0;index<size;index++){
; index start address is: 20 (R5)
MOVS	R5, #0
; size end address is: 8 (R2)
; index end address is: 20 (R5)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_copyBuf66:
; index start address is: 20 (R5)
; a start address is: 8 (R2)
; b start address is: 4 (R1)
; b end address is: 4 (R1)
; a start address is: 8 (R2)
; a end address is: 8 (R2)
CMP	R5, R0
IT	CS
BCS	L_copyBuf67
; b end address is: 4 (R1)
; a end address is: 8 (R2)
;botrungtam.c,171 :: 		b[index]=a[index];
; a start address is: 8 (R2)
; b start address is: 4 (R1)
ADDS	R4, R1, R5
ADDS	R3, R2, R5
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;botrungtam.c,170 :: 		for(index=0;index<size;index++){
ADDS	R5, R5, #1
UXTB	R5, R5
;botrungtam.c,172 :: 		}
; b end address is: 4 (R1)
; a end address is: 8 (R2)
; index end address is: 20 (R5)
IT	AL
BAL	L_copyBuf66
L_copyBuf67:
;botrungtam.c,173 :: 		}
L_end_copyBuf:
ADD	SP, SP, #4
BX	LR
; end of _copyBuf
_SPI_Ethernet_UserTCP:
;botrungtam.c,174 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
; localPort start address is: 8 (R2)
SUB	SP, SP, #40
STR	LR, [SP, #0]
; localPort end address is: 8 (R2)
; localPort start address is: 8 (R2)
; flags start address is: 16 (R4)
LDR	R4, [SP, #40]
; flags end address is: 16 (R4)
;botrungtam.c,175 :: 		unsigned int len=0;
;botrungtam.c,176 :: 		unsigned char vt_button=0;
MOVS	R4, #0
STRB	R4, [SP, #14]
;botrungtam.c,177 :: 		unsigned long shift=1;
MOV	R4, #1
STR	R4, [SP, #16]
;botrungtam.c,179 :: 		unsigned char locate=0,_locate=0,h=0;
;botrungtam.c,181 :: 		if(localPort != 80)
CMP	R2, #80
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP69
; localPort end address is: 8 (R2)
;botrungtam.c,183 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;botrungtam.c,184 :: 		}
L_SPI_Ethernet_UserTCP69:
;botrungtam.c,185 :: 		for(len = 0;len < 30;len++){
MOVS	R4, #0
STRH	R4, [SP, #12]
L_SPI_Ethernet_UserTCP70:
LDRH	R4, [SP, #12]
CMP	R4, #30
IT	CS
BCS	L_SPI_Ethernet_UserTCP71
;botrungtam.c,186 :: 		getRequest[len] = SPI_Ethernet_getByte();
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R4, R4, R5
STR	R4, [SP, #36]
BL	_SPI_Ethernet_getByte+0
LDR	R4, [SP, #36]
STRB	R0, [R4, #0]
;botrungtam.c,185 :: 		for(len = 0;len < 30;len++){
LDRH	R4, [SP, #12]
ADDS	R4, R4, #1
STRH	R4, [SP, #12]
;botrungtam.c,187 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP70
L_SPI_Ethernet_UserTCP71:
;botrungtam.c,188 :: 		getRequest[len] = 0;
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R5, R4, R5
MOVS	R4, #0
STRB	R4, [R5, #0]
;botrungtam.c,189 :: 		len = 0;
MOVS	R4, #0
STRH	R4, [SP, #12]
;botrungtam.c,190 :: 		if(memcmp(getRequest, httpMethod, 5))
MOVS	R2, #5
SXTH	R2, R2
MOVW	R1, #lo_addr(_httpMethod+0)
MOVT	R1, #hi_addr(_httpMethod+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_memcmp+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP73
;botrungtam.c,192 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;botrungtam.c,193 :: 		}
L_SPI_Ethernet_UserTCP73:
;botrungtam.c,195 :: 		if(getRequest[5]=='t'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #116
IT	NE
BNE	L_SPI_Ethernet_UserTCP74
;botrungtam.c,196 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP75
;botrungtam.c,197 :: 		index_page=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBW	R5, R4, #48
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
STRH	R5, [R4, #0]
;botrungtam.c,198 :: 		if(index_page==Page_Setting){
UXTH	R4, R5
CMP	R4, #8
IT	NE
BNE	L_SPI_Ethernet_UserTCP76
;botrungtam.c,199 :: 		_locate=10;
; _locate start address is: 36 (R9)
MOVW	R9, #10
;botrungtam.c,200 :: 		for(h=0;h<4;h++){
; h start address is: 32 (R8)
MOVW	R8, #0
; h end address is: 32 (R8)
; _locate end address is: 36 (R9)
UXTB	R6, R8
UXTB	R8, R9
L_SPI_Ethernet_UserTCP77:
; h start address is: 24 (R6)
; _locate start address is: 32 (R8)
CMP	R6, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP78
;botrungtam.c,201 :: 		locate=get_point(getRequest,_locate,25);
MOVS	R2, #25
UXTB	R1, R8
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_get_point+0
; locate start address is: 28 (R7)
UXTB	R7, R0
;botrungtam.c,202 :: 		_myip[h]=chuoi_so(getRequest,_locate,(locate-1));
ADD	R5, SP, #4
LSLS	R4, R6, #1
ADDS	R4, R5, R4
STR	R4, [SP, #36]
SUBS	R4, R0, #1
UXTB	R2, R4
UXTB	R1, R8
; _locate end address is: 32 (R8)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
LDR	R4, [SP, #36]
STRH	R0, [R4, #0]
;botrungtam.c,203 :: 		_locate=locate+1;
ADDS	R4, R7, #1
; locate end address is: 28 (R7)
; _locate start address is: 36 (R9)
UXTB	R9, R4
;botrungtam.c,200 :: 		for(h=0;h<4;h++){
ADDS	R0, R6, #1
UXTB	R0, R0
; h end address is: 24 (R6)
;botrungtam.c,204 :: 		}
UXTB	R8, R9
; _locate end address is: 36 (R9)
UXTB	R6, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP77
L_SPI_Ethernet_UserTCP78:
;botrungtam.c,205 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
ADD	R4, SP, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP463
ADD	R4, SP, #4
ADDS	R4, R4, #2
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP462
ADD	R4, SP, #4
ADDS	R4, R4, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP461
ADD	R4, SP, #4
ADDS	R4, R4, #6
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP460
L__SPI_Ethernet_UserTCP459:
;botrungtam.c,206 :: 		for(h=0;h<4;h++){
MOVS	R0, #0
L_SPI_Ethernet_UserTCP83:
CMP	R0, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP84
;botrungtam.c,207 :: 		myIpAddr[h]=_myip[h];
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
ADDS	R6, R4, R0
ADD	R5, SP, #4
LSLS	R4, R0, #1
ADDS	R4, R5, R4
LDRH	R4, [R4, #0]
STRB	R4, [R6, #0]
;botrungtam.c,206 :: 		for(h=0;h<4;h++){
ADDS	R4, R0, #1
; h start address is: 4 (R1)
UXTB	R1, R4
;botrungtam.c,208 :: 		}
UXTB	R0, R1
; h end address is: 4 (R1)
IT	AL
BAL	L_SPI_Ethernet_UserTCP83
L_SPI_Ethernet_UserTCP84:
;botrungtam.c,209 :: 		flag_reset_ip=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_flag_reset_ip+0)
MOVT	R4, #hi_addr(_flag_reset_ip+0)
STRB	R5, [R4, #0]
;botrungtam.c,205 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
L__SPI_Ethernet_UserTCP463:
L__SPI_Ethernet_UserTCP462:
L__SPI_Ethernet_UserTCP461:
L__SPI_Ethernet_UserTCP460:
;botrungtam.c,211 :: 		}
L_SPI_Ethernet_UserTCP76:
;botrungtam.c,212 :: 		}
L_SPI_Ethernet_UserTCP75:
;botrungtam.c,213 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP86
L_SPI_Ethernet_UserTCP74:
;botrungtam.c,214 :: 		else if(getRequest[5] == 's'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #115
IT	NE
BNE	L_SPI_Ethernet_UserTCP87
;botrungtam.c,215 :: 		STAT = ~STAT;         // LED INDICATOR HOPTEST
MOVW	R5, #lo_addr(GPIOA_ODR+0)
MOVT	R5, #hi_addr(GPIOA_ODR+0)
LDR	R4, [R5, #0]
EOR	R4, R4, #1
STR	R4, [R5, #0]
;botrungtam.c,216 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;botrungtam.c,217 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,218 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP88
;botrungtam.c,219 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP90:
;botrungtam.c,220 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_12_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_12_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,221 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,222 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,223 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,224 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP91:
;botrungtam.c,225 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_13_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_13_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,226 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R4, #lo_addr(_status_wed_light+0)
MOVT	R4, #hi_addr(_status_wed_light+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,227 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,228 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,229 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP92:
;botrungtam.c,230 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_14_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_14_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,231 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R4, #lo_addr(_status_wed_curtain+0)
MOVT	R4, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,232 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,233 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,234 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP93:
;botrungtam.c,235 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_15_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_15_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,236 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R4, #lo_addr(_status_wed_scenes+0)
MOVT	R4, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,237 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,238 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,239 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP94:
;botrungtam.c,240 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_16_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_16_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,241 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,242 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,243 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,244 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP95:
;botrungtam.c,245 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_17_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_17_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,246 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R4, #lo_addr(_status_wed_dimer+0)
MOVT	R4, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,247 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,248 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,249 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP96:
;botrungtam.c,250 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_18_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_18_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,251 :: 		LongWordToStr(wed_status_button, dyna);
MOVW	R4, #lo_addr(_wed_status_button+0)
MOVT	R4, #hi_addr(_wed_status_button+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,252 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,253 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,254 :: 		default:
L_SPI_Ethernet_UserTCP97:
;botrungtam.c,255 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP89
;botrungtam.c,256 :: 		}
L_SPI_Ethernet_UserTCP88:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP90
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP91
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP92
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP93
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP94
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP95
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP96
IT	AL
BAL	L_SPI_Ethernet_UserTCP97
L_SPI_Ethernet_UserTCP89:
;botrungtam.c,257 :: 		}
L_SPI_Ethernet_UserTCP87:
L_SPI_Ethernet_UserTCP86:
;botrungtam.c,258 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP98
;botrungtam.c,259 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP100:
;botrungtam.c,260 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP101
;botrungtam.c,261 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP102
;botrungtam.c,262 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP103
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP103:
;botrungtam.c,263 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP104
;botrungtam.c,264 :: 		case 0://SERVICE_1
L_SPI_Ethernet_UserTCP106:
;botrungtam.c,267 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP105
;botrungtam.c,268 :: 		case 1://SERVICE_2
L_SPI_Ethernet_UserTCP107:
;botrungtam.c,271 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP105
;botrungtam.c,272 :: 		default:
L_SPI_Ethernet_UserTCP108:
;botrungtam.c,273 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP105
;botrungtam.c,274 :: 		}
L_SPI_Ethernet_UserTCP104:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP106
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP107
IT	AL
BAL	L_SPI_Ethernet_UserTCP108
L_SPI_Ethernet_UserTCP105:
;botrungtam.c,275 :: 		}
L_SPI_Ethernet_UserTCP102:
;botrungtam.c,276 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_19_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_19_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,277 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,278 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,279 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,280 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;botrungtam.c,281 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP109
L_SPI_Ethernet_UserTCP101:
;botrungtam.c,282 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP110
;botrungtam.c,283 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP111
;botrungtam.c,284 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP112
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP112:
;botrungtam.c,285 :: 		}
L_SPI_Ethernet_UserTCP111:
;botrungtam.c,286 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,287 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_20_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_20_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,288 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,289 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,290 :: 		}
L_SPI_Ethernet_UserTCP110:
L_SPI_Ethernet_UserTCP109:
;botrungtam.c,291 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,292 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP113:
;botrungtam.c,293 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP114
;botrungtam.c,294 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP115
;botrungtam.c,295 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP116
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP116:
;botrungtam.c,296 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP117
;botrungtam.c,297 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP119:
;botrungtam.c,300 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,301 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP120:
;botrungtam.c,317 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,318 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP121:
;botrungtam.c,321 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,322 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP122:
;botrungtam.c,325 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,326 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP123:
;botrungtam.c,329 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,330 :: 		default:
L_SPI_Ethernet_UserTCP124:
;botrungtam.c,331 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP118
;botrungtam.c,332 :: 		}
L_SPI_Ethernet_UserTCP117:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP119
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP120
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP121
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP122
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP123
IT	AL
BAL	L_SPI_Ethernet_UserTCP124
L_SPI_Ethernet_UserTCP118:
;botrungtam.c,333 :: 		}
L_SPI_Ethernet_UserTCP115:
;botrungtam.c,334 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_21_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_21_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,335 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,336 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,337 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,338 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;botrungtam.c,339 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP125
L_SPI_Ethernet_UserTCP114:
;botrungtam.c,340 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP126
;botrungtam.c,341 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP127
;botrungtam.c,342 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP128
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP128:
;botrungtam.c,343 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP129
;botrungtam.c,344 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP131:
;botrungtam.c,345 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,346 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP132:
;botrungtam.c,347 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,348 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP133:
;botrungtam.c,349 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,350 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP134:
;botrungtam.c,351 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,352 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP135:
;botrungtam.c,380 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,381 :: 		default:
L_SPI_Ethernet_UserTCP136:
;botrungtam.c,382 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP130
;botrungtam.c,383 :: 		}
L_SPI_Ethernet_UserTCP129:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP131
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP132
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP133
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP134
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP135
IT	AL
BAL	L_SPI_Ethernet_UserTCP136
L_SPI_Ethernet_UserTCP130:
;botrungtam.c,384 :: 		}
L_SPI_Ethernet_UserTCP127:
;botrungtam.c,385 :: 		flag_but_dimer=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_but_dimer+0)
MOVT	R4, #hi_addr(_flag_but_dimer+0)
STRB	R5, [R4, #0]
;botrungtam.c,386 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_22_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_22_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,387 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,388 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,389 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,390 :: 		}
L_SPI_Ethernet_UserTCP126:
L_SPI_Ethernet_UserTCP125:
;botrungtam.c,391 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,392 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP137:
;botrungtam.c,393 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP138
;botrungtam.c,394 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP139
;botrungtam.c,395 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP140
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP140:
;botrungtam.c,396 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP141
;botrungtam.c,397 :: 		case 0://CURTAIN_O 1   OPEN THEN CLOSE
L_SPI_Ethernet_UserTCP143:
;botrungtam.c,400 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP142
;botrungtam.c,401 :: 		case 1://CURTAIN_C 1   OPEN THEN STOP
L_SPI_Ethernet_UserTCP144:
;botrungtam.c,404 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP142
;botrungtam.c,405 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP145:
;botrungtam.c,408 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP142
;botrungtam.c,409 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP146:
;botrungtam.c,412 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP142
;botrungtam.c,414 :: 		default:
L_SPI_Ethernet_UserTCP147:
;botrungtam.c,415 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP142
;botrungtam.c,416 :: 		}
L_SPI_Ethernet_UserTCP141:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP143
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP144
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP145
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP146
IT	AL
BAL	L_SPI_Ethernet_UserTCP147
L_SPI_Ethernet_UserTCP142:
;botrungtam.c,417 :: 		}
L_SPI_Ethernet_UserTCP139:
;botrungtam.c,418 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_23_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_23_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,419 :: 		status_wed_curtain|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,420 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,421 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,423 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP148
L_SPI_Ethernet_UserTCP138:
;botrungtam.c,424 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP149
;botrungtam.c,425 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP150
;botrungtam.c,426 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP151
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP151:
;botrungtam.c,427 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP152
;botrungtam.c,428 :: 		case 0://CURTAIN_O 1
L_SPI_Ethernet_UserTCP154:
;botrungtam.c,430 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP153
;botrungtam.c,431 :: 		case 1://CURTAIN_C 1  OPEN THEN STOP ( TURN ON 8&9)
L_SPI_Ethernet_UserTCP155:
;botrungtam.c,434 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP153
;botrungtam.c,435 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP156:
;botrungtam.c,437 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP153
;botrungtam.c,438 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP157:
;botrungtam.c,441 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP153
;botrungtam.c,442 :: 		default:
L_SPI_Ethernet_UserTCP158:
;botrungtam.c,443 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP153
;botrungtam.c,444 :: 		}
L_SPI_Ethernet_UserTCP152:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP154
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP155
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP156
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP157
IT	AL
BAL	L_SPI_Ethernet_UserTCP158
L_SPI_Ethernet_UserTCP153:
;botrungtam.c,445 :: 		}
L_SPI_Ethernet_UserTCP150:
;botrungtam.c,446 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_24_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_24_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,447 :: 		status_wed_curtain&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,448 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,449 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,451 :: 		}
L_SPI_Ethernet_UserTCP149:
L_SPI_Ethernet_UserTCP148:
;botrungtam.c,452 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,453 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP159:
;botrungtam.c,454 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP160
;botrungtam.c,455 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP161
;botrungtam.c,456 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP162
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP162:
;botrungtam.c,457 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP163
;botrungtam.c,458 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP165:
;botrungtam.c,464 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP164
;botrungtam.c,465 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP166:
;botrungtam.c,472 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP164
;botrungtam.c,473 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP167:
;botrungtam.c,478 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP164
;botrungtam.c,479 :: 		default:
L_SPI_Ethernet_UserTCP168:
;botrungtam.c,480 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP164
;botrungtam.c,481 :: 		}
L_SPI_Ethernet_UserTCP163:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP165
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP166
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP167
IT	AL
BAL	L_SPI_Ethernet_UserTCP168
L_SPI_Ethernet_UserTCP164:
;botrungtam.c,482 :: 		}
L_SPI_Ethernet_UserTCP161:
;botrungtam.c,483 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_25_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_25_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,484 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,485 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,486 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,487 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;botrungtam.c,488 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP169
L_SPI_Ethernet_UserTCP160:
;botrungtam.c,489 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP170
;botrungtam.c,490 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP171
;botrungtam.c,491 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP172
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP172:
;botrungtam.c,492 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP173
;botrungtam.c,493 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP175:
;botrungtam.c,494 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP174
;botrungtam.c,495 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP176:
;botrungtam.c,496 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP174
;botrungtam.c,497 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP177:
;botrungtam.c,498 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP174
;botrungtam.c,499 :: 		default:
L_SPI_Ethernet_UserTCP178:
;botrungtam.c,500 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP174
;botrungtam.c,501 :: 		}
L_SPI_Ethernet_UserTCP173:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP175
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP176
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP177
IT	AL
BAL	L_SPI_Ethernet_UserTCP178
L_SPI_Ethernet_UserTCP174:
;botrungtam.c,502 :: 		}
L_SPI_Ethernet_UserTCP171:
;botrungtam.c,503 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_26_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_26_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,504 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,505 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,506 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,507 :: 		}
L_SPI_Ethernet_UserTCP170:
L_SPI_Ethernet_UserTCP169:
;botrungtam.c,508 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,509 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP179:
;botrungtam.c,510 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP180
;botrungtam.c,511 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP181
;botrungtam.c,512 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP182
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP182:
;botrungtam.c,513 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP183
;botrungtam.c,514 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP185:
;botrungtam.c,515 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP184
;botrungtam.c,516 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP186:
;botrungtam.c,517 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP184
;botrungtam.c,518 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP187:
;botrungtam.c,519 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP184
;botrungtam.c,520 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP188:
;botrungtam.c,521 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP184
;botrungtam.c,522 :: 		default:
L_SPI_Ethernet_UserTCP189:
;botrungtam.c,523 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP184
;botrungtam.c,524 :: 		}
L_SPI_Ethernet_UserTCP183:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP185
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP186
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP187
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP188
IT	AL
BAL	L_SPI_Ethernet_UserTCP189
L_SPI_Ethernet_UserTCP184:
;botrungtam.c,525 :: 		}
L_SPI_Ethernet_UserTCP181:
;botrungtam.c,526 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_27_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_27_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,527 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP190
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP191
L_SPI_Ethernet_UserTCP190:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP191:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP192
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP193
L_SPI_Ethernet_UserTCP192:
;botrungtam.c,528 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP193:
;botrungtam.c,529 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP194
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP195
L_SPI_Ethernet_UserTCP194:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP195:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP196
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP197
L_SPI_Ethernet_UserTCP196:
;botrungtam.c,530 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP197:
;botrungtam.c,531 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP198
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP199
L_SPI_Ethernet_UserTCP198:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP199:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP200
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP201
L_SPI_Ethernet_UserTCP200:
;botrungtam.c,532 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP201:
;botrungtam.c,533 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,534 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,535 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP202
L_SPI_Ethernet_UserTCP180:
;botrungtam.c,536 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP203
;botrungtam.c,537 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP204
;botrungtam.c,538 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP205
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP205:
;botrungtam.c,539 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP206
;botrungtam.c,540 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP208:
;botrungtam.c,541 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP207
;botrungtam.c,542 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP209:
;botrungtam.c,543 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP207
;botrungtam.c,544 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP210:
;botrungtam.c,545 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP207
;botrungtam.c,546 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP211:
;botrungtam.c,547 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP207
;botrungtam.c,548 :: 		default:
L_SPI_Ethernet_UserTCP212:
;botrungtam.c,549 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP207
;botrungtam.c,550 :: 		}
L_SPI_Ethernet_UserTCP206:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP208
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP209
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP210
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP211
IT	AL
BAL	L_SPI_Ethernet_UserTCP212
L_SPI_Ethernet_UserTCP207:
;botrungtam.c,551 :: 		}
L_SPI_Ethernet_UserTCP204:
;botrungtam.c,552 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_28_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_28_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,553 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP213
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP214
L_SPI_Ethernet_UserTCP213:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP214:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP215
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP216
L_SPI_Ethernet_UserTCP215:
;botrungtam.c,554 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP216:
;botrungtam.c,555 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP217
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP218
L_SPI_Ethernet_UserTCP217:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP218:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP219
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP220
L_SPI_Ethernet_UserTCP219:
;botrungtam.c,556 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP220:
;botrungtam.c,557 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP221
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP222
L_SPI_Ethernet_UserTCP221:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP222:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP223
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP224
L_SPI_Ethernet_UserTCP223:
;botrungtam.c,558 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP224:
;botrungtam.c,559 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,560 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,561 :: 		}
L_SPI_Ethernet_UserTCP203:
L_SPI_Ethernet_UserTCP202:
;botrungtam.c,562 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,563 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP225:
;botrungtam.c,564 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP226
;botrungtam.c,565 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP227
;botrungtam.c,566 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP228
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP228:
;botrungtam.c,567 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP229
;botrungtam.c,568 :: 		case 0:
L_SPI_Ethernet_UserTCP231:
;botrungtam.c,569 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,570 :: 		case 1:
L_SPI_Ethernet_UserTCP232:
;botrungtam.c,571 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,572 :: 		case 2:
L_SPI_Ethernet_UserTCP233:
;botrungtam.c,573 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,574 :: 		case 3:
L_SPI_Ethernet_UserTCP234:
;botrungtam.c,575 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,576 :: 		case 4:
L_SPI_Ethernet_UserTCP235:
;botrungtam.c,577 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,578 :: 		case 5:
L_SPI_Ethernet_UserTCP236:
;botrungtam.c,579 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,580 :: 		default:
L_SPI_Ethernet_UserTCP237:
;botrungtam.c,581 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP230
;botrungtam.c,582 :: 		}
L_SPI_Ethernet_UserTCP229:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP231
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP232
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP233
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP234
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP235
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP236
IT	AL
BAL	L_SPI_Ethernet_UserTCP237
L_SPI_Ethernet_UserTCP230:
;botrungtam.c,583 :: 		}
L_SPI_Ethernet_UserTCP227:
;botrungtam.c,584 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_29_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_29_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,585 :: 		status_wed_dimer|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,586 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,587 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,588 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP238
L_SPI_Ethernet_UserTCP226:
;botrungtam.c,589 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP239
;botrungtam.c,590 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP240
;botrungtam.c,591 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP241
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP241:
;botrungtam.c,592 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP242
;botrungtam.c,593 :: 		case 0://up1
L_SPI_Ethernet_UserTCP244:
;botrungtam.c,594 :: 		flag_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+1)
MOVT	R4, #hi_addr(_flag_dimer_ex+1)
STRB	R5, [R4, #0]
;botrungtam.c,595 :: 		count_time_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+4)
MOVT	R4, #hi_addr(_count_time_dimer_ex+4)
STR	R5, [R4, #0]
;botrungtam.c,596 :: 		DIM2_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM2_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM2_EVERGREEN+0)
STRB	R5, [R4, #0]
;botrungtam.c,597 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,598 :: 		case 1://dow1
L_SPI_Ethernet_UserTCP245:
;botrungtam.c,599 :: 		flag_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+1)
MOVT	R4, #hi_addr(_flag_dimer_ex+1)
STRB	R5, [R4, #0]
;botrungtam.c,600 :: 		count_time_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+4)
MOVT	R4, #hi_addr(_count_time_dimer_ex+4)
STR	R5, [R4, #0]
;botrungtam.c,601 :: 		DIM2_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM2_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM2_EVERGREEN+0)
STRB	R5, [R4, #0]
;botrungtam.c,602 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,603 :: 		case 2://up34
L_SPI_Ethernet_UserTCP246:
;botrungtam.c,607 :: 		flag_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+2)
MOVT	R4, #hi_addr(_flag_dimer_ex+2)
STRB	R5, [R4, #0]
;botrungtam.c,608 :: 		count_time_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+8)
MOVT	R4, #hi_addr(_count_time_dimer_ex+8)
STR	R5, [R4, #0]
;botrungtam.c,609 :: 		DIM4_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM4_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM4_EVERGREEN+0)
STRB	R5, [R4, #0]
;botrungtam.c,610 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,611 :: 		case 3://down34
L_SPI_Ethernet_UserTCP247:
;botrungtam.c,614 :: 		flag_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+2)
MOVT	R4, #hi_addr(_flag_dimer_ex+2)
STRB	R5, [R4, #0]
;botrungtam.c,615 :: 		count_time_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+8)
MOVT	R4, #hi_addr(_count_time_dimer_ex+8)
STR	R5, [R4, #0]
;botrungtam.c,616 :: 		DIM4_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM4_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM4_EVERGREEN+0)
STRB	R5, [R4, #0]
;botrungtam.c,617 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,618 :: 		case 4://up3
L_SPI_Ethernet_UserTCP248:
;botrungtam.c,621 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,622 :: 		case 5://down3
L_SPI_Ethernet_UserTCP249:
;botrungtam.c,625 :: 		default:
L_SPI_Ethernet_UserTCP250:
;botrungtam.c,626 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP243
;botrungtam.c,627 :: 		}
L_SPI_Ethernet_UserTCP242:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP244
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP245
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP246
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP247
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP248
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP249
IT	AL
BAL	L_SPI_Ethernet_UserTCP250
L_SPI_Ethernet_UserTCP243:
;botrungtam.c,628 :: 		}
L_SPI_Ethernet_UserTCP240:
;botrungtam.c,629 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_30_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_30_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,630 :: 		status_wed_dimer&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,631 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,632 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,633 :: 		}
L_SPI_Ethernet_UserTCP239:
L_SPI_Ethernet_UserTCP238:
;botrungtam.c,634 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,635 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP251:
;botrungtam.c,636 :: 		if(getRequest[5] == 'd'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #100
IT	NE
BNE	L_SPI_Ethernet_UserTCP252
;botrungtam.c,637 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP253
;botrungtam.c,638 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP254
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP254:
;botrungtam.c,639 :: 		}
L_SPI_Ethernet_UserTCP253:
;botrungtam.c,640 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP255
;botrungtam.c,641 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP256
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
IT	AL
BAL	L_SPI_Ethernet_UserTCP257
L_SPI_Ethernet_UserTCP256:
;botrungtam.c,642 :: 		else if(getRequest[8]=='$')vt_button=chuoi_so(getRequest,6,7);
MOVW	R4, #lo_addr(_getRequest+8)
MOVT	R4, #hi_addr(_getRequest+8)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP258
MOVS	R2, #7
MOVS	R1, #6
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
STRB	R0, [SP, #14]
IT	AL
BAL	L_SPI_Ethernet_UserTCP259
L_SPI_Ethernet_UserTCP258:
;botrungtam.c,643 :: 		else if(getRequest[9]=='$')vt_button=chuoi_so(getRequest,6,8);
MOVW	R4, #lo_addr(_getRequest+9)
MOVT	R4, #hi_addr(_getRequest+9)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP260
MOVS	R2, #8
MOVS	R1, #6
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
STRB	R0, [SP, #14]
L_SPI_Ethernet_UserTCP260:
L_SPI_Ethernet_UserTCP259:
L_SPI_Ethernet_UserTCP257:
;botrungtam.c,644 :: 		}
L_SPI_Ethernet_UserTCP255:
;botrungtam.c,647 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_31_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_31_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,648 :: 		wed_status_button^=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R7, R4, R5
MOVW	R5, #lo_addr(_wed_status_button+0)
MOVT	R5, #hi_addr(_wed_status_button+0)
LDR	R4, [R5, #0]
EOR	R6, R4, R7, LSL #0
STR	R6, [R5, #0]
;botrungtam.c,649 :: 		out_relay^=(shift<<vt_button);
MOVW	R5, #lo_addr(_out_relay+0)
MOVT	R5, #hi_addr(_out_relay+0)
LDR	R4, [R5, #0]
EORS	R4, R7
STR	R4, [R5, #0]
;botrungtam.c,650 :: 		LongWordToStr(wed_status_button, dyna);
MOV	R4, R6
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,651 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,654 :: 		}
L_SPI_Ethernet_UserTCP252:
;botrungtam.c,655 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,656 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP261:
;botrungtam.c,657 :: 		copyBuf(getRequest,buf,40);
MOVS	R2, #40
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_copyBuf+0
;botrungtam.c,658 :: 		saveIP(buf);
MOVW	R0, #lo_addr(_buf+0)
MOVT	R0, #hi_addr(_buf+0)
BL	_saveIP+0
;botrungtam.c,659 :: 		if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP262
;botrungtam.c,660 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_32_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_32_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,661 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,662 :: 		}
L_SPI_Ethernet_UserTCP262:
;botrungtam.c,663 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,664 :: 		default:
L_SPI_Ethernet_UserTCP263:
;botrungtam.c,665 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
;botrungtam.c,666 :: 		}
L_SPI_Ethernet_UserTCP98:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP100
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP113
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP137
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP159
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP179
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP225
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP251
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP261
IT	AL
BAL	L_SPI_Ethernet_UserTCP263
L_SPI_Ethernet_UserTCP99:
;botrungtam.c,667 :: 		if(len == 0){
LDRH	R4, [SP, #12]
CMP	R4, #0
IT	NE
BNE	L_SPI_Ethernet_UserTCP264
;botrungtam.c,668 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;botrungtam.c,669 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,670 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP265
;botrungtam.c,671 :: 		case Page_Login:
L_SPI_Ethernet_UserTCP267:
;botrungtam.c,672 :: 		len += putConstString(LoginPage);
MOVW	R4, #lo_addr(_LoginPage+0)
MOVT	R4, #hi_addr(_LoginPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,673 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,674 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP268:
;botrungtam.c,675 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,676 :: 		len += putConstString(ServicePage);
MOVW	R4, #lo_addr(_ServicePage+0)
MOVT	R4, #hi_addr(_ServicePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,677 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,678 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP269:
;botrungtam.c,679 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,680 :: 		len += putConstString(LightingPage);
MOVW	R4, #lo_addr(_LightingPage+0)
MOVT	R4, #hi_addr(_LightingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,681 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,682 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP270:
;botrungtam.c,683 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,684 :: 		len += putConstString(CurtainPage);
MOVW	R4, #lo_addr(_CurtainPage+0)
MOVT	R4, #hi_addr(_CurtainPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,685 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,686 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP271:
;botrungtam.c,687 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,688 :: 		len += putConstString(ScenesPage);
MOVW	R4, #lo_addr(_ScenesPage+0)
MOVT	R4, #hi_addr(_ScenesPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,689 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,690 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP272:
;botrungtam.c,691 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,692 :: 		len += putConstString(Fan_SpeedPage);
MOVW	R4, #lo_addr(_Fan_SpeedPage+0)
MOVT	R4, #hi_addr(_Fan_SpeedPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,693 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,694 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP273:
;botrungtam.c,695 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,696 :: 		len += putConstString(Dimer_ExtantPage);
MOVW	R4, #lo_addr(_Dimer_ExtantPage+0)
MOVT	R4, #hi_addr(_Dimer_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,697 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,698 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP274:
;botrungtam.c,699 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,700 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,701 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP275:
;botrungtam.c,702 :: 		len += putConstString(SettingPage);
MOVW	R4, #lo_addr(_SettingPage+0)
MOVT	R4, #hi_addr(_SettingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,703 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,704 :: 		case Page_Home:
L_SPI_Ethernet_UserTCP276:
;botrungtam.c,705 :: 		len += putConstString(HomePage);
MOVW	R4, #lo_addr(_HomePage+0)
MOVT	R4, #hi_addr(_HomePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,706 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,707 :: 		default:
L_SPI_Ethernet_UserTCP277:
;botrungtam.c,708 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,709 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,710 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
;botrungtam.c,711 :: 		}
L_SPI_Ethernet_UserTCP265:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP267
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP268
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP269
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP270
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP271
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP272
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP273
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP274
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP275
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #9
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP276
IT	AL
BAL	L_SPI_Ethernet_UserTCP277
L_SPI_Ethernet_UserTCP266:
;botrungtam.c,712 :: 		}
L_SPI_Ethernet_UserTCP264:
;botrungtam.c,713 :: 		return(len);
LDRH	R0, [SP, #12]
;botrungtam.c,714 :: 		}
L_end_SPI_Ethernet_UserTCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _SPI_Ethernet_UserTCP
_SPI_Ethernet_UserUDP:
;botrungtam.c,715 :: 		unsigned int    SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
; flags start address is: 16 (R4)
SUB	SP, SP, #16
LDR	R4, [SP, #16]
; flags end address is: 16 (R4)
;botrungtam.c,716 :: 		return(0);
MOVS	R0, #0
;botrungtam.c,717 :: 		}
L_end_SPI_Ethernet_UserUDP:
ADD	SP, SP, #16
BX	LR
; end of _SPI_Ethernet_UserUDP
_timer1_isr:
;botrungtam.c,719 :: 		void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO { //20 ms
SUB	SP, SP, #4
STR	LR, [SP, #0]
;botrungtam.c,720 :: 		unsigned char i_isr=0,but_isr=0;
;botrungtam.c,726 :: 		unsigned long shift=1;
;botrungtam.c,728 :: 		if(TIM1_SRbits.UIF==1)
MOVW	R1, #lo_addr(TIM1_SRbits+0)
MOVT	R1, #hi_addr(TIM1_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr278
;botrungtam.c,730 :: 		TIM1_SRbits.UIF=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SRbits+0)
MOVT	R0, #hi_addr(TIM1_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,733 :: 		but_sample[0][SAMPLE-1]=!BUT1_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+1)
MOVT	R0, #hi_addr(_but_sample+1)
STRB	R1, [R0, #0]
;botrungtam.c,734 :: 		but_sample[1][SAMPLE-1]=!BUT1_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+3)
MOVT	R0, #hi_addr(_but_sample+3)
STRB	R1, [R0, #0]
;botrungtam.c,735 :: 		but_sample[2][SAMPLE-1]=!BUT1_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+5)
MOVT	R0, #hi_addr(_but_sample+5)
STRB	R1, [R0, #0]
;botrungtam.c,737 :: 		but_sample[3][SAMPLE-1]=!BUT2_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+7)
MOVT	R0, #hi_addr(_but_sample+7)
STRB	R1, [R0, #0]
;botrungtam.c,738 :: 		but_sample[4][SAMPLE-1]=!BUT2_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+9)
MOVT	R0, #hi_addr(_but_sample+9)
STRB	R1, [R0, #0]
;botrungtam.c,739 :: 		but_sample[5][SAMPLE-1]=!BUT2_2;
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+11)
MOVT	R0, #hi_addr(_but_sample+11)
STRB	R1, [R0, #0]
;botrungtam.c,741 :: 		but_sample[6][SAMPLE-1]=!BUT3_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+13)
MOVT	R0, #hi_addr(_but_sample+13)
STRB	R1, [R0, #0]
;botrungtam.c,742 :: 		but_sample[7][SAMPLE-1]=!BUT3_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+15)
MOVT	R0, #hi_addr(_but_sample+15)
STRB	R1, [R0, #0]
;botrungtam.c,743 :: 		but_sample[8][SAMPLE-1]=!BUT3_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+17)
MOVT	R0, #hi_addr(_but_sample+17)
STRB	R1, [R0, #0]
;botrungtam.c,745 :: 		but_sample[9][SAMPLE-1]=!BUT4_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+19)
MOVT	R0, #hi_addr(_but_sample+19)
STRB	R1, [R0, #0]
;botrungtam.c,746 :: 		but_sample[10][SAMPLE-1]=!BUT4_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+21)
MOVT	R0, #hi_addr(_but_sample+21)
STRB	R1, [R0, #0]
;botrungtam.c,748 :: 		but_sample[11][SAMPLE-1]=!BUT5_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+23)
MOVT	R0, #hi_addr(_but_sample+23)
STRB	R1, [R0, #0]
;botrungtam.c,749 :: 		but_sample[12][SAMPLE-1]=!BUT5_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+25)
MOVT	R0, #hi_addr(_but_sample+25)
STRB	R1, [R0, #0]
;botrungtam.c,751 :: 		but_sample[13][SAMPLE-1]=!BUT6_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+27)
MOVT	R0, #hi_addr(_but_sample+27)
STRB	R1, [R0, #0]
;botrungtam.c,753 :: 		but_sample[14][SAMPLE-1]=!BUT7_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+29)
MOVT	R0, #hi_addr(_but_sample+29)
STRB	R1, [R0, #0]
;botrungtam.c,755 :: 		but_sample[15][SAMPLE-1]=!BUT8_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+31)
MOVT	R0, #hi_addr(_but_sample+31)
STRB	R1, [R0, #0]
;botrungtam.c,756 :: 		but_sample[16][SAMPLE-1]=!BUT8_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+33)
MOVT	R0, #hi_addr(_but_sample+33)
STRB	R1, [R0, #0]
;botrungtam.c,758 :: 		but_sample[17][SAMPLE-1]=!BUT9_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+35)
MOVT	R0, #hi_addr(_but_sample+35)
STRB	R1, [R0, #0]
;botrungtam.c,759 :: 		but_sample[18][SAMPLE-1]=!BUT9_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+37)
MOVT	R0, #hi_addr(_but_sample+37)
STRB	R1, [R0, #0]
;botrungtam.c,761 :: 		but_sample[19][SAMPLE-1]=!BUT10_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+39)
MOVT	R0, #hi_addr(_but_sample+39)
STRB	R1, [R0, #0]
;botrungtam.c,762 :: 		but_sample[20][SAMPLE-1]=!BUT10_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+41)
MOVT	R0, #hi_addr(_but_sample+41)
STRB	R1, [R0, #0]
;botrungtam.c,764 :: 		but_sample[21][SAMPLE-1]=!BUT11_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+43)
MOVT	R0, #hi_addr(_but_sample+43)
STRB	R1, [R0, #0]
;botrungtam.c,765 :: 		but_sample[22][SAMPLE-1]=!BUT11_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+45)
MOVT	R0, #hi_addr(_but_sample+45)
STRB	R1, [R0, #0]
;botrungtam.c,767 :: 		but_sample[23][SAMPLE-1]=!BUT12_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+47)
MOVT	R0, #hi_addr(_but_sample+47)
STRB	R1, [R0, #0]
;botrungtam.c,769 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
; but_isr start address is: 12 (R3)
MOVS	R3, #0
; but_isr end address is: 12 (R3)
L_timer1_isr279:
; but_isr start address is: 12 (R3)
CMP	R3, #24
IT	CS
BCS	L_timer1_isr280
;botrungtam.c,770 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr282:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #1
IT	CS
BCS	L_timer1_isr283
;botrungtam.c,771 :: 		but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_but_sample+0)
MOVT	R0, #hi_addr(_but_sample+0)
ADDS	R2, R0, R1
ADDS	R1, R2, R4
ADDS	R0, R4, #1
SXTH	R0, R0
ADDS	R0, R2, R0
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;botrungtam.c,770 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,772 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr282
L_timer1_isr283:
;botrungtam.c,773 :: 		but_sum_sample[but_isr]=0;
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,774 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr285:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #2
IT	CS
BCS	L_timer1_isr286
;botrungtam.c,775 :: 		but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R2, R0, R3
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_but_sample+0)
MOVT	R0, #hi_addr(_but_sample+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R4
LDRB	R1, [R0, #0]
LDRB	R0, [R2, #0]
ADDS	R0, R0, R1
STRB	R0, [R2, #0]
;botrungtam.c,774 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,776 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr285
L_timer1_isr286:
;botrungtam.c,777 :: 		if(but_sum_sample[but_isr]>=PRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	CC
BCC	L_timer1_isr288
;botrungtam.c,778 :: 		but_state[but_isr]=PRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #2
STRB	R0, [R1, #0]
;botrungtam.c,779 :: 		}
IT	AL
BAL	L_timer1_isr289
L_timer1_isr288:
;botrungtam.c,780 :: 		else if(but_sum_sample[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr290
;botrungtam.c,781 :: 		but_state[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,782 :: 		}
L_timer1_isr290:
L_timer1_isr289:
;botrungtam.c,783 :: 		if(but_state[but_isr]==PRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_timer1_isr291
;botrungtam.c,784 :: 		if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr292
;botrungtam.c,785 :: 		but_status[but_isr]=PRES_DOW;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #5
STRB	R0, [R1, #0]
;botrungtam.c,786 :: 		}
IT	AL
BAL	L_timer1_isr293
L_timer1_isr292:
;botrungtam.c,787 :: 		else if(but_status[but_isr]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr294
;botrungtam.c,788 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,789 :: 		}
IT	AL
BAL	L_timer1_isr295
L_timer1_isr294:
;botrungtam.c,790 :: 		else if(but_status[but_isr]==PRESSING){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_timer1_isr296
;botrungtam.c,791 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,792 :: 		}
L_timer1_isr296:
L_timer1_isr295:
L_timer1_isr293:
;botrungtam.c,793 :: 		}
IT	AL
BAL	L_timer1_isr297
L_timer1_isr291:
;botrungtam.c,794 :: 		else if(but_state[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr298
;botrungtam.c,795 :: 		if ((but_status[but_isr]==PRESSING)||(but_status[but_isr]==PRES_DOW)){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L__timer1_isr466
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L__timer1_isr465
IT	AL
BAL	L_timer1_isr301
L__timer1_isr466:
L__timer1_isr465:
;botrungtam.c,796 :: 		but_status[but_isr]=PRES_UP;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #4
STRB	R0, [R1, #0]
;botrungtam.c,797 :: 		}
IT	AL
BAL	L_timer1_isr302
L_timer1_isr301:
;botrungtam.c,798 :: 		else if(but_status[but_isr]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr303
;botrungtam.c,799 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,800 :: 		}
IT	AL
BAL	L_timer1_isr304
L_timer1_isr303:
;botrungtam.c,801 :: 		else if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr305
;botrungtam.c,802 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,803 :: 		}
L_timer1_isr305:
L_timer1_isr304:
L_timer1_isr302:
;botrungtam.c,804 :: 		}
L_timer1_isr298:
L_timer1_isr297:
;botrungtam.c,769 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
ADDS	R3, R3, #1
UXTB	R3, R3
;botrungtam.c,805 :: 		}
; but_isr end address is: 12 (R3)
IT	AL
BAL	L_timer1_isr279
L_timer1_isr280:
;botrungtam.c,807 :: 		duphong67_A8=~duphong67_A8;             // LED INDICAROR QUET BAN PHIM
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,811 :: 		if(but_status[0]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr306
;botrungtam.c,813 :: 		}
IT	AL
BAL	L_timer1_isr307
L_timer1_isr306:
;botrungtam.c,814 :: 		else if(but_status[0]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr308
;botrungtam.c,816 :: 		}
L_timer1_isr308:
L_timer1_isr307:
;botrungtam.c,818 :: 		if(but_status[1]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr309
;botrungtam.c,820 :: 		}
IT	AL
BAL	L_timer1_isr310
L_timer1_isr309:
;botrungtam.c,821 :: 		else if(but_status[1]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr311
;botrungtam.c,823 :: 		}
L_timer1_isr311:
L_timer1_isr310:
;botrungtam.c,825 :: 		if(but_status[2]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr312
;botrungtam.c,826 :: 		LED_1_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,827 :: 		if(!DO_NOT_DISTURB){
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr313
;botrungtam.c,828 :: 		out_relay|=RELAY_13;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #4096
STR	R0, [R1, #0]
;botrungtam.c,829 :: 		BELL_ENABLE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,830 :: 		}
L_timer1_isr313:
;botrungtam.c,832 :: 		}
IT	AL
BAL	L_timer1_isr314
L_timer1_isr312:
;botrungtam.c,833 :: 		else if(but_status[2]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr315
;botrungtam.c,834 :: 		LED_1_2=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,836 :: 		}
L_timer1_isr315:
L_timer1_isr314:
;botrungtam.c,839 :: 		if(but_status[3]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr316
;botrungtam.c,840 :: 		LED_2_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,841 :: 		out_relay^=RELAY_7;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,842 :: 		}
IT	AL
BAL	L_timer1_isr317
L_timer1_isr316:
;botrungtam.c,843 :: 		else if(but_status[3]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr318
;botrungtam.c,844 :: 		LED_2_0=(out_relay&RELAY_7)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #64
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr319
; ?FLOC___timer1_isr?T1137 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1137 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr320
L_timer1_isr319:
; ?FLOC___timer1_isr?T1137 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1137 end address is: 4 (R1)
L_timer1_isr320:
; ?FLOC___timer1_isr?T1137 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1137 end address is: 4 (R1)
;botrungtam.c,845 :: 		}
L_timer1_isr318:
L_timer1_isr317:
;botrungtam.c,847 :: 		if(but_status[4]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr321
;botrungtam.c,848 :: 		LED_2_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,849 :: 		out_relay^=RELAY_6;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,850 :: 		}
IT	AL
BAL	L_timer1_isr322
L_timer1_isr321:
;botrungtam.c,851 :: 		else if(but_status[4]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr323
;botrungtam.c,852 :: 		LED_2_1=(out_relay&RELAY_6)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr324
; ?FLOC___timer1_isr?T1148 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1148 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr325
L_timer1_isr324:
; ?FLOC___timer1_isr?T1148 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1148 end address is: 4 (R1)
L_timer1_isr325:
; ?FLOC___timer1_isr?T1148 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1148 end address is: 4 (R1)
;botrungtam.c,853 :: 		}
L_timer1_isr323:
L_timer1_isr322:
;botrungtam.c,856 :: 		if(but_status[5]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr326
;botrungtam.c,857 :: 		LED_2_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,858 :: 		out_relay^=RELAY_3;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #4
STR	R0, [R1, #0]
;botrungtam.c,860 :: 		}
IT	AL
BAL	L_timer1_isr327
L_timer1_isr326:
;botrungtam.c,861 :: 		else if(but_status[5]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr328
;botrungtam.c,862 :: 		LED_2_2=(out_relay&RELAY_3)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #4
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr329
; ?FLOC___timer1_isr?T1159 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1159 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr330
L_timer1_isr329:
; ?FLOC___timer1_isr?T1159 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1159 end address is: 4 (R1)
L_timer1_isr330:
; ?FLOC___timer1_isr?T1159 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1159 end address is: 4 (R1)
;botrungtam.c,864 :: 		}
L_timer1_isr328:
L_timer1_isr327:
;botrungtam.c,868 :: 		if(but_status[6]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr331
;botrungtam.c,870 :: 		}
IT	AL
BAL	L_timer1_isr332
L_timer1_isr331:
;botrungtam.c,871 :: 		else if(but_status[6]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr333
;botrungtam.c,873 :: 		}
L_timer1_isr333:
L_timer1_isr332:
;botrungtam.c,875 :: 		if(but_status[7]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr334
;botrungtam.c,876 :: 		LED_3_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,877 :: 		out_relay^=RELAY_8;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #128
STR	R0, [R1, #0]
;botrungtam.c,878 :: 		}
IT	AL
BAL	L_timer1_isr335
L_timer1_isr334:
;botrungtam.c,879 :: 		else if(but_status[7]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr336
;botrungtam.c,880 :: 		LED_3_0=(out_relay&RELAY_8)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr337
; ?FLOC___timer1_isr?T1174 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1174 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr338
L_timer1_isr337:
; ?FLOC___timer1_isr?T1174 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1174 end address is: 4 (R1)
L_timer1_isr338:
; ?FLOC___timer1_isr?T1174 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1174 end address is: 4 (R1)
;botrungtam.c,881 :: 		}
L_timer1_isr336:
L_timer1_isr335:
;botrungtam.c,883 :: 		if(but_status[8]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr339
;botrungtam.c,884 :: 		LED_3_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,885 :: 		out_relay^=RELAY_15;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #16384
STR	R0, [R1, #0]
;botrungtam.c,886 :: 		}
IT	AL
BAL	L_timer1_isr340
L_timer1_isr339:
;botrungtam.c,887 :: 		else if(but_status[8]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr341
;botrungtam.c,888 :: 		LED_3_2=(out_relay&RELAY_15)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #16384
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr342
; ?FLOC___timer1_isr?T1185 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1185 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr343
L_timer1_isr342:
; ?FLOC___timer1_isr?T1185 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1185 end address is: 4 (R1)
L_timer1_isr343:
; ?FLOC___timer1_isr?T1185 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1185 end address is: 4 (R1)
;botrungtam.c,889 :: 		}
L_timer1_isr341:
L_timer1_isr340:
;botrungtam.c,892 :: 		if(but_status[9]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr344
;botrungtam.c,893 :: 		LED_4_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,894 :: 		out_relay^=RELAY_9;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #256
STR	R0, [R1, #0]
;botrungtam.c,895 :: 		}
IT	AL
BAL	L_timer1_isr345
L_timer1_isr344:
;botrungtam.c,896 :: 		else if(but_status[9]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr346
;botrungtam.c,897 :: 		LED_4_0=(out_relay&RELAY_9)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #256
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr347
; ?FLOC___timer1_isr?T1196 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1196 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr348
L_timer1_isr347:
; ?FLOC___timer1_isr?T1196 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1196 end address is: 4 (R1)
L_timer1_isr348:
; ?FLOC___timer1_isr?T1196 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1196 end address is: 4 (R1)
;botrungtam.c,898 :: 		LED_6_0=LED_4_0; // S3 PORT6
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,899 :: 		}
L_timer1_isr346:
L_timer1_isr345:
;botrungtam.c,901 :: 		if(but_status[10]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr349
;botrungtam.c,902 :: 		LED_4_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,903 :: 		out_relay^=RELAY_10;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #512
STR	R0, [R1, #0]
;botrungtam.c,904 :: 		}
IT	AL
BAL	L_timer1_isr350
L_timer1_isr349:
;botrungtam.c,905 :: 		else if(but_status[10]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr351
;botrungtam.c,906 :: 		LED_4_1=(out_relay&RELAY_10)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #512
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr352
; ?FLOC___timer1_isr?T1210 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1210 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr353
L_timer1_isr352:
; ?FLOC___timer1_isr?T1210 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1210 end address is: 4 (R1)
L_timer1_isr353:
; ?FLOC___timer1_isr?T1210 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1210 end address is: 4 (R1)
;botrungtam.c,907 :: 		}
L_timer1_isr351:
L_timer1_isr350:
;botrungtam.c,911 :: 		if(but_status[11]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr354
;botrungtam.c,912 :: 		LED_5_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,913 :: 		out_relay^=RELAY_1;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,914 :: 		}
IT	AL
BAL	L_timer1_isr355
L_timer1_isr354:
;botrungtam.c,915 :: 		else if(but_status[11]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr356
;botrungtam.c,916 :: 		LED_5_0=(out_relay&RELAY_1)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #1
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr357
; ?FLOC___timer1_isr?T1221 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1221 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr358
L_timer1_isr357:
; ?FLOC___timer1_isr?T1221 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1221 end address is: 4 (R1)
L_timer1_isr358:
; ?FLOC___timer1_isr?T1221 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1221 end address is: 4 (R1)
;botrungtam.c,918 :: 		}
L_timer1_isr356:
L_timer1_isr355:
;botrungtam.c,920 :: 		if(but_status[12]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr359
;botrungtam.c,921 :: 		LED_5_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,922 :: 		out_relay^=RELAY_16;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32768
STR	R0, [R1, #0]
;botrungtam.c,925 :: 		}
IT	AL
BAL	L_timer1_isr360
L_timer1_isr359:
;botrungtam.c,926 :: 		else if(but_status[12]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr361
;botrungtam.c,927 :: 		LED_5_1=(out_relay&RELAY_16)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32768
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr362
; ?FLOC___timer1_isr?T1232 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1232 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr363
L_timer1_isr362:
; ?FLOC___timer1_isr?T1232 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1232 end address is: 4 (R1)
L_timer1_isr363:
; ?FLOC___timer1_isr?T1232 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1232 end address is: 4 (R1)
;botrungtam.c,928 :: 		}
L_timer1_isr361:
L_timer1_isr360:
;botrungtam.c,932 :: 		if(but_status[13]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr364
;botrungtam.c,933 :: 		LED_6_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,934 :: 		out_relay^=RELAY_9;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #256
STR	R0, [R1, #0]
;botrungtam.c,935 :: 		}
IT	AL
BAL	L_timer1_isr365
L_timer1_isr364:
;botrungtam.c,936 :: 		else if(but_status[13]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr366
;botrungtam.c,937 :: 		LED_6_0=(out_relay&RELAY_9)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #256
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr367
; ?FLOC___timer1_isr?T1243 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1243 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr368
L_timer1_isr367:
; ?FLOC___timer1_isr?T1243 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1243 end address is: 4 (R1)
L_timer1_isr368:
; ?FLOC___timer1_isr?T1243 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1243 end address is: 4 (R1)
;botrungtam.c,938 :: 		LED_4_0=LED_6_0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,939 :: 		}
L_timer1_isr366:
L_timer1_isr365:
;botrungtam.c,942 :: 		if(but_status[14]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr369
;botrungtam.c,943 :: 		LED_7_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,944 :: 		MASTER_SWITCH=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_MASTER_SWITCH+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH+0)
STRB	R1, [R0, #0]
;botrungtam.c,946 :: 		}
IT	AL
BAL	L_timer1_isr370
L_timer1_isr369:
;botrungtam.c,947 :: 		else if(but_status[14]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr371
;botrungtam.c,948 :: 		LED_7_0= 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,949 :: 		MASTER_SWITCH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_SWITCH+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH+0)
STRB	R1, [R0, #0]
;botrungtam.c,950 :: 		}
L_timer1_isr371:
L_timer1_isr370:
;botrungtam.c,953 :: 		if(but_status[15]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr372
;botrungtam.c,954 :: 		LED_8_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,955 :: 		out_relay^=RELAY_2;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #2
STR	R0, [R1, #0]
;botrungtam.c,958 :: 		}
IT	AL
BAL	L_timer1_isr373
L_timer1_isr372:
;botrungtam.c,959 :: 		else if(but_status[15]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr374
;botrungtam.c,960 :: 		LED_8_0=(out_relay&RELAY_2)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #2
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr375
; ?FLOC___timer1_isr?T1265 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1265 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr376
L_timer1_isr375:
; ?FLOC___timer1_isr?T1265 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1265 end address is: 4 (R1)
L_timer1_isr376:
; ?FLOC___timer1_isr?T1265 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1265 end address is: 4 (R1)
;botrungtam.c,961 :: 		}
L_timer1_isr374:
L_timer1_isr373:
;botrungtam.c,964 :: 		if(but_status[16]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr377
;botrungtam.c,965 :: 		LED_8_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,966 :: 		out_relay^=RELAY_14;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #8192
STR	R0, [R1, #0]
;botrungtam.c,969 :: 		}
IT	AL
BAL	L_timer1_isr378
L_timer1_isr377:
;botrungtam.c,970 :: 		else if(but_status[16]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr379
;botrungtam.c,971 :: 		LED_8_1=(out_relay&RELAY_14)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #8192
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr380
; ?FLOC___timer1_isr?T1276 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1276 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr381
L_timer1_isr380:
; ?FLOC___timer1_isr?T1276 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1276 end address is: 4 (R1)
L_timer1_isr381:
; ?FLOC___timer1_isr?T1276 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1276 end address is: 4 (R1)
;botrungtam.c,972 :: 		}
L_timer1_isr379:
L_timer1_isr378:
;botrungtam.c,975 :: 		if(but_status[17]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr382
;botrungtam.c,977 :: 		LED_9_0^=1;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,978 :: 		}
IT	AL
BAL	L_timer1_isr383
L_timer1_isr382:
;botrungtam.c,979 :: 		else if(but_status[17]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr384
;botrungtam.c,981 :: 		}
L_timer1_isr384:
L_timer1_isr383:
;botrungtam.c,983 :: 		if(but_status[18]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr385
;botrungtam.c,984 :: 		LED_9_1^=1;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,986 :: 		}
IT	AL
BAL	L_timer1_isr386
L_timer1_isr385:
;botrungtam.c,987 :: 		else if(but_status[18]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr387
;botrungtam.c,989 :: 		}
L_timer1_isr387:
L_timer1_isr386:
;botrungtam.c,992 :: 		if(but_status[19]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr388
;botrungtam.c,993 :: 		if(!DO_NOT_DISTURB)  {
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr389
;botrungtam.c,994 :: 		LED_10_0^=1; // LED MUR port10
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,995 :: 		LED_1_0^=1;  // LED MUR port1
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,996 :: 		}
L_timer1_isr389:
;botrungtam.c,997 :: 		}
IT	AL
BAL	L_timer1_isr390
L_timer1_isr388:
;botrungtam.c,998 :: 		else if(but_status[19]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr391
;botrungtam.c,1000 :: 		}
L_timer1_isr391:
L_timer1_isr390:
;botrungtam.c,1002 :: 		if(but_status[20]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr392
;botrungtam.c,1003 :: 		LED_10_1^=1; // LED DND port10
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1004 :: 		LED_1_1^=1;  // LED DND port1
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1006 :: 		LED_10_0=0; // LED MUR port10 OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1007 :: 		LED_1_0=0;  // LED MUR port1  OFF
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1008 :: 		DO_NOT_DISTURB=(DO_NOT_DISTURB^0x01);
MOVW	R1, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R1, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,1010 :: 		}
IT	AL
BAL	L_timer1_isr393
L_timer1_isr392:
;botrungtam.c,1011 :: 		else if(but_status[20]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr394
;botrungtam.c,1012 :: 		}
L_timer1_isr394:
L_timer1_isr393:
;botrungtam.c,1014 :: 		if(but_status[21]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr395
;botrungtam.c,1015 :: 		LED_11_0^=1;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1017 :: 		}
IT	AL
BAL	L_timer1_isr396
L_timer1_isr395:
;botrungtam.c,1018 :: 		else if(but_status[21]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr397
;botrungtam.c,1020 :: 		}
L_timer1_isr397:
L_timer1_isr396:
;botrungtam.c,1022 :: 		if(but_status[22]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr398
;botrungtam.c,1023 :: 		LED_11_1^=1;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1025 :: 		}
IT	AL
BAL	L_timer1_isr399
L_timer1_isr398:
;botrungtam.c,1026 :: 		else if(but_status[22]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr400
;botrungtam.c,1028 :: 		}
L_timer1_isr400:
L_timer1_isr399:
;botrungtam.c,1035 :: 		if(but_status[23]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr401
;botrungtam.c,1037 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1038 :: 		KEYCARD_INSERT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1039 :: 		}
IT	AL
BAL	L_timer1_isr402
L_timer1_isr401:
;botrungtam.c,1040 :: 		else if(but_status[23]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr403
;botrungtam.c,1042 :: 		KEYCARD_INSERT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1043 :: 		}
L_timer1_isr403:
L_timer1_isr402:
;botrungtam.c,1046 :: 		if(MASTER_SWITCH==1){
MOVW	R0, #lo_addr(_MASTER_SWITCH+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr404
;botrungtam.c,1060 :: 		out_relay&=~RELAY_1;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #1
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1061 :: 		out_relay&=~RELAY_2;
MVN	R0, #2
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1062 :: 		out_relay&=~RELAY_3;
MVN	R0, #4
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1063 :: 		out_relay&=~RELAY_4;
MVN	R0, #8
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1064 :: 		out_relay&=~RELAY_5;
MVN	R0, #16
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1065 :: 		out_relay&=~RELAY_6;
MVN	R0, #32
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1066 :: 		out_relay&=~RELAY_7;
MVN	R0, #64
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1067 :: 		out_relay|=RELAY_8; //SL1 ON WHEN MASTER_SWITCH - COMMAND CONTROL ABOVE PORT7
ORR	R1, R0, #128
STR	R1, [R2, #0]
;botrungtam.c,1068 :: 		out_relay&=~RELAY_16;
MOVW	R0, #32767
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1069 :: 		out_relay&=~RELAY_15;
MVN	R0, #16384
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1070 :: 		out_relay&=~RELAY_14;
MVN	R0, #8192
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1071 :: 		out_relay&=~RELAY_13;
MVN	R0, #4096
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1072 :: 		out_relay&=~RELAY_10;
MVN	R0, #512
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1073 :: 		out_relay&=~RELAY_9;
MVN	R0, #256
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1076 :: 		LED_11_0=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1077 :: 		LED_11_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1078 :: 		LED_9_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1079 :: 		LED_9_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1081 :: 		LED_10_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1082 :: 		LED_10_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1083 :: 		DO_NOT_DISTURB=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
STRB	R1, [R0, #0]
;botrungtam.c,1085 :: 		LED_8_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1086 :: 		LED_8_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1088 :: 		LED_6_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1090 :: 		LED_5_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1091 :: 		LED_5_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1093 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1094 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1096 :: 		LED_3_0=1; // SL1 ON WHEN MASTER_SWITCH - COMMAND CONTROL ABOVE PORT7
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1097 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1099 :: 		LED_2_0=0;    // S1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1100 :: 		LED_2_1=0;    // S2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1101 :: 		LED_2_2=0;    // S5
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1103 :: 		LED_1_0=0;     // MUR LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1104 :: 		LED_1_1=0;     // DND LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1106 :: 		}
L_timer1_isr404:
;botrungtam.c,1110 :: 		xuat_32bit(out_relay);
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
BL	_xuat_32bit+0
;botrungtam.c,1117 :: 		}
L_timer1_isr278:
;botrungtam.c,1118 :: 		}
L_end_timer1_isr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timer1_isr
_uart4_rx:
;botrungtam.c,1121 :: 		void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
;botrungtam.c,1124 :: 		if(UART4_SRbits.RXNE){   // RXNE: Read data register not empty
MOVW	R1, #lo_addr(UART4_SRbits+0)
MOVT	R1, #hi_addr(UART4_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx405
;botrungtam.c,1125 :: 		UART4_SRbits.RXNE=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_SRbits+0)
MOVT	R0, #hi_addr(UART4_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,1126 :: 		data_rc=UART4_DRbits.DR;
MOVW	R0, #lo_addr(UART4_DRbits+0)
MOVT	R0, #hi_addr(UART4_DRbits+0)
LDRH	R0, [R0, #0]
UBFX	R0, R0, #0, #9
; data_rc start address is: 12 (R3)
UXTB	R3, R0
;botrungtam.c,1130 :: 		if(DATA_TRUE){
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx406
;botrungtam.c,1131 :: 		buf_rc_u4[count_buf_rc_4++]=data_rc;
MOVW	R2, #lo_addr(_count_buf_rc_4+0)
MOVT	R2, #hi_addr(_count_buf_rc_4+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
ADDS	R0, R0, R1
STRB	R3, [R0, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;botrungtam.c,1132 :: 		}
L_uart4_rx406:
;botrungtam.c,1133 :: 		if(count_buf_rc_4==0){    // received header
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_uart4_rx407
;botrungtam.c,1134 :: 		if(data_rc==0x4B){    // header is "K"
CMP	R3, #75
IT	NE
BNE	L_uart4_rx408
; data_rc end address is: 12 (R3)
;botrungtam.c,1136 :: 		DATA_TRUE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1138 :: 		}
L_uart4_rx408:
;botrungtam.c,1139 :: 		}
L_uart4_rx407:
;botrungtam.c,1141 :: 		if(count_buf_rc_4>=6){
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L_uart4_rx409
;botrungtam.c,1143 :: 		DATA_TRUE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1145 :: 		PROCESSING_RS485=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,1150 :: 		}
L_uart4_rx409:
;botrungtam.c,1157 :: 		}
L_uart4_rx405:
;botrungtam.c,1159 :: 		}
L_end_uart4_rx:
BX	LR
; end of _uart4_rx
_main:
;botrungtam.c,1162 :: 		void main() {
;botrungtam.c,1170 :: 		gpio_init();
BL	_gpio_init+0
;botrungtam.c,1171 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1172 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1173 :: 		duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1174 :: 		duphong9_C15=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1175 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,1176 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,1179 :: 		delay_ms(1500);
MOVW	R7, #43135
MOVT	R7, #274
NOP
NOP
L_main410:
SUBS	R7, R7, #1
BNE	L_main410
NOP
NOP
NOP
;botrungtam.c,1182 :: 		RESET:
___main_RESET:
;botrungtam.c,1187 :: 		buf_rc_u4[0]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
STRB	R1, [R0, #0]
;botrungtam.c,1188 :: 		buf_rc_u4[1]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+1)
MOVT	R0, #hi_addr(_buf_rc_u4+1)
STRB	R1, [R0, #0]
;botrungtam.c,1189 :: 		buf_rc_u4[2]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+2)
MOVT	R0, #hi_addr(_buf_rc_u4+2)
STRB	R1, [R0, #0]
;botrungtam.c,1190 :: 		buf_rc_u4[3]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
STRB	R1, [R0, #0]
;botrungtam.c,1191 :: 		buf_rc_u4[4]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
STRB	R1, [R0, #0]
;botrungtam.c,1192 :: 		buf_rc_u4[5]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+5)
MOVT	R0, #hi_addr(_buf_rc_u4+5)
STRB	R1, [R0, #0]
;botrungtam.c,1193 :: 		buf_rc_u4[6]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+6)
MOVT	R0, #hi_addr(_buf_rc_u4+6)
STRB	R1, [R0, #0]
;botrungtam.c,1194 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);   // den bao mau xanh da troi Port A12
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1195 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);   //
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1196 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1197 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6);   //
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1198 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);   //
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1199 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);   //
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1200 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);   //
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1201 :: 		STAT=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1202 :: 		duphong66_C9=1;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1203 :: 		duphong67_A8=1;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1204 :: 		duphong87_D6=1;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1205 :: 		duphong88_D7=1;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1206 :: 		duphong89_B3=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1207 :: 		duphong90_B4=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1209 :: 		usart2_init();
BL	_usart2_init+0
;botrungtam.c,1210 :: 		uart4__init();   //baud=57600 rs485 uart 4
BL	_uart4__init+0
;botrungtam.c,1221 :: 		timer1_init();
BL	_timer1_init+0
;botrungtam.c,1222 :: 		memset(but_state,0,24);
MOVS	R2, #24
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
BL	_memset+0
;botrungtam.c,1244 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main412:
SUBS	R7, R7, #1
BNE	L_main412
NOP
NOP
NOP
;botrungtam.c,1245 :: 		duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1247 :: 		RCC_APB1ENR.B11 = 1;            // Enable clock gating for Watchdog Timer 0 module
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;botrungtam.c,1254 :: 		WWDG_CFR = 1;                   // Write window value to be compared to the downcounter
MOVS	R1, #1
MOVW	R0, #lo_addr(WWDG_CFR+0)
MOVT	R0, #hi_addr(WWDG_CFR+0)
STR	R1, [R0, #0]
;botrungtam.c,1257 :: 		while(1){
L_main414:
;botrungtam.c,1259 :: 		if(BELL_ENABLE){
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main416
;botrungtam.c,1260 :: 		BELL_COUNTER++;
MOVW	R2, #lo_addr(_BELL_COUNTER+0)
MOVT	R2, #hi_addr(_BELL_COUNTER+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,1261 :: 		if(BELL_COUNTER>=0x1dffff){
MOVW	R0, #65535
MOVT	R0, #29
CMP	R1, R0
IT	CC
BCC	L_main417
;botrungtam.c,1262 :: 		out_relay&=~RELAY_13;  // TURN OFF BELL
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #4096
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1263 :: 		BELL_COUNTER=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BELL_COUNTER+0)
MOVT	R0, #hi_addr(_BELL_COUNTER+0)
STR	R1, [R0, #0]
;botrungtam.c,1264 :: 		BELL_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1265 :: 		}
L_main417:
;botrungtam.c,1266 :: 		}
L_main416:
;botrungtam.c,1268 :: 		if(KEYCARD_INSERT){
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main418
;botrungtam.c,1269 :: 		KEYCARD_COUNTER++;
MOVW	R1, #lo_addr(_KEYCARD_COUNTER+0)
MOVT	R1, #hi_addr(_KEYCARD_COUNTER+0)
LDR	R0, [R1, #0]
ADDS	R2, R0, #1
STR	R2, [R1, #0]
;botrungtam.c,1270 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1271 :: 		if(KEYCARD_COUNTER>=0x0fff){
MOVW	R0, #4095
CMP	R2, R0
IT	CC
BCC	L_main419
;botrungtam.c,1272 :: 		KEYCARD_COUNTER=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER+0)
STR	R1, [R0, #0]
;botrungtam.c,1273 :: 		if(!KEYCARD_ENABLE){
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main420
;botrungtam.c,1280 :: 		out_relay|=RELAY_12;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #2048
STR	R0, [R1, #0]
;botrungtam.c,1281 :: 		out_relay|=RELAY_11;
ORR	R0, R0, #1024
STR	R0, [R1, #0]
;botrungtam.c,1282 :: 		out_relay|=RELAY_15;
ORR	R0, R0, #16384
STR	R0, [R1, #0]
;botrungtam.c,1283 :: 		out_relay|=RELAY_8;
ORR	R0, R0, #128
STR	R0, [R1, #0]
;botrungtam.c,1284 :: 		LED_3_0=1;  // LED SL1-RELAY-8
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1285 :: 		LED_3_2=1;  // LED S9-RELAY-15
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1287 :: 		KEYCARD_ENABLE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1288 :: 		}
L_main420:
;botrungtam.c,1289 :: 		}
L_main419:
;botrungtam.c,1290 :: 		}
L_main418:
;botrungtam.c,1291 :: 		if(!KEYCARD_INSERT){
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main421
;botrungtam.c,1292 :: 		KEYCARD_COUNTER_CLOSE++;
MOVW	R2, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R2, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,1293 :: 		if(KEYCARD_COUNTER_CLOSE>=0xffffff) {
MVN	R0, #-16777216
CMP	R1, R0
IT	CC
BCC	L_main422
;botrungtam.c,1294 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1295 :: 		KEYCARD_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1297 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,1301 :: 		LED_11_0=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1302 :: 		LED_11_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1303 :: 		LED_9_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1304 :: 		LED_9_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1306 :: 		LED_10_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1307 :: 		LED_10_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1309 :: 		LED_8_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1310 :: 		LED_8_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1312 :: 		LED_6_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1314 :: 		LED_5_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1315 :: 		LED_5_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1317 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1318 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1320 :: 		LED_3_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1321 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1323 :: 		LED_2_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1324 :: 		LED_2_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1325 :: 		LED_2_2=0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1326 :: 		DO_NOT_DISTURB=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
STRB	R1, [R0, #0]
;botrungtam.c,1328 :: 		LED_1_0=0;     // MUR LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1329 :: 		LED_1_1=0;     // DND LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1330 :: 		}
L_main422:
;botrungtam.c,1331 :: 		}
L_main421:
;botrungtam.c,1333 :: 		if(flag_reset_ip==1){
MOVW	R0, #lo_addr(_flag_reset_ip+0)
MOVT	R0, #hi_addr(_flag_reset_ip+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main423
;botrungtam.c,1334 :: 		flag_reset_ip=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_reset_ip+0)
MOVT	R0, #hi_addr(_flag_reset_ip+0)
STRB	R1, [R0, #0]
;botrungtam.c,1335 :: 		goto RESET;
IT	AL
BAL	___main_RESET
;botrungtam.c,1336 :: 		}
L_main423:
;botrungtam.c,1351 :: 		}
IT	AL
BAL	L_main414
;botrungtam.c,1352 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
