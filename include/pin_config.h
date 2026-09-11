#ifndef PIN_CONFIG_H
#define PIN_CONFIG_H

#include "mikroc_compat.h"

/*
================================================================================
  CẤU HÌNH TỔNG THỂ CHÂN GPIO (INPUT / OUTPUT) & RELAY DỰ ÁN RCU STM32F103
  File này tập trung tất cả các số chân GPIO của hệ thống RCU KingRoom Phu Quoc.
  Tất cả các số chân Input/Output khi cần thay đổi trong tình huống cấp bách
  CHỈ CẦN CHỈNH SỬA TẠI FILE NÀY!
================================================================================
*/

// =============================================================================
// 1. CHÂN ĐIỀU KHIỂN IC DỊCH 74HC595 (XUẤT RELAY 32-BIT)
// =============================================================================
#define DS_PORT          GPIOD
#define DS_PIN           2
#define DS               GPIO_BIT(DS_PORT, ODR, DS_PIN)

#define OE_PORT          GPIOD
#define OE_PIN           1
#define OE               GPIO_BIT(OE_PORT, ODR, OE_PIN)

#define ST_CP_PORT       GPIOD
#define ST_CP_PIN        0
#define ST_CP            GPIO_BIT(ST_CP_PORT, ODR, ST_CP_PIN)

#define SH_CP_PORT       GPIOC
#define SH_CP_PIN        12
#define SH_CP            GPIO_BIT(SH_CP_PORT, ODR, SH_CP_PIN)

#define xung_dich        SH_CP = 0; SH_CP = 1;
#define xung_xuat        ST_CP = 0; ST_CP = 1;

// =============================================================================
// 2. CHÂN HƯỚNG TRUYỀN THÔNG RS485 (DE / RE)
// =============================================================================
#define DE1_PORT         GPIOA
#define DE1_PIN          11
#define DE1              GPIO_BIT(DE1_PORT, ODR, DE1_PIN)
#define TRAN_1           DE1 = 1;
#define REC_1            DE1 = 0;

#define DE4_PORT         GPIOA
#define DE4_PIN          15
#define DE4              GPIO_BIT(DE4_PORT, ODR, DE4_PIN)
#define TRAN_4           DE4 = 1;
#define REC_4            DE4 = 0;

// =============================================================================
// 3. CHÂN KÍCH MOSFET 12V & LED TRẠNG THÁI BO MẠCH
// =============================================================================
#define MOSFET_C14_PORT  GPIOC
#define MOSFET_C14_PIN   14
#define duphong8_C14     GPIO_BIT(MOSFET_C14_PORT, ODR, MOSFET_C14_PIN)

#define MOSFET_C15_PORT  GPIOC
#define MOSFET_C15_PIN   15
#define duphong9_C15     GPIO_BIT(MOSFET_C15_PORT, ODR, MOSFET_C15_PIN)

#define STAT_PORT        GPIOA
#define STAT_PIN         12
#define STAT             GPIO_BIT(STAT_PORT, ODR, STAT_PIN)

#define DUPHONG_C9_PORT  GPIOC
#define DUPHONG_C9_PIN   9
#define duphong66_C9     GPIO_BIT(DUPHONG_C9_PORT, ODR, DUPHONG_C9_PIN)

#define DUPHONG_A8_PORT  GPIOA
#define DUPHONG_A8_PIN   8
#define duphong67_A8     GPIO_BIT(DUPHONG_A8_PORT, ODR, DUPHONG_A8_PIN)

#define DUPHONG_D6_PORT  GPIOD
#define DUPHONG_D6_PIN   6
#define duphong87_D6     GPIO_BIT(DUPHONG_D6_PORT, ODR, DUPHONG_D6_PIN)

#define DUPHONG_D7_PORT  GPIOD
#define DUPHONG_D7_PIN   7
#define duphong88_D7     GPIO_BIT(DUPHONG_D7_PORT, ODR, DUPHONG_D7_PIN)

#define DUPHONG_B3_PORT  GPIOB
#define DUPHONG_B3_PIN   3
#define duphong89_B3     GPIO_BIT(DUPHONG_B3_PORT, ODR, DUPHONG_B3_PIN)

#define DUPHONG_B4_PORT  GPIOB
#define DUPHONG_B4_PIN   4
#define duphong90_B4     GPIO_BIT(DUPHONG_B4_PORT, ODR, DUPHONG_B4_PIN)

