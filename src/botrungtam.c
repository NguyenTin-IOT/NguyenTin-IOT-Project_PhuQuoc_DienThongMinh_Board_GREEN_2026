#include "main.h"
                  // RCU PHU QUOC KINGROOM
                  // NO-DIMMER NO-LAN NO-TIMEOUT NO-RS485
                  // KICK_IRF9540
                  // 12 PORT INPUT - 14 RELAY OUT
//PORT1        BELL-OUTSIDE        (1INPUT-3LED)
//        1-LED1_0         L-MUR
//        2-LED1_1         L-DND
//        3-GND
//        4-BUT0
//        5-BUT1
//        6-BUT2                BELL        RL13-C12
//        7-LED1-2        L-BELL
//        8-VIN

//PORT2        DND-MUR-INSIDE        (2INPUT-2LED)
//        1-LED2_0
//        2-LED2_1        L-MUR
//        3-GND
//        4-BUT3
//        5-BUT4          MUR
//        6-BUT5                DND
//        7-LED2-2        L-DND
//        8-VIN

//PORT3        SL1+S9        (2INPUT-2LED)
//        1-LED3_0        L-SL1
//        2-
//        3-GND
//        4-BUT6
//        5-BUT7          SL1          RL8-C1
//        6-BUT8          S9           RL15-C10
//        7-LED3-2        L-S9
//        8-VIN

//PORT4        S3+S4        (2INPUT-2LED)
//        1-LED4_0        L-S3
//        2-LED4_1        L-S4
//        3-GND
//        4-
//        5-BUT9          S3          RL5-C4
//        6-BUT10         S4          RL4-C5
//        7-
//        8-VIN

//PORT5        S7+S8        (2INPUT-2LED)
//        1-LED5_0        L-S7
//        2-LED5_1        L-S8
//        3-GND
//        4-
//        5-BUT11          S7          RL1-C8
//        6-BUT12          S8          RL16-C9
//        7-
//        8-VIN

//PORT6        S3        (1INPUT-1LED)
//        1-LED6_0        L-S3
//        2-
//        3-GND
//        4-
//        5-
//        6-BUT13          S3          RL5-C4
//        7-
//        8-VIN

//PORT7        MASTER        (1INPUT-1LED)
//        1-LED7_0        MASTER
//        2-
//        3-GND
//        4-
//        5-
//        6-BUT14          MASTER          .     ..
//        7-
//        8-VIN

//PORT8        S6+S11        (2INPUT-2LED)
//        1-LED8_0        L-S6
//        2-LED8_1        L-S11
//        3-GND
//        4-
//        5-BUT15          S6          RL2-C7
//        6-BUT16          S11          RL14-C11
//        7-
//        8-VIN

//PORT9        S1+S2        (2INPUT-2LED)
//        1-LED9_0        L-S1
//        2-LED9_1        L-S2
//        3-GND
//        4-
//        5-BUT17          S1          RL7-C2
//        6-BUT18          S2          RL6-C3
//        7-
//        8-VIN

//PORT10        S5+S11        (2INPUT-2LED)
//        1-LED10_0        L-S1
//        2-LED10_1        L-S2
//        3-GND
//        4-
//        5-BUT19          S5          RL3-C6
//        6-BUT20         S11          RL14-C11
//        7-
//        8-VIN

//PORT11        S1+S2        (2INPUT-2LED)
//        1-LED11_0        L-S1
//        2-LED11_1        L-S2
//        3-GND
//        4-
//        5-BUT21          S1          RL7-C2
//        6-BUT22          S2          RL6-C3
//        7-
//        8-VIN

//PORT12        KEYCARD        (1INPUT-1LED)
//        1-LED12_0        KEY(NC)
//        2-
//        3-GND
//        4-
//        5-
//        6-BUT23          KEYCARD          .     ..
//        7-
//        8-VIN

#define SPI_Ethernet_Rst GPIO_BIT(GPIOC, ODR, 4)
#define SPI_Ethernet_CS  GPIO_BIT(GPIOA, ODR, 4)

const unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const unsigned char httpMimeTypeScript[] = "text/plain\n\n";
unsigned char httpMethod[] = "GET /";

const char *LoginPage =
"<html><head></head><title>Login Page</title>\
<h1>PHUQUOC - KINGROOM -\
<br>IP: -\
<br>MAC:-</h1>\
</body></html>\
";

const char *indexPage =
"<html><head>\
";

const char *HomePage =
"<head>\
";

const char *ServicePage =
"</html>\
";

const char *LightingPage =
"</html>\
";

const char *CurtainPage =
"</html>\
";

const char *ScenesPage =
"</html>\
";

const char *Fan_SpeedPage =
"</html>\
";

const char *Dimer_ExtantPage =
"</html>\
";

const char *Device_ExtantPage =
"</html>\
";

const char *SettingPage =
"</html>\
";

unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x00};   // my MAC address
unsigned char   myIpAddr[4] = {192,168,1,120};                   // my IP Address CHO LAN CHAY DAU TIEN

unsigned char   gwIpAddr[4];                    // gateway (router) IP address
unsigned char   ipMask[4]    = {255, 255, 255, 0 };                   // network mask (for example : 255.255.255.0)
unsigned char   dnsIpAddr[4] = {192, 168,  1,  1 };                   // DNS server IP address
unsigned char   getRequest[100];
unsigned char   dyna[40] ;
unsigned char   buf[40];
unsigned char   HOPTEST[16];
unsigned int    index_page=7;   // Page_Device_Extant  _ HOTEL PROJECT
unsigned char   ipAddress[4];
unsigned long Address = 0x08008000,i,temp,checkConnect=0;
unsigned long* ptr;
unsigned char  curtain;
unsigned char flag_all_dimer_percent=0;
unsigned char DELAY_SEND_DIMMER=0;
unsigned char PERCENT_DIMMER=0;
unsigned char DATA_TRUE,PROCESSING_RS485,RESPOND_PROCESSING_RS485;
unsigned char MASTER_SWITCH=0;
unsigned char DO_NOT_DISTURB=0;
unsigned char KEYCARD_ENABLE=0;
unsigned char KEYCARD_INSERT=0;
unsigned long KEYCARD_COUNTER=0;
unsigned long KEYCARD_COUNTER_CLOSE=0;
unsigned long BELL_COUNTER=0;
unsigned char BELL_ENABLE=0;
unsigned char DIM4_EVERGREEN=0;
unsigned char DIM2_EVERGREEN=0;
unsigned char FLAG_CURTAIN_STOP=0;
unsigned long TIME_OUT=0;
unsigned char TIMEOUT_RELAY_1=0;
unsigned char TIMEOUT_RELAY_2=0;
unsigned char TIMEOUT_RELAY_3=0;
unsigned char TIMEOUT_RELAY_4=0;
unsigned char TIMEOUT_RELAY_5=0;
unsigned char TIMEOUT_RELAY_6=0;
unsigned char TIMEOUT_RELAY_7=0;
unsigned char TIMEOUT_RELAY_8=0;
unsigned char TIMEOUT_RELAY_16=0;
unsigned char TIMEOUT_RELAY_15=0;
unsigned char TIMEOUT_RELAY_14=0;
unsigned char TIMEOUT_RELAY_13=0;
unsigned char TIMEOUT_RELAY_12=0;
unsigned char TIMEOUT_RELAY_11=0;
unsigned char TIMEOUT_RELAY_10=0;
unsigned char TIMEOUT_RELAY_9=0;

