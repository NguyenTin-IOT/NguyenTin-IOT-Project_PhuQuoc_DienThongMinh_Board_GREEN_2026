#ifndef MAIN_H
#define MAIN_H

#include "init.h"
#include "__EthEnc28j60.h"

// Chân GPIO và Relay đã được tập trung tại pin_config.h (đã được include qua init.h)

//scan button
#define SAMPLE      2
#define SUM_BUT     24
#define PRESS       2
#define UNPRESS     0
#define PRE_PRESS   3
#define PRES_UP     4
#define PRES_DOW    5
#define PRESSING    6
extern unsigned char but_sample[24][SAMPLE];
extern unsigned char but_state[24];
extern unsigned char but_status[24];
extern unsigned char but_sum_sample[24];

#define DIM_UP          0
#define DIM_DOWN        1
// process button
#define BUT_ACTIVE      1
#define BUT_UNACTIVE    0
#define BUT_MASTER_ON   1
#define BUT_MASTER_OFF  2
extern unsigned int count_time_but2;
extern unsigned char flag_enable_but2;
extern unsigned int flag_but_master;

// touch_panel
#define SERVICE_1   0X0A
#define SERVICE_2   0x0B
#define ENTRANCE    0X06
#define MASTER      0X05
#define LIGHT_BATH        0X03
#define LIGHT_READING     0X00
#define LIGHT_BEDSIDE     0X0F
#define CURTAIN_O   0X09
#define CURTAIN_C   0X08
#define S_RELAX       0X0C
#define S_NIGHT       0X0D
#define S_PARTY       0X0E
#define FAN_ON_OFF  0X07
#define FAN_LOW     0X04
#define FAN_MEDIUM  0X02
#define FAN_HIGHT   0X01

#define T_PRESS       0
#define T_UNPRESS     1

#define CUR_CLOSE   0b00000000000000000000000100000000
#define FAN_L       0b00000000000000000000001000000000
#define FAN_M       0b00000000000000000000010000000000
#define FAN_H       0b00000000000000000000100000000000

#define RELAY_17    0b00000000000000010000000000000000
#define RELAY_18    0b00000000000001000000000000000000
#define RELAY_19    0b00000000000001000000000000000000
#define RELAY_20    0b00000000000010000000000000000000
#define RELAY_21    0b00000000000100000000000000000000
#define RELAY_22    0b00000000001000000000000000000000
#define RELAY_23    0b00000000010000000000000000000000
#define RELAY_24    0b00000000100000000000000000000000
#define RELAY_25    0b00000001000000000000000000000000
#define RELAY_26    0b00000010000000000000000000000000
#define RELAY_27    0b00000100000000000000000000000000
#define RELAY_28    0b00001000000000000000000000000000
#define RELAY_29    0b00010000000000000000000000000000
#define RELAY_30    0b00100000000000000000000000000000
#define RELAY_31    0b01000000000000000000000000000000
#define RELAY_32    0b10000000000000000000000000000000
extern unsigned long out_relay;
//touch
extern unsigned char buf_rc_u4[6],count_buf_rc_4,status_but_touch,channel_touch,touch_but;
extern unsigned int status_led_touch,status_led_touch_save;
//dimer
#define     STEP_INC_20     51  //ms
#define     STEP_INC_40     52
#define     STEP_INC_60     53
#define     STEP_INC_80     54
#define     STEP_INC_100     55
#define     STEP_INC_120     56
#define     STEP_INC_140     57
#define     STEP_INC_160     58
#define     STEP_INC_180     59
#define     STEP_INC_200     60

extern unsigned char value_dimer,count_but_dimer,flag_but_dimer,value_dimer_save,flag_dimer_up_down;
//curtain
#define CUR_DIR_OPEN    1
#define CUR_DIR_CLOSE   2
extern unsigned long value_count_time_curtain;
extern unsigned char flag_count_curtain,flag_curtain_direction;
//fan
#define FAN_SP_L        1
#define FAN_SP_M        2
#define FAN_SP_H        3

extern unsigned long count_time_fan,flag_count_time_fan;
extern unsigned char flag_fan_speed;
//wed
#define putConstString  SPI_Ethernet_putConstString
#define putString       SPI_Ethernet_putString
#define PORT            60
extern unsigned long wed_status_button;
extern unsigned char flag_reset_ip,flag_new_rec,flag_response_wed;
extern unsigned long status_wed_service,status_wed_light,status_wed_curtain,status_wed_scenes;
extern unsigned long status_wed_fan,status_wed_dimer;

enum page{
    Page_Login=0,
    Page_Service,
    Page_Lighting,
    Page_Curtain,
    Page_Scenes,
    Page_Fan_Speed,
    Page_Dimer_Extant,
    Page_Device_Extant,
    Page_Setting,
    Page_Home,
    Page_Info,
    Page_Erro
};

void response_touch(unsigned int status_response);
void process_touch(void);
//dimer ex
#define DIM_UP_EX   1
#define DIM_DOWN_EX 2
#define DIM_EN_EX      1
#define DIM_DE_EX      2

extern unsigned char flag_dimer_ex[4];
extern unsigned char flag_dimer_ex_up_down[4];
extern unsigned long count_time_dimer_ex[4];
extern unsigned char value_dimer_ex[4];

#endif // MAIN_H