// =============================================================================
// 4. MA TRẬN CHÂN CỔNG CÔNG TẮC PORT 1 ĐẾN PORT 12 (INPUT & LED OUTPUT)
// =============================================================================

// ----- PORT 1: CHUÔNG CỬA NGOÀI PHÒNG (1 INPUT BELL, 3 LED: MUR, DND, BELL) -----
#define PORT1_BUT0_PORT  GPIOE
#define PORT1_BUT0_PIN   2
#define BUT1_0           GPIO_BIT(PORT1_BUT0_PORT, IDR, PORT1_BUT0_PIN)

#define PORT1_BUT1_PORT  GPIOE
#define PORT1_BUT1_PIN   4
#define BUT1_1           GPIO_BIT(PORT1_BUT1_PORT, IDR, PORT1_BUT1_PIN)

#define PORT1_BUT2_PORT  GPIOE
#define PORT1_BUT2_PIN   6
#define BUT1_2           GPIO_BIT(PORT1_BUT2_PORT, IDR, PORT1_BUT2_PIN) // Nút nhấn Chuông ngoài (BELL)

#define PORT1_LED0_PORT  GPIOE
#define PORT1_LED0_PIN   3
#define LED_1_0          GPIO_BIT(PORT1_LED0_PORT, ODR, PORT1_LED0_PIN) // LED báo MUR (Outside)

#define PORT1_LED1_PORT  GPIOE
#define PORT1_LED1_PIN   5
#define LED_1_1          GPIO_BIT(PORT1_LED1_PORT, ODR, PORT1_LED1_PIN) // LED báo DND (Outside)

#define PORT1_LED2_PORT  GPIOC
#define PORT1_LED2_PIN   13
#define LED_1_2          GPIO_BIT(PORT1_LED2_PORT, ODR, PORT1_LED2_PIN) // LED báo BELL (Outside)


// ----- PORT 2: BẢNG DND / MUR TRONG PHÒNG (2 INPUT, 2 LED) -----
#define PORT2_BUT0_PORT  GPIOC
#define PORT2_BUT0_PIN   0
#define BUT2_0           GPIO_BIT(PORT2_BUT0_PORT, IDR, PORT2_BUT0_PIN)

#define PORT2_BUT1_PORT  GPIOC
#define PORT2_BUT1_PIN   2
#define BUT2_1           GPIO_BIT(PORT2_BUT1_PORT, IDR, PORT2_BUT1_PIN) // Nút MUR trong phòng

#define PORT2_BUT2_PORT  GPIOA
#define PORT2_BUT2_PIN   0
#define BUT2_2           GPIO_BIT(PORT2_BUT2_PORT, IDR, PORT2_BUT2_PIN) // Nút DND trong phòng

#define PORT2_LED0_PORT  GPIOC
#define PORT2_LED0_PIN   1
#define LED_2_0          GPIO_BIT(PORT2_LED0_PORT, ODR, PORT2_LED0_PIN)

#define PORT2_LED1_PORT  GPIOC
#define PORT2_LED1_PIN   3
#define LED_2_1          GPIO_BIT(PORT2_LED1_PORT, ODR, PORT2_LED1_PIN) // LED MUR (Inside)

#define PORT2_LED2_PORT  GPIOA
#define PORT2_LED2_PIN   1
#define LED_2_2          GPIO_BIT(PORT2_LED2_PORT, ODR, PORT2_LED2_PIN) // LED DND (Inside)


// ----- PORT 3: CÔNG TẮC SẢNH SL1 + S9 (2 INPUT, 2 LED) -----
#define PORT3_BUT0_PORT  GPIOC
#define PORT3_BUT0_PIN   5
#define BUT3_0           GPIO_BIT(PORT3_BUT0_PORT, IDR, PORT3_BUT0_PIN)

#define PORT3_BUT1_PORT  GPIOB
#define PORT3_BUT1_PIN   1
#define BUT3_1           GPIO_BIT(PORT3_BUT1_PORT, IDR, PORT3_BUT1_PIN) // Nút SL1 (Đèn Sảnh)

#define PORT3_BUT2_PORT  GPIOE
#define PORT3_BUT2_PIN   7
#define BUT3_2           GPIO_BIT(PORT3_BUT2_PORT, IDR, PORT3_BUT2_PIN) // Nút S9 (Đèn Tranh)