// Global variables defined in main.h
unsigned char but_sample[24][SAMPLE];
unsigned char but_state[24];
unsigned char but_status[24];
unsigned char but_sum_sample[24];
unsigned int count_time_but2=0;
unsigned char flag_enable_but2=0;
unsigned int flag_but_master=BUT_MASTER_OFF;
unsigned long out_relay=0;
unsigned char buf_rc_u4[6],count_buf_rc_4=0,status_but_touch=0xff,channel_touch=0xff,touch_but=0xff;
unsigned int status_led_touch=0,status_led_touch_save=0;
unsigned char value_dimer=0,count_but_dimer=0,flag_but_dimer=0,value_dimer_save=100,flag_dimer_up_down=DIM_UP;
unsigned long value_count_time_curtain=0;
unsigned char flag_count_curtain=0,flag_curtain_direction=0;
unsigned long count_time_fan=0,flag_count_time_fan=0;
unsigned char flag_fan_speed=0;
unsigned long wed_status_button=0;
unsigned char flag_reset_ip=0,flag_new_rec=0,flag_response_wed=0;
unsigned long status_wed_service=0,status_wed_light=0,status_wed_curtain=0,status_wed_scenes=0;
unsigned long status_wed_fan=0,status_wed_dimer=0;
unsigned char flag_dimer_ex[4]={0,0,0,0};
unsigned char flag_dimer_ex_up_down[4]={DIM_UP_EX,DIM_UP_EX,DIM_UP_EX,DIM_UP_EX};
unsigned long count_time_dimer_ex[4]={0,0,0,0};
unsigned char value_dimer_ex[4]={0,0,0,0};

// ENC28J60 Library Globals & Stubs
SPI_Ethernet_arpCacheStruct SPI_Ethernet_arpCache[3];
unsigned char    SPI_Ethernet_macAddr[6];
unsigned char    SPI_Ethernet_ipAddr[4];
unsigned char    SPI_Ethernet_gwIpAddr[4];
unsigned char    SPI_Ethernet_ipMask[4];
unsigned char    SPI_Ethernet_dnsIpAddr[4];
unsigned char    SPI_Ethernet_rmtIpAddr[4];
unsigned long    SPI_Ethernet_userTimerSec = 0;

__attribute__((weak)) void SPI_Ethernet_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex) {}
__attribute__((weak)) unsigned char SPI_Ethernet_doPacket(void) { return 0; }
__attribute__((weak)) void SPI_Ethernet_putByte(unsigned char b) {}
__attribute__((weak)) void SPI_Ethernet_putBytes(unsigned char *ptr, unsigned int n) {}
__attribute__((weak)) void SPI_Ethernet_putConstBytes(const unsigned char *ptr, unsigned int n) {}
__attribute__((weak)) unsigned int SPI_Ethernet_putConstString(const char *ptr) { return strlen(ptr); }
__attribute__((weak)) unsigned int SPI_Ethernet_putString(char *ptr) { return strlen(ptr); }
__attribute__((weak)) unsigned char SPI_Ethernet_getByte(void) { return 0; }
__attribute__((weak)) void SPI_Ethernet_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n) {}
__attribute__((weak)) void SPI_Ethernet_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr) {}

void settingEthenet(void){
    ptr = (unsigned long*)Address;
    i=*ptr;
    if(i==0xffffffff){
        FLASH_ErasePage(Address);
        FLASH_Write_Word(Address,0xC0A80178);     // 192.168.1.124
    }
    i=0xC0A8017A;
    myIpAddr[0]=i>>24;
    myIpAddr[1]=i>>16;
    myIpAddr[2]=i>>8;
    myIpAddr[3]=i;
    gwIpAddr[0]=myIpAddr[0];
    gwIpAddr[1]=myIpAddr[1];
    gwIpAddr[2]=myIpAddr[2];
    gwIpAddr[3]=1;
    SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
    SPI_Ethernet_confNetwork((char*)ipMask, (char*)gwIpAddr, (char*)dnsIpAddr);
}

void putChar(unsigned char c){
    while((UART4->SR & USART_SR_TC) == 0);
    UART4->DR = c;
}

void saveIP(unsigned char buf[]){
    unsigned long ipWord;
    unsigned char i=0,j;
    while(i<39){
        if(buf[i]=='i'&&buf[i+1]=='p'){
            for(j=0;j<4;j++){
                if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
                    ipAddress[j]=buf[i+4]-48;
                    i+=2;
                }
                else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
                    ipAddress[j]=10*(buf[i+4]-48)+(buf[i+5]-48);
                    i+=3;
                }
                else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
                    ipAddress[j]=100*(buf[i+4]-48)+10*(buf[i+5]-48)+(buf[i+6]-48);
                    i+=4;
                }
            }
            FLASH_ErasePage(Address);
            ipWord=(((unsigned long)ipAddress[0])<<24)|(((unsigned long)ipAddress[1])<<16)|(((unsigned long)ipAddress[2])<<8)|(((unsigned long)ipAddress[3]));
            FLASH_Write_Word(Address,ipWord);
            settingEthenet();
        }
        i++;
    }
}

void copyBuf(unsigned char a[],unsigned char b[],unsigned char size){
    unsigned char index;
    for(index=0;index<size;index++){
        b[index]=a[index];
    }
}

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
    unsigned int len = 0;
    if(localPort != 80) {
        return(0);
    }
    for(len = 0; len < 30; len++) {
        getRequest[len] = SPI_Ethernet_getByte();
    }
    getRequest[len] = 0;

    if(memcmp(getRequest, httpMethod, 5)) {
        return(0);
    }
    if(getRequest[5] == 'v') {

    }
    else if(getRequest[5] == 's') {
        if(isdigit(getRequest[6])){
            switch(chuoi_so(getRequest,6,get_point(getRequest,6,9))){
                case 0:
                    status_wed_service=out_relay;
                    break;
                default:
                    break;
            }
        }
    }
    else {
        STAT = ~STAT;
        len = putConstString((const char*)httpHeader);
        len += putConstString((const char*)httpMimeTypeHTML);
        switch(getRequest[5]) {
            case '1':
                len += putConstString(LoginPage);
                break;
            default:
                status_wed_service=out_relay;
                LongWordToStr(status_wed_service, (char*)dyna);
                len += putString((char*)dyna);
                break;
        }
    }
    return(len);
}

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
    return(0);
}

