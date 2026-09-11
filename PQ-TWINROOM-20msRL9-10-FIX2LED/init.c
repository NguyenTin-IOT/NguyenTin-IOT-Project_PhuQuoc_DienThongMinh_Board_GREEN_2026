#include "init.h"
void xuat_32bit(unsigned long data_dich){
   unsigned char vt_dich=32;
   unsigned long shift_data=data_dich;
   OE=1;
   do{
      vt_dich--;
      DS=(shift_data>>vt_dich);
      xung_dich
   }while(vt_dich>0);
   OE=0;
   xung_xuat
}

void timer1_init(){ //20 ms
    TIM1_CR1bits.DIR_=0;  // directon 0:upcounter, 1: down
    TIM1_CR1bits.ARPE=0; // auto-reload Preload Enable
    TIM1_CR1bits.OPM=0;     // one pulse mode / 0: counter non-stop; 1: stop when CEN bit clear
    TIM1_PSC=10000;  // PRESCALE VALUE(16bit)  frequency = Fclk/(PSC+1)
    TIM1_ARR=144;    // AUTO-RELOAD VALUE
    // 144*10000=1440000 ; 1Mclock = 1/72Mhz = 0.0138888 e-6
    // 1440000* 1Mclock = 0.02 = 20 ms
    TIM1_CNT=0;      // counter value
    TIM1_DIERbits.UIE=1;  // DMA interrup enable Register  - UIE: update interrup enable
    NVIC_SETENA0bits.SETENA25=1;
    NVIC_IP6bits.PRI_25=0x00;
    TIM1_CR1bits.CEN=1;    //1 enable counter
    NVIC_IP8bits.PRI_32=0xf0; // priority
}

void usart1_init(){
     USART1_CR1bits.UE=1; // enable uart1
     USART1_CR1bits.M=0;  // 8bit data
     USART1_CR1bits.PCE=0; // no parity
     USART1_CR1bits.RXNEIE=1;// enable interrupt receiver
     USART1_CR1bits.RE=1; // enable receiver
     USART1_CR1bits.TE=1;  //enable transmitter
     USART1_BRR=0X1D4C;    // bauld=9600;
     USART1_CR2=0;   // 1 stop bit
     USART1_CR3=0;
     // interrupt uart
     NVIC_SETENA1bits.SETENA37=1; //enable interrupt usart
     NVIC_IP11bits.PRI_44=0x10; // priority
}

void uart1_chr(unsigned char data_usart1_tx){
     while(USART1_SRbits.TC==0);
     USART1_DRbits.DR=data_usart1_tx;
}
void uart1_string(unsigned char *s){
     while(*s){
          uart1_chr(*s++);
     }
}

void uart4__init(){
     // init uart
     UART4_CR1bits.UE=1; // enable uart1
     UART4_CR1bits.M=0;  // 8bit data
     UART4_CR1bits.PCE=0; // no parity
     UART4_CR1bits.RXNEIE=1;// enable interrupt receiver
     UART4_CR1bits.RE=1; // enable receiver
     UART4_CR1bits.TE=1;  //enable transmitter
//     UART4_BRR=0X1D4C;   // bauld=9600;
//     UART4_BRR=0X04e2;   // bauld=57600
     UART4_BRR=0X0271;   // bauld=115200
     UART4_CR2=0;   // 1 stop bit
     UART4_CR3=0;
     // interrupt uart
     NVIC_SETENA1bits.SETENA52=1; //enable interrupt usart
     NVIC_IP14bits.PRI_59=0x00; // priority
}

void uart4_chr(unsigned char data_usart4_tx){
     while(UART4_SRbits.TC==0);
     UART4_DRbits.DR=data_usart4_tx;
}

void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
    unsigned char i = 0;
    UART4_CR1bits.RE=0;
    TRAN_4
    for (i = 0; i < count_buf; i++) {
        while(UART4_SRbits.TC==0);
        UART4_DRbits.DR = buf_rs4[i];
//        uart2_chr(buf_rs4[i]);
    }
    while(UART4_SRbits.TC==0);
    REC_4
    UART4_CR1bits.RE=1;
}