#define PORT3_LED0_PORT  GPIOB
#define PORT3_LED0_PIN   0
#define LED_3_0          GPIO_BIT(PORT3_LED0_PORT, ODR, PORT3_LED0_PIN) // LED SL1

#define PORT3_LED2_PORT  GPIOB
#define PORT3_LED2_PIN   2
#define LED_3_2          GPIO_BIT(PORT3_LED2_PORT, ODR, PORT3_LED2_PIN) // LED S9


// ----- PORT 4: CÔNG TẮC TOILET S3 + S4 (2 INPUT, 3 LED) -----
#define PORT4_BUT0_PORT  GPIOE
#define PORT4_BUT0_PIN   9
#define BUT4_0           GPIO_BIT(PORT4_BUT0_PORT, IDR, PORT4_BUT0_PIN) // Nút S3 (Đèn Trần Toilet/Vanity)

#define PORT4_BUT1_PORT  GPIOE
#define PORT4_BUT1_PIN   11
#define BUT4_1           GPIO_BIT(PORT4_BUT1_PORT, IDR, PORT4_BUT1_PIN) // Nút S4 (Đèn Trang Trí Toilet)

#define PORT4_LED0_PORT  GPIOE
#define PORT4_LED0_PIN   8
#define LED_4_0          GPIO_BIT(PORT4_LED0_PORT, ODR, PORT4_LED0_PIN) // LED S3

#define PORT4_LED1_PORT  GPIOE
#define PORT4_LED1_PIN   10
#define LED_4_1          GPIO_BIT(PORT4_LED1_PORT, ODR, PORT4_LED1_PIN) // LED S4

#define PORT4_LED2_PORT  GPIOE
#define PORT4_LED2_PIN   12
#define LED_4_2          GPIO_BIT(PORT4_LED2_PORT, ODR, PORT4_LED2_PIN)


// ----- PORT 5: CÔNG TẮC BAN CÔNG & BÀN LÀM VIỆC S7 + S8 (2 INPUT, 2 LED) -----
#define PORT5_BUT0_PORT  GPIOE
#define PORT5_BUT0_PIN   13
#define BUT5_0           GPIO_BIT(PORT5_BUT0_PORT, IDR, PORT5_BUT0_PIN) // Nút S7 (Đèn Ban Công)

#define PORT5_BUT1_PORT  GPIOE
#define PORT5_BUT1_PIN   15
#define BUT5_1           GPIO_BIT(PORT5_BUT1_PORT, IDR, PORT5_BUT1_PIN) // Nút S8 (Đèn Bàn Làm Việc)

#define PORT5_LED0_PORT  GPIOE
#define PORT5_LED0_PIN   14
#define LED_5_0          GPIO_BIT(PORT5_LED0_PORT, ODR, PORT5_LED0_PIN) // LED S7

#define PORT5_LED1_PORT  GPIOB
#define PORT5_LED1_PIN   10
#define LED_5_1          GPIO_BIT(PORT5_LED1_PORT, ODR, PORT5_LED1_PIN) // LED S8


// ----- PORT 6: CÔNG TẮC ĐẢO CHIỀU TOILET S3 (1 INPUT, 1 LED) -----
#define PORT6_BUT0_PORT  GPIOB
#define PORT6_BUT0_PIN   11
#define BUT6_0           GPIO_BIT(PORT6_BUT0_PORT, IDR, PORT6_BUT0_PIN) // Nút S3 Đảo chiều

#define PORT6_LED0_PORT  GPIOB
#define PORT6_LED0_PIN   12
#define LED_6_0          GPIO_BIT(PORT6_LED0_PORT, ODR, PORT6_LED0_PIN) // LED S3 Đảo chiều


// ----- PORT 7: NÚT MASTER ĐẦU GIƯỜNG (1 INPUT, 1 LED) -----
#define PORT7_BUT0_PORT  GPIOB
#define PORT7_BUT0_PIN   13
#define BUT7_0           GPIO_BIT(PORT7_BUT0_PORT, IDR, PORT7_BUT0_PIN) // Nút MASTER Tắt phòng

#define PORT7_LED0_PORT  GPIOB
#define PORT7_LED0_PIN   14
#define LED_7_0          GPIO_BIT(PORT7_LED0_PORT, ODR, PORT7_LED0_PIN) // LED MASTER


