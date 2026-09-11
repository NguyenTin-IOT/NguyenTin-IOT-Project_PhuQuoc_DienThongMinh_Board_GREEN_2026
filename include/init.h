#ifndef INIT_H
#define INIT_H

#include "mikroc_compat.h"
#include "pin_config.h"

void xuat_32bit(unsigned long data_dich);
void usart1_init(void);
void uart1_chr(unsigned char data_usart1_tx);
void uart1_string(unsigned char *s);
void usart2_init(void);
void uart2_chr(unsigned char data_usart2_tx);
void uart2_string(unsigned char *s);
void uart4__init(void);
void uart4_chr(unsigned char data_usart4_tx);
void uart4_string(unsigned char *s);
void timer1_init(void);
void gpio_init(void);
void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf);
void set_value_dim(unsigned char value_dim,unsigned char channel);
unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt);
unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end);

#endif // INIT_H