#include "init.h"

void xuat_32bit(unsigned long data_dich){
   unsigned char vt_dich=32;
   unsigned long shift_data=data_dich;
   OE=1;
   do{
      vt_dich--;
      DS=(shift_data>>vt_dich)&1;
      xung_dich
   }while(vt_dich>0);
   OE=0;
   xung_xuat
}

void timer1_init(){ //20 ms
    RCC->APB2ENR |= RCC_APB2ENR_TIM1EN;
    TIM1->CR1 &= ~(TIM_CR1_DIR | TIM_CR1_ARPE | TIM_CR1_OPM);
    TIM1->PSC = 10000;  // PRESCALE VALUE(16bit)  frequency = Fclk/(PSC+1)
    TIM1->ARR = 144;    // AUTO-RELOAD VALUE
    TIM1->CNT = 0;      // counter value
    TIM1->DIER |= TIM_DIER_UIE;  // Update interrupt enable
    NVIC_SetPriority(TIM1_UP_IRQn, 0);
    NVIC_EnableIRQ(TIM1_UP_IRQn);
    TIM1->CR1 |= TIM_CR1_CEN;    // enable counter
}

void usart1_init(){
     RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
     USART1->CR1 = USART_CR1_UE | USART_CR1_RXNEIE | USART_CR1_RE | USART_CR1_TE;
     USART1->BRR = 0X1D4C;    // baud=9600
     USART1->CR2 = 0;   // 1 stop bit
     USART1->CR3 = 0;
     NVIC_SetPriority(USART1_IRQn, 1);
     NVIC_EnableIRQ(USART1_IRQn);
}

void uart1_chr(unsigned char data_usart1_tx){
     while((USART1->SR & USART_SR_TC) == 0);
     USART1->DR = data_usart1_tx;
}

void uart1_string(unsigned char *s){
     while(*s){
          uart1_chr(*s++);
     }
}

void uart4__init(){
     RCC->APB1ENR |= RCC_APB1ENR_UART4EN;
     UART4->CR1 = USART_CR1_UE | USART_CR1_RXNEIE | USART_CR1_RE | USART_CR1_TE;
     UART4->BRR = 0X0271;   // baud=115200
     UART4->CR2 = 0;   // 1 stop bit
     UART4->CR3 = 0;
     NVIC_SetPriority(UART4_IRQn, 0);
     NVIC_EnableIRQ(UART4_IRQn);
}

void uart4_chr(unsigned char data_usart4_tx){
     while((UART4->SR & USART_SR_TC) == 0);
     UART4->DR = data_usart4_tx;
}

void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
    unsigned char i = 0;
    UART4->CR1 &= ~USART_CR1_RE;
    TRAN_4
    for (i = 0; i < count_buf; i++) {
        while((UART4->SR & USART_SR_TC) == 0);
        UART4->DR = buf_rs4[i];
    }
    while((UART4->SR & USART_SR_TC) == 0);
    REC_4
    UART4->CR1 |= USART_CR1_RE;
}

void uart4_string(unsigned char *s){
     while(*s){
          uart4_chr(*s++);
     }
}

void usart2_init(){
     RCC->APB1ENR |= RCC_APB1ENR_USART2EN;
     USART2->CR1 = USART_CR1_UE | USART_CR1_RXNEIE | USART_CR1_RE | USART_CR1_TE;
     USART2->BRR = 0X1D4C;    // baud=9600
     USART2->CR2 = 0;   // 1 stop bit
     USART2->CR3 = 0;
     NVIC_SetPriority(USART2_IRQn, 0);
     NVIC_EnableIRQ(USART2_IRQn);
}

void uart2_chr(unsigned char data_usart2_tx){
     while((USART2->SR & USART_SR_TC) == 0);
     USART2->DR = data_usart2_tx;
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
    RCC->APB2ENR |= RCC_APB2ENR_AFIOEN | RCC_APB2ENR_IOPAEN | RCC_APB2ENR_IOPBEN | RCC_APB2ENR_IOPCEN | RCC_APB2ENR_IOPDEN | RCC_APB2ENR_IOPEEN | RCC_APB2ENR_TIM1EN | RCC_APB2ENR_SPI1EN | RCC_APB2ENR_USART1EN;
    RCC->APB1ENR |= RCC_APB1ENR_UART4EN | RCC_APB1ENR_USART2EN;
    // disable jtag
    AFIO->MAPR |= 0x02000000;
    // gpioa
    GPIOA->CRL = (GPIOA->CRL & 0xffff0000) | 0x00004938;
    GPIOA->CRH = (GPIOA->CRH & 0x0ff00000) | 0x30003490;
    GPIOA->ODR = 0B0000000000000001;
    // gpiob
    GPIOB->CRL = (GPIOB->CRL & 0x00fff000) | 0x38000383;
    GPIOB->CRH = 0x83838338;
    GPIOB->ODR = 0B1010100101000010;
    // gpioc
    GPIOC->CRL = (GPIOC->CRL & 0x000f0000) | 0x83803838;
    GPIOC->CRH = (GPIOC->CRH & 0xff0000f0) | 0x00234903;
    GPIOC->ODR = 0B0000000010100101;
    // gpiod
    GPIOD->CRL = (GPIOD->CRL & 0xff000000) | 0x00833333;
    GPIOD->CRH = 0x83838383;
    GPIOD->ODR = 0B1010101000100000;
    // gpioe
    GPIOE->CRL = 0x88383838;
    GPIOE->CRH = 0x83838383;
    GPIOE->ODR = 0B1010101011010101;
    // PD7 Input
    GPIOD->CRL = (GPIOD->CRL & ~(0xFUL << 28)) | (0x8UL << 28);
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