// ----- PORT 8: ĐẦU GIƯỜNG TRÁI S6 + S11 (2 INPUT, 2 LED) -----
#define PORT8_BUT0_PORT  GPIOB
#define PORT8_BUT0_PIN   15
#define BUT8_0           GPIO_BIT(PORT8_BUT0_PORT, IDR, PORT8_BUT0_PIN) // Nút S6 (Đèn Đọc Sách Trái)

#define PORT8_BUT1_PORT  GPIOD
#define PORT8_BUT1_PIN   9
#define BUT8_1           GPIO_BIT(PORT8_BUT1_PORT, IDR, PORT8_BUT1_PIN) // Nút S11 (Đèn Ngủ Tủ Đầu Giường)

#define PORT8_LED0_PORT  GPIOD
#define PORT8_LED0_PIN   8
#define LED_8_0          GPIO_BIT(PORT8_LED0_PORT, ODR, PORT8_LED0_PIN) // LED S6

#define PORT8_LED1_PORT  GPIOD
#define PORT8_LED1_PIN   10
#define LED_8_1          GPIO_BIT(PORT8_LED1_PORT, ODR, PORT8_LED1_PIN) // LED S11


// ----- PORT 9: ĐẦU GIƯỜNG TRÁI S1 + S2 (2 INPUT, 2 LED) -----
#define PORT9_BUT0_PORT  GPIOD
#define PORT9_BUT0_PIN   11
#define BUT9_0           GPIO_BIT(PORT9_BUT0_PORT, IDR, PORT9_BUT0_PIN) // Nút S1 (Đèn Minibar & Hành Lý)

#define PORT9_BUT1_PORT  GPIOD
#define PORT9_BUT1_PIN   13
#define BUT9_1           GPIO_BIT(PORT9_BUT1_PORT, IDR, PORT9_BUT1_PIN) // Nút S2 (Đèn Hắt Trần Phòng Ngủ)

#define PORT9_LED0_PORT  GPIOD
#define PORT9_LED0_PIN   12
#define LED_9_0          GPIO_BIT(PORT9_LED0_PORT, ODR, PORT9_LED0_PIN) // LED S1

#define PORT9_LED1_PORT  GPIOD
#define PORT9_LED1_PIN   14
#define LED_9_1          GPIO_BIT(PORT9_LED1_PORT, ODR, PORT9_LED1_PIN) // LED S2


// ----- PORT 10: ĐẦU GIƯỜNG PHẢI S5 + S11 (2 INPUT, 2 LED) -----
#define PORT10_BUT0_PORT GPIOD
#define PORT10_BUT0_PIN  15
#define BUT10_0          GPIO_BIT(PORT10_BUT0_PORT, IDR, PORT10_BUT0_PIN) // Nút S5 (Đèn Đọc Sách Phải)

#define PORT10_BUT1_PORT GPIOC
#define PORT10_BUT1_PIN  7
#define BUT10_1          GPIO_BIT(PORT10_BUT1_PORT, IDR, PORT10_BUT1_PIN) // Nút S11 (Đèn Ngủ Tủ Đầu Giường Phải)

#define PORT10_LED0_PORT GPIOC
#define PORT10_LED0_PIN  6
#define LED_10_0         GPIO_BIT(PORT10_LED0_PORT, ODR, PORT10_LED0_PIN) // LED S5

#define PORT10_LED1_PORT GPIOC
#define PORT10_LED1_PIN  8
#define LED_10_1         GPIO_BIT(PORT10_LED1_PORT, ODR, PORT10_LED1_PIN) // LED S11


// ----- PORT 11: ĐẦU GIƯỜNG PHẢI S1 + S2 (2 INPUT, 2 LED) -----
#define PORT11_BUT0_PORT GPIOB
#define PORT11_BUT0_PIN  6
#define BUT11_0          GPIO_BIT(PORT11_BUT0_PORT, IDR, PORT11_BUT0_PIN) // Nút S1 Đảo chiều

#define PORT11_BUT1_PORT GPIOB
#define PORT11_BUT1_PIN  8
#define BUT11_1          GPIO_BIT(PORT11_BUT1_PORT, IDR, PORT11_BUT1_PIN) // Nút S2 Đảo chiều

#define PORT11_LED0_PORT GPIOB
#define PORT11_LED0_PIN  7
#define LED_11_0         GPIO_BIT(PORT11_LED0_PORT, ODR, PORT11_LED0_PIN) // LED S1