// Timer1 Interrupt Service Routine (20ms)
void TIM1_UP_IRQHandler(void) {
    if (TIM1->SR & TIM_SR_UIF) {
        TIM1->SR &= ~TIM_SR_UIF;
    }
    unsigned char i_isr=0,but_isr=0;

    but_sample[0][0]=but_sample[0][1];
    but_sample[0][1]=BUT1_0;

    but_sample[1][0]=but_sample[1][1];
    but_sample[1][1]=BUT1_1;

    but_sample[2][0]=but_sample[2][1];
    but_sample[2][1]=BUT1_2;

    but_sample[3][0]=but_sample[3][1];
    but_sample[3][1]=BUT2_0;

    but_sample[4][0]=but_sample[4][1];
    but_sample[4][1]=BUT2_1;

    but_sample[5][0]=but_sample[5][1];
    but_sample[5][1]=BUT2_2;

    but_sample[6][0]=but_sample[6][1];
    but_sample[6][1]=BUT3_0;

    but_sample[7][0]=but_sample[7][1];
    but_sample[7][1]=BUT3_1;

    but_sample[8][0]=but_sample[8][1];
    but_sample[8][1]=BUT3_2;

    but_sample[9][0]=but_sample[9][1];
    but_sample[9][1]=BUT4_0;

    but_sample[10][0]=but_sample[10][1];
    but_sample[10][1]=BUT4_1;

    but_sample[11][0]=but_sample[11][1];
    but_sample[11][1]=BUT5_0;

    but_sample[12][0]=but_sample[12][1];
    but_sample[12][1]=BUT5_1;

    but_sample[13][0]=but_sample[13][1];
    but_sample[13][1]=BUT6_0;

    but_sample[14][0]=but_sample[14][1];
    but_sample[14][1]=BUT7_0;

    but_sample[15][0]=but_sample[15][1];
    but_sample[15][1]=BUT8_0;

    but_sample[16][0]=but_sample[16][1];
    but_sample[16][1]=BUT8_1;

    but_sample[17][0]=but_sample[17][1];
    but_sample[17][1]=BUT9_0;

    but_sample[18][0]=but_sample[18][1];
    but_sample[18][1]=BUT9_1;

    but_sample[19][0]=but_sample[19][1];
    but_sample[19][1]=BUT10_0;

    but_sample[20][0]=but_sample[20][1];
    but_sample[20][1]=BUT10_1;

    but_sample[21][0]=but_sample[21][1];
    but_sample[21][1]=BUT11_0;

    but_sample[22][0]=but_sample[22][1];
    but_sample[22][1]=BUT11_1;

    but_sample[23][0]=but_sample[23][1];
    but_sample[23][1]=BUT12_0;

    for(but_isr=0;but_isr<24;but_isr++){
        but_sum_sample[but_isr]=0;
        for(i_isr=0;i_isr<SAMPLE;i_isr++){
            but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
        }
        if(but_sum_sample[but_isr]==0){
            but_status[but_isr]=UNPRESS;
        }
        if(but_sum_sample[but_isr]==(SAMPLE*PRESS)){
            but_status[but_isr]=PRESS;
        }
        switch(but_state[but_isr]){
            case UNPRESS:
                if(but_status[but_isr]==PRESS){
                    but_state[but_isr]=PRES_DOW;
                }
                break;
            case PRES_DOW:
                if(but_status[but_isr]==PRESS){
                    but_state[but_isr]=PRESSING;
                }
                else{
                    but_state[but_isr]=UNPRESS;
                }
                break;
            case PRESSING:
                if(but_status[but_isr]==UNPRESS){
                    but_state[but_isr]=PRES_UP;
                }
                break;
            case PRES_UP:
                if(but_status[but_isr]==UNPRESS){
                    but_state[but_isr]=UNPRESS;
                }
                else{
                    but_state[but_isr]=PRESSING;
                }
                break;
            default:
                break;
        }
    }

    // BUTTON 2 - MUR (MAKE UP ROOM)
    if(but_state[4]==PRES_DOW){
        if(DO_NOT_DISTURB){
            DO_NOT_DISTURB=0;
            LED_2_2=0;  // DND INSIDE
            LED_1_2=0;  // DND OUTSIDE
        }
        LED_2_1=~LED_2_1;  // MUR INSIDE
        LED_1_0=LED_2_1;   // MUR OUTSIDE
    }

    // BUTTON 5 - DND (DO NOT DISTURB)
    if(but_state[5]==PRES_DOW){
        if(LED_2_1){
            LED_2_1=0;  // MUR INSIDE
            LED_1_0=0;  // MUR OUTSIDE
        }
        DO_NOT_DISTURB=~DO_NOT_DISTURB;
        LED_2_2=DO_NOT_DISTURB;  // DND INSIDE
        LED_1_2=DO_NOT_DISTURB;  // DND OUTSIDE
    }

    // BUTTON 2 - BELL OUTSIDE
    if(but_state[2]==PRES_DOW){
        if(!DO_NOT_DISTURB){
            out_relay|=RELAY_13;  // BELL
            BELL_ENABLE=1;
            BELL_COUNTER=0;
        }
    }

    // BUTTON 7 - SL1 ENTRANCE
    if(but_state[7]==PRES_DOW){
        out_relay^=RELAY_8;
        LED_3_0=~LED_3_0;
    }

    // BUTTON 8 - S9 ENTRANCE (DEN CHIEU TRANH DAUGIUONG)
    if(but_state[8]==PRES_DOW){
        out_relay^=RELAY_15;
        LED_3_2=~LED_3_2;
    }

    // BUTTON 9 - S3 (LIGHT S3 PORT4 - DEN TRAN TOILET & VANITY & BON TAM) [FIX2LED]
    if(but_state[9]==PRES_DOW){
        out_relay^=RELAY_9;
        LED_4_0=~LED_4_0;
        LED_6_0=LED_4_0;
    }

    // BUTTON 10 - S4 (LIGHT S4 PORT4 - DEN TRANG TRI TOILET) [FIX2LED]
    if(but_state[10]==PRES_DOW){
        out_relay^=RELAY_10;
        LED_4_1=~LED_4_1;
    }

    // BUTTON 13 - S3 (LIGHT S3 PORT6 DAO CHIEU TOILET) [FIX2LED]
    if(but_state[13]==PRES_DOW){
        out_relay^=RELAY_9;
        LED_6_0=~LED_6_0;
        LED_4_0=LED_6_0;
    }

    // BUTTON 11 - S7 (DEN BAN CONG)
    if(but_state[11]==PRES_DOW){
        out_relay^=RELAY_1;
        LED_5_0=~LED_5_0;
    }

    // BUTTON 12 - S8 (DEN BAN LAM VIEC)
    if(but_state[12]==PRES_DOW){
        out_relay^=RELAY_16;
        LED_5_1=~LED_5_1;
    }

    // BUTTON 14 - MASTER (PORT7 BEDSIDE RIGHT - TURN OFF ALL ROOM LIGHTS EXCEPT SL1) [FIX2LED]
    if(but_state[14]==PRES_DOW){
        out_relay&=~RELAY_1;
        out_relay&=~RELAY_2;
        out_relay&=~RELAY_3;
        out_relay&=~RELAY_4;
        out_relay&=~RELAY_5;
        out_relay&=~RELAY_6;
        out_relay&=~RELAY_7;
        out_relay|=RELAY_8;  // BAT DEN SANH SL1 WHEN MASTER PRESS
        out_relay&=~RELAY_9;
        out_relay&=~RELAY_10;
        out_relay&=~RELAY_13;
        out_relay&=~RELAY_14;
        out_relay&=~RELAY_15;
        out_relay&=~RELAY_16;

        LED_11_0=0; LED_11_1=0;
        LED_9_0=0;  LED_9_1=0;
        LED_10_0=0; LED_10_1=0;
        LED_8_0=0;  LED_8_1=0;
        LED_6_0=0;
        LED_5_0=0;  LED_5_1=0;
        LED_4_0=0;  LED_4_1=0;
        LED_3_0=1;  // LED SL1 ON
        LED_3_2=0;
        LED_2_1=0;  LED_2_2=0; DO_NOT_DISTURB=0;
        LED_1_0=0;  LED_1_2=0;
        LED_7_0=1;
    }
    else if(but_state[14]==PRES_UP){
        LED_7_0=0;
    }

    // BUTTON 15 - S6 (PORT8)
    if(but_state[15]==PRES_DOW){
        out_relay^=RELAY_2;
        LED_8_0=~LED_8_0;
    }

    // BUTTON 16 - S11 (PORT8)
    if(but_state[16]==PRES_DOW){
        out_relay^=RELAY_14;
        LED_8_1=~LED_8_1;
        LED_10_1=LED_8_1;
    }

    // BUTTON 17 - S1 (PORT9)
    if(but_state[17]==PRES_DOW){
        out_relay^=RELAY_7;
        LED_9_0=~LED_9_0;
        LED_11_0=LED_9_0;
    }

    // BUTTON 18 - S2 (PORT9)
    if(but_state[18]==PRES_DOW){
        out_relay^=RELAY_6;
        LED_9_1=~LED_9_1;
        LED_11_1=LED_9_1;
    }

    // BUTTON 19 - S5 (PORT10)
    if(but_state[19]==PRES_DOW){
        out_relay^=RELAY_3;
        LED_10_0=~LED_10_0;
    }

    // BUTTON 20 - S11 (PORT10)
    if(but_state[20]==PRES_DOW){
        out_relay^=RELAY_14;
        LED_10_1=~LED_10_1;
        LED_8_1=LED_10_1;
    }

    // BUTTON 21 - S1 (PORT11)
    if(but_state[21]==PRES_DOW){
        out_relay^=RELAY_7;
        LED_11_0=~LED_11_0;
        LED_9_0=LED_11_0;
    }

    // BUTTON 22 - S2 (PORT11)
    if(but_state[22]==PRES_DOW){
        out_relay^=RELAY_6;
        LED_11_1=~LED_11_1;
        LED_9_1=LED_11_1;
    }

    // BUTTON 23 - KEYCARD (PORT12)
    if(but_state[23]==PRES_DOW){
        KEYCARD_INSERT=1;
    }
    if(but_state[23]==PRES_UP){
        KEYCARD_INSERT=0;
    }

    xuat_32bit(out_relay);
}