void uart4_string(unsigned char *s){
     while(*s){
          uart4_chr(*s++);
     }
}

void usart2_init(){
     USART2_CR1bits.UE=1; // enable uart1
     USART2_BRR=0X1D4C;    // bauld=9600;
     USART2_CR1bits.M=0;  // 8bit data
     USART2_CR1bits.PCE=0; // no parity
     USART2_CR1bits.RXNEIE=1;// enable interrupt receiver
     USART2_CR1bits.RE=1; // enable receiver
     USART2_CR1bits.TE=1;  //enable transmitter
     USART2_CR2=0;   // 1 stop bit
     USART2_CR3=0;
     // interrupt uart
//     NVIC_SETENA1bits.SETENA38=1; //enable interrupt usart
//     NVIC_IP9bits.PRI_38=0x00; // priority
}

void uart2_chr(unsigned char data_usart2_tx){
     while(USART2_SRbits.TC==0);
     USART2_DR=data_usart2_tx;
}
void uart2_string(unsigned char *s){
     while(*s){
          uart2_chr(*s++);
     }
}

void set_value_dim(unsigned char value_dim,unsigned char channel){
    unsigned char data_dim[3]={0xfa,0x00,0x00},k;
    data_dim[1]=channel;
    data_dim[2]=value_dim;
    for(k=0;k<3;k++){
        uart2_chr(data_dim[k]);
    }
}

void gpio_init(){
    RCC_APB2ENR=(1<<AFIOEN)|(1<<IOPAEN)|(1<<IOPBEN)|(1<<IOPCEN)|(1<<IOPDEN)|(1<<IOPEEN)|(1<<TIM1EN)|(1<<SPI1EN)|(1<<USART1EN);
    RCC_APB1ENR=(1<<UART4EN)|(1<<USART2EN);
    //disable jtag
    AFIO_MAPR|=0x02000000;
    //gpioa
    GPIOA_CRL&=0xffff0000;
    GPIOA_CRL|=0x00004938;
    GPIOA_CRH&=0x0ff00000;
    GPIOA_CRH|=0x30003490;
    GPIOA_ODR=0;
    GPIOA_ODR|=0B0000000000000001;
    //gpiob
    GPIOB_CRL&=0x00fff000;
    GPIOB_CRL|=0x38000383;
    GPIOB_CRH=0;
    GPIOB_CRH|=0x83838338;
    GPIOB_ODR=0;
    GPIOB_ODR|=0B1010100101000010;
    //gpioc
    GPIOC_CRL&=0x000f0000;
    GPIOC_CRL|=0x83803838;
    GPIOC_CRH&=0xff0000f0;
    GPIOC_CRH|=0x00234903;
    GPIOC_ODR=0;
    GPIOC_ODR|=0B0000000010100101;
    //gpiod
    GPIOD_CRL&=0xff000000;
    GPIOD_CRL|=0x00833333;
    GPIOD_CRH=0;
    GPIOD_CRH|=0x83838383;
    GPIOD_ODR=0;
    GPIOD_ODR|=0B1010101000100000;
    //gpioe
    GPIOE_CRL=0;
    GPIOE_CRL|=0x88383838;
    GPIOE_CRH=0;
    GPIOE_CRH|=0x83838383;
    GPIOE_ODR=0;
    GPIOE_ODR|=0B1010101011010101;
    GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_7);
}
unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt){
    unsigned char sb;
    unsigned long gt_so;
    gt_so=0;
    for(sb=vt_bd;sb<=vt_kt;sb++){
        gt_so*=10;
        gt_so+=(*(so+sb)-0x30);
    }
    return gt_so;
}
unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end){
    unsigned char locate_point=0;
    for(locate_point=start;locate_point<end;locate_point++){
        if((*(s+start)=='.')||(*(s+start)==' ')){
            break;
        }
        s++;
    }
    return locate_point;
}