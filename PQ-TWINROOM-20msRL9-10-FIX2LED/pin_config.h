/**
 * =================================================================================
 * @file        pin_config.h
 * @brief       Cấu hình tập trung toàn bộ chân I/O cho Dự Án PQ-TWINROOM (STM32F103VC)
 * =================================================================================
 */

#ifndef PIN_CONFIG_H
#define PIN_CONFIG_H

#ifdef __cplusplus
extern "C" {
#endif

/* =================================================================================
 * 1. CẤU HÌNH CHÂN DỊCH NỐI TIẾP SHIFT REGISTER 74HC595 (ĐIỀU KHIỂN RELAY 1 - 32)
 * =================================================================================
 */
#define PIN_RELAY_DS_PORT       GPIOD
#define PIN_RELAY_DS_PIN        2       // PD2 - Data Serial (DS / SER)

#define PIN_RELAY_OE_PORT       GPIOD
#define PIN_RELAY_OE_PIN        1       // PD1 - Output Enable (OE)

#define PIN_RELAY_ST_CP_PORT    GPIOD
#define PIN_RELAY_ST_CP_PIN     0       // PD0 - Latch Clock (ST_CP / RCLK)

#define PIN_RELAY_SH_CP_PORT    GPIOC
#define PIN_RELAY_SH_CP_PIN     12      // PC12 - Shift Clock (SH_CP / SRCLK)

/* =================================================================================
 * 2. CẤU HÌNH CHÂN NÚT NHẤN (INPUTS) - TỔNG CỘNG 24 NÚT NHẤN / CẢM BIẾN
 * =================================================================================
 */
// --- PORT 1 ---
#define PIN_BUT1_0_PORT         GPIOE
#define PIN_BUT1_0_PIN          2       // PE2 - Nút MUR (Make Up Room ngoài cửa)
#define PIN_BUT1_1_PORT         GPIOE
#define PIN_BUT1_1_PIN          4       // PE4 - Nút DND (Do Not Disturb ngoài cửa)
#define PIN_BUT1_2_PORT         GPIOE
#define PIN_BUT1_2_PIN          6       // PE6 - Nút Chuông cửa (Doorbell)

// --- PORT 2 ---
#define PIN_BUT2_0_PORT         GPIOC
#define PIN_BUT2_0_PIN          0       // PC0 - Nút S1 (Đèn 1)
#define PIN_BUT2_1_PORT         GPIOC
#define PIN_BUT2_1_PIN          2       // PC2 - Nút S2 (Đèn 2)
#define PIN_BUT2_2_PORT         GPIOA
#define PIN_BUT2_2_PIN          0       // PA0 - Nút S5 (Đèn bedside)

// --- PORT 3 ---
#define PIN_BUT3_0_PORT         GPIOC
#define PIN_BUT3_0_PIN          5       // PC5 - Nút SL1 (Đèn Lobby)
#define PIN_BUT3_1_PORT         GPIOB
#define PIN_BUT3_1_PIN          1       // PB1 - Nút Entrance
#define PIN_BUT3_2_PORT         GPIOE
#define PIN_BUT3_2_PIN          7       // PE7 - Nút S9 (Đèn tranh)

// --- PORT 4 ---
#define PIN_BUT4_0_PORT         GPIOE
#define PIN_BUT4_0_PIN          9       // PE9 - Nút S3 (Đèn phòng tắm)
#define PIN_BUT4_1_PORT         GPIOE
#define PIN_BUT4_1_PIN          11      // PE11 - Nút S4 (Đèn trang điểm)

// --- PORT 5 ---
#define PIN_BUT5_0_PORT         GPIOE
#define PIN_BUT5_0_PIN          13      // PE13 - Nút S7 (Đèn Ban công)
#define PIN_BUT5_1_PORT         GPIOE
#define PIN_BUT5_1_PIN          15      // PE15 - Nút S8 (Đèn bàn làm việc)

// --- PORT 6 ---
#define PIN_BUT6_0_PORT         GPIOB
#define PIN_BUT6_0_PIN          11      // PB11 - Nút S3 (Đèn tắm phụ)

// --- PORT 7 ---
#define PIN_BUT7_0_PORT         GPIOB
#define PIN_BUT7_0_PIN          13      // PB13 - Nút MASTER (Tắt hết đèn trừ SL1)

// --- PORT 8 ---
#define PIN_BUT8_0_PORT         GPIOB
#define PIN_BUT8_0_PIN          15      // PB15 - Nút S6 (Đèn đọc sách)
#define PIN_BUT8_1_PORT         GPIOD
#define PIN_BUT8_1_PIN          9       // PD9 - Nút S11 (Đèn ngủ chân giường)

// --- PORT 9 (DỰ PHÒNG) ---
#define PIN_BUT9_0_PORT         GPIOD
#define PIN_BUT9_0_PIN          11      // PD11 - Dự phòng 1
#define PIN_BUT9_1_PORT         GPIOD
#define PIN_BUT9_1_PIN          13      // PD13 - Dự phòng 2

// --- PORT 10 ---
#define PIN_BUT10_0_PORT        GPIOD
#define PIN_BUT10_0_PIN         15      // PD15 - Nút MUR trong phòng
#define PIN_BUT10_1_PORT        GPIOC
#define PIN_BUT10_1_PIN         7       // PC7 - Nút DND trong phòng

// --- PORT 11 (DỰ PHÒNG) ---
#define PIN_BUT11_0_PORT        GPIOB
#define PIN_BUT11_0_PIN         6       // PB6 - Dự phòng 3
#define PIN_BUT11_1_PORT        GPIOB
#define PIN_BUT11_1_PIN         8       // PB8 - Dự phòng 4

// --- PORT 12 (CẢM BIẾN THẺ THẺ / KEYCARD) ---
#define PIN_BUT12_0_PORT        GPIOE
#define PIN_BUT12_0_PIN         0       // PE0 - Cảm biến cắm Thẻ Phòng (Keycard)

/* =================================================================================
 * 3. CẤU HÌNH CHÂN LED BÁO PHẢN HỒI (OUTPUTS) - TỔNG CỘNG 16 LED
 * =================================================================================
 */
// --- PORT 1 ---
#define PIN_LED1_0_PORT         GPIOE
#define PIN_LED1_0_PIN          3       // PE3 - LED MUR ngoài cửa
#define PIN_LED1_1_PORT         GPIOE
#define PIN_LED1_1_PIN          5       // PE5 - LED DND ngoài cửa
#define PIN_LED1_2_PORT         GPIOC
#define PIN_LED1_2_PIN          13      // PC13 - LED Chuông cửa ngoài cửa

// --- PORT 2 ---
#define PIN_LED2_0_PORT         GPIOC
#define PIN_LED2_0_PIN          1       // PC1 - LED S1
#define PIN_LED2_1_PORT         GPIOC
#define PIN_LED2_1_PIN          3       // PC3 - LED S2
#define PIN_LED2_2_PORT         GPIOA
#define PIN_LED2_2_PIN          1       // PA1 - LED S5

// --- PORT 3 ---
#define PIN_LED3_0_PORT         GPIOB
#define PIN_LED3_0_PIN          0       // PB0 - LED SL1
#define PIN_LED3_2_PORT         GPIOB
#define PIN_LED3_2_PIN          2       // PB2 - LED S9

// --- PORT 4 ---
#define PIN_LED4_0_PORT         GPIOE
#define PIN_LED4_0_PIN          8       // PE8 - LED S3
#define PIN_LED4_1_PORT         GPIOE
#define PIN_LED4_1_PIN          10      // PE10 - LED S4
#define PIN_LED4_2_PORT         GPIOE
#define PIN_LED4_2_PIN          12      // PE12 - LED Dự phòng Port 4

// --- PORT 5 ---
#define PIN_LED5_0_PORT         GPIOE
#define PIN_LED5_0_PIN          14      // PE14 - LED S7
#define PIN_LED5_1_PORT         GPIOB
#define PIN_LED5_1_PIN          10      // PB10 - LED S8

// --- PORT 6 ---
#define PIN_LED6_0_PORT         GPIOB
#define PIN_LED6_0_PIN          12      // PB12 - LED S3 Bath

// --- PORT 7 ---
#define PIN_LED7_0_PORT         GPIOB
#define PIN_LED7_0_PIN          14      // PB14 - LED Master Switch

// --- PORT 8 ---
#define PIN_LED8_0_PORT         GPIOD
#define PIN_LED8_0_PIN          8       // PD8 - LED S6
#define PIN_LED8_1_PORT         GPIOD
#define PIN_LED8_1_PIN          10      // PD10 - LED S11

// --- PORT 9 ---
#define PIN_LED9_0_PORT         GPIOD
#define PIN_LED9_0_PIN          12      // PD12 - LED Dự phòng Port 9-0
#define PIN_LED9_1_PORT         GPIOD
#define PIN_LED9_1_PIN          14      // PD14 - LED Dự phòng Port 9-1

// --- PORT 10 ---
#define PIN_LED10_0_PORT        GPIOC
#define PIN_LED10_0_PIN         6       // PC6 - LED MUR trong phòng
#define PIN_LED10_1_PORT        GPIOC
#define PIN_LED10_1_PIN         8       // PC8 - LED DND trong phòng

// --- PORT 11 ---
#define PIN_LED11_0_PORT        GPIOB
#define PIN_LED11_0_PIN         7       // PB7 - LED Dự phòng Port 11-0
#define PIN_LED11_1_PORT        GPIOB
#define PIN_LED11_1_PIN         9       // PB9 - LED Dự phòng Port 11-1

// --- PORT 12 ---
#define PIN_LED12_0_PORT        GPIOE
#define PIN_LED12_0_PIN         1       // PE1 - LED Cắm Thẻ Keycard

/* =================================================================================
 * 4. CẤU HÌNH CHÂN ĐIỀU KHIỂN NGUỒN RELAY 12V VÀ CHÂN DỰ PHÒNG (OUTPUTS/SPARE)
 * =================================================================================
 */
#define PIN_RELAY_PWR_12V_PORT  GPIOC
#define PIN_RELAY_PWR_12V_PIN   14      // PC14 - Kích Mosfet IRF9530 Cấp nguồn 12V cho cuộn dây Relay

#define PIN_SPARE_C15_PORT      GPIOC
#define PIN_SPARE_C15_PIN       15      // PC15 - Chân dự phòng
#define PIN_SPARE_C9_PORT       GPIOC
#define PIN_SPARE_C9_PIN        9       // PC9 - Chân dự phòng
#define PIN_SPARE_A8_PORT       GPIOA
#define PIN_SPARE_A8_PIN        8       // PA8 - Chân dự phòng
#define PIN_SPARE_D6_PORT       GPIOD
#define PIN_SPARE_D6_PIN        6       // PD6 - Chân dự phòng
#define PIN_SPARE_D7_PORT       GPIOD
#define PIN_SPARE_D7_PIN        7       // PD7 - Chân dự phòng
#define PIN_SPARE_B3_PORT       GPIOB
#define PIN_SPARE_B3_PIN        3       // PB3 - Chân dự phòng
#define PIN_SPARE_B4_PORT       GPIOB
#define PIN_SPARE_B4_PIN        4       // PB4 - Chân dự phòng

/* =================================================================================
 * 5. CẤU HÌNH CHÂN TRUYỀN THÔNG & NGOẠI VI (RS485, ETHERNET, DIMMER, STATUS)
 * =================================================================================
 */
#define PIN_STAT_LED_PORT       GPIOA
#define PIN_STAT_LED_PIN        12      // PA12 - LED Trạng thái (STAT)

#define PIN_RS485_DE1_PORT      GPIOA
#define PIN_RS485_DE1_PIN       11      // PA11 - RS485_1 DE

#define PIN_RS485_DE4_PORT      GPIOA
#define PIN_RS485_DE4_PIN       15      // PA15 - RS485_4 DE

#define PIN_ETH_CS_PORT         GPIOA
#define PIN_ETH_CS_PIN          4       // PA4 - ENC28J60 CS
#define PIN_ETH_RST_PORT        GPIOC
#define PIN_ETH_RST_PIN         4       // PC4 - ENC28J60 RST

/* =================================================================================
 * 6. MÃ HÓA BIT RELAY 74HC595 (MAPPING TỪ BIT DỊCH SANG RELAY VẬT LÝ)
 * =================================================================================
 */
#define RELAY_MASK_RL8_BALCONY     (1UL << 0)   // Relay 1  -> Mạch RL8 (Ban công S7)
#define RELAY_MASK_RL7_READING     (1UL << 1)   // Relay 2  -> Mạch RL7 (Đọc sách S6)
#define RELAY_MASK_RL6_BEDSIDE     (1UL << 2)   // Relay 3  -> Mạch RL6 (Đầu giường S5)
#define RELAY_MASK_RL5_CUR_CLOSE   (1UL << 3)   // Relay 4  -> Mạch RL5 (Rèm Đóng)
#define RELAY_MASK_RL4_CUR_OPEN    (1UL << 4)   // Relay 5  -> Mạch RL4 (Rèm Mở)
#define RELAY_MASK_RL3_LIGHT2      (1UL << 5)   // Relay 6  -> Mạch RL3 (Đèn S2)
#define RELAY_MASK_RL2_LIGHT1      (1UL << 6)   // Relay 7  -> Mạch RL2 (Đèn S1)
#define RELAY_MASK_RL1_LOBBY       (1UL << 7)   // Relay 8  -> Mạch RL1 (Sảnh SL1)
#define RELAY_MASK_RL16_BATH       (1UL << 8)   // Relay 9  -> Mạch RL16 (Phòng tắm S3)
#define RELAY_MASK_RL15_VANITY     (1UL << 9)   // Relay 10 -> Mạch RL15 (Trang điểm S4)
#define RELAY_MASK_RL14_AC         (1UL << 10)  // Relay 11 -> Mạch RL14 (Điều hòa AC)
#define RELAY_MASK_RL13_SOCKET     (1UL << 11)  // Relay 12 -> Mạch RL13 (Ổ cắm Thẻ)
#define RELAY_MASK_RL12_BELL       (1UL << 12)  // Relay 13 -> Mạch RL12 (Chuông cửa)
#define RELAY_MASK_RL11_NIGHTLIGHT (1UL << 13)  // Relay 14 -> Mạch RL11 (Đèn ngủ S11)
#define RELAY_MASK_RL10_PICTURE    (1UL << 14)  // Relay 15 -> Mạch RL10 (Đèn tranh S9)
#define RELAY_MASK_RL9_STUDY       (1UL << 15)  // Relay 16 -> Mạch RL9 (Bàn làm việc S8)

#ifdef __cplusplus
}
#endif

#endif // PIN_CONFIG_H