// UART4 RX Interrupt Handler
void UART4_IRQHandler(void) {
    unsigned char data_rc;
    if(UART4->SR & USART_SR_RXNE){
        UART4->SR &= ~USART_SR_RXNE;
        data_rc = (unsigned char)(UART4->DR & 0xFF);

        if(DATA_TRUE){
            buf_rc_u4[count_buf_rc_4++]=data_rc;
        }
        if(count_buf_rc_4==0){
            if(data_rc==0x4B){
                DATA_TRUE=1;
            }
        }

        if(count_buf_rc_4>=6){
            DATA_TRUE=0;
            PROCESSING_RS485=1;
        }
    }
}

int main(void) {
    gpio_init();
    duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
    duphong9_C15=0;
    out_relay=0b00000000000000000000000000000000;
    xuat_32bit(out_relay);

    delay_ms(1500);

RESET:
    buf_rc_u4[0]=0;
    buf_rc_u4[1]=0;
    buf_rc_u4[2]=0;
    buf_rc_u4[3]=0;
    buf_rc_u4[4]=0;
    buf_rc_u4[5]=0;
    buf_rc_u4[6]=0;

    STAT=1;
    duphong66_C9=1;
    duphong67_A8=1;
    duphong87_D6=1;
    duphong88_D7=1;
    duphong89_B3=1;
    duphong90_B4=1;

    usart2_init();
    uart4__init();   // baud=115200 rs485 uart 4
    timer1_init();
    memset(but_state,0,24);

    delay_ms(1000);
    duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12V
    
    RCC->APB1ENR |= RCC_APB1ENR_WWDGEN;
    WWDG->CFR = 1;

    while(1){
        if(BELL_ENABLE){
            BELL_COUNTER++;
            if(BELL_COUNTER>=0x1dffff){
                out_relay&=~RELAY_13;  // TURN OFF BELL
                BELL_COUNTER=0;
                BELL_ENABLE=0;
            }
        }
        if(KEYCARD_INSERT){
            KEYCARD_COUNTER++;
            KEYCARD_COUNTER_CLOSE=0;
            if(KEYCARD_COUNTER>=0xff){
                if(!KEYCARD_ENABLE){
                    out_relay|=RELAY_12;
                    out_relay|=RELAY_11;
                    out_relay|=RELAY_15;
                    out_relay|=RELAY_8;
                    LED_3_0=1;  // LED SL1-RELAY-8
                    LED_3_2=1;  // LED S9-RELAY-15
                    KEYCARD_COUNTER=0;
                    KEYCARD_ENABLE=1;
                }
            }
        }
        if(!KEYCARD_INSERT){
            KEYCARD_COUNTER_CLOSE++;
            if(KEYCARD_COUNTER_CLOSE>=0xffffff) {
                KEYCARD_COUNTER_CLOSE=0;
                KEYCARD_ENABLE=0;
                out_relay=0;
                LED_11_0=0;
                LED_11_1=0;
                LED_9_0=0;
                LED_9_1=0;
                LED_10_0=0;
                LED_10_1=0;
                LED_8_0=0;
                LED_8_1=0;
                LED_6_0=0;
                LED_5_0=0;
                LED_5_1=0;
                LED_4_0=0;
                LED_4_1=0;
                LED_3_0=0;
                LED_3_2=0;
                LED_2_1=0;     // MUR LED
                LED_2_2=0;     // DND LED
                DO_NOT_DISTURB=0;
                LED_1_0=0;     // MUR LED
                LED_1_2=0;     // DND LED
            }
        }

        if(flag_reset_ip==1){
            flag_reset_ip=0;
            goto RESET;
        }
    }
    return 0;
}