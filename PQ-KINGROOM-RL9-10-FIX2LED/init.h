// RS485_1
#define DE1         GPIOA_ODR.B11
#define TRAN_1        DE1=1;
#define REC_1         DE1=0;

// RS485_4
#define DE4         GPIOA_ODR.B15
#define TRAN_4        DE4=1;
#define REC_4         DE4=0;

//595
#define DS          GPIOD_ODR.B2
#define OE          GPIOD_ODR.B1
#define ST_CP       GPIOD_ODR.B0
#define SH_CP       GPIOC_ODR.B12
#define xung_dich   SH_CP=0;SH_CP=1;
#define xung_xuat   ST_CP=0;ST_CP=1;

void xuat_32bit(unsigned long data_dich);
void usart1_init();
void uart1_chr(unsigned char data_usart1_tx);
void uart1_string(unsigned char *s);
void usart2_init();
void uart2_chr(unsigned char data_usart2_tx);
void uart2_string(unsigned char *s);
void uart4__init();
void uart4_chr(unsigned char data_usart4_tx);
void uart4_string(unsigned char *s);
void timer1_init();
void gpio_init();
void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf);
void set_value_dim(unsigned char value_dim,unsigned char channel);
unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt);
unsigned int get_point(unsigned char *s,unsigned int start,unsigned int end);