#define PORT11_LED1_PORT GPIOB
#define PORT11_LED1_PIN  9
#define LED_11_1         GPIO_BIT(PORT11_LED1_PORT, ODR, PORT11_LED1_PIN) // LED S2


// ----- PORT 12: CÔNG TẮC THẺ TỪ (KEYCARD - 1 INPUT, 1 LED) -----
#define PORT12_BUT0_PORT GPIOE
#define PORT12_BUT0_PIN  0
#define BUT12_0          GPIO_BIT(PORT12_BUT0_PORT, IDR, PORT12_BUT0_PIN) // Tiếp điểm Thẻ Từ Keycard

#define PORT12_LED0_PORT GPIOE
#define PORT12_LED0_PIN  1
#define LED_12_0         GPIO_BIT(PORT12_LED0_PORT, ODR, PORT12_LED0_PIN) // LED Thẻ Từ Keycard


// =============================================================================
// 5. ĐỊNH NGHĨA BITMASK RELAY TRÊN IC DỊCH 74HC595 (OUTPUT 32-BIT)
// =============================================================================
// RELAY_1  -> Shift Reg Q0  (Physical RL8) : S7 (Đèn Ban Công)
#define RELAY_1   0b00000000000000000000000000000001
// RELAY_2  -> Shift Reg Q1  (Physical RL7) : S6 (Đèn Đọc Sách Đóng Trái)
#define RELAY_2   0b00000000000000000000000000000010
// RELAY_3  -> Shift Reg Q3  (Physical RL6) : S5 (Đèn Đọc Sách Đóng Phải)
#define RELAY_3   0b00000000000000000000000000000100
// RELAY_4  -> Shift Reg Q3  (Physical RL5) : Dự phòng / S4 cũ
#define RELAY_4   0b00000000000000000000000000001000
// RELAY_5  -> Shift Reg Q4  (Physical RL4) : Dự phòng / S3 cũ
#define RELAY_5   0b00000000000000000000000000010000
// RELAY_6  -> Shift Reg Q5  (Physical RL3) : S2 (Đèn Hắt Trần Phòng Ngủ)
#define RELAY_6   0b00000000000000000000000000100000
// RELAY_7  -> Shift Reg Q6  (Physical RL2) : S1 (Đèn Minibar & Hành Lý)
#define RELAY_7   0b00000000000000000000000001000000
// RELAY_8  -> Shift Reg Q7  (Physical RL1) : SL1 (Đèn Sảnh / Lobby)
#define RELAY_8   0b00000000000000000000000010000000
// RELAY_9  -> Shift Reg Q8  (Physical RL16): S3 (Đèn Trần Toilet/Vanity/Bồn Tắm) [FIX2LED]
#define RELAY_9   0b00000000000000000000000100000000
// RELAY_10 -> Shift Reg Q9  (Physical RL15): S4 (Đèn Trang Trí Toilet) [FIX2LED]
#define RELAY_10  0b00000000000000000000001000000000
// RELAY_11 -> Shift Reg Q10 (Physical RL14): Điều Hòa (AC Power)
#define RELAY_11  0b00000000000000000000010000000000
// RELAY_12 -> Shift Reg Q11 (Physical RL13): Ổ Cắm Điện Trong Phòng (Sockets)
#define RELAY_12  0b00000000000000000000100000000000
// RELAY_13 -> Shift Reg Q12 (Physical RL12): Chuông Cửa (Doorbell Chime)
#define RELAY_13  0b00000000000000000001000000000000
// RELAY_14 -> Shift Reg Q13 (Physical RL11): S11 (Đèn Ngủ Tủ Đầu Giường)
#define RELAY_14  0b00000000000000000010000000000000
// RELAY_15 -> Shift Reg Q14 (Physical RL10): S9 (Đèn Tranh Đầu Giường)
#define RELAY_15  0b00000000000000000100000000000000
// RELAY_16 -> Shift Reg Q15 (Physical RL9) : S8 (Đèn Bàn Làm Việc)
#define RELAY_16  0b00000000000000001000000000000000

#define BELL_DOOR BELL_DOOR_VAL // Tránh xung đột nếu có
#define BELL_DOOR_VAL 0b00000000000000000000000010000000

#endif // PIN_CONFIG_H
