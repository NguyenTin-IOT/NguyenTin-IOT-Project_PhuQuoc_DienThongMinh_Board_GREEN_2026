/**
 * ====================================================================================================
 * @file        relay_map.h
 * @brief       ÁNH XẠ BIT MẶT NẠ (BITMASK) 16 RELAY VÀ TẢI ĐIỀU KHIỂN THỰC TẾ
 * @project     PQ-TWINROOM - Hotel Room Controller
 * @details     Định nghĩa mặt nạ bit 32-bit gửi tới IC 74HC595.
 *              Khớp 100% giữa tên Relay logic trong phần mềm và tên ký hiệu mạch phần cứng (RL1 - RL16).
 * ====================================================================================================
 */

#ifndef RELAY_MAP_H
#define RELAY_MAP_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ====================================================================================================
 * 1. MẶT NẠ BIT CỦA 16 RELAY CÔNG SUẤT CHÍNH (KHỚP PHẦN CỨNG MẠCH THỰC TẾ)
 * ====================================================================================================
 */
// RELAY_1 -> Tương ứng mạch RL8: Đèn ban công (S7)
#define RELAY_1             (1UL << 0)
#define RELAY_RL8_BALCONY   RELAY_1

// RELAY_2 -> Tương ứng mạch RL7: Đèn đọc sách đầu giường (S6)
#define RELAY_2             (1UL << 1)
#define RELAY_RL7_READING   RELAY_2

// RELAY_3 -> Tương ứng mạch RL6: Đèn ngủ / đầu giường (S5)
#define RELAY_3             (1UL << 2)
#define RELAY_RL6_BEDSIDE   RELAY_3

// RELAY_4 -> Tương ứng mạch RL5: Rèm đóng / Tải mở rộng (RL5)
#define RELAY_4             (1UL << 3)
#define RELAY_RL5_CUR_CLOSE RELAY_4

// RELAY_5 -> Tương ứng mạch RL4: Rèm mở / Tải mở rộng (RL4)
#define RELAY_5             (1UL << 4)
#define RELAY_RL4_CUR_OPEN  RELAY_5

// RELAY_6 -> Tương ứng mạch RL3: Đèn chiếu sáng chính 2 (S2)
#define RELAY_6             (1UL << 5)
#define RELAY_RL3_LIGHT2    RELAY_6

// RELAY_7 -> Tương ứng mạch RL2: Đèn chiếu sáng chính 1 (S1)
#define RELAY_7             (1UL << 6)
#define RELAY_RL2_LIGHT1    RELAY_7

// RELAY_8 -> Tương ứng mạch RL1: Đèn sảnh lối vào (SL1 - Giữ sáng khi bấm Master)
#define RELAY_8             (1UL << 7)
#define RELAY_RL1_LOBBY     RELAY_8

// RELAY_9 -> Tương ứng mạch RL16: Đèn trần phòng tắm & bồn tắm nằm (S3)
#define RELAY_9             (1UL << 8)
#define RELAY_RL16_BATH     RELAY_9

// RELAY_10 -> Tương ứng mạch RL15: Đèn trang trí gương & hắt trần phòng tắm (S4)
#define RELAY_10            (1UL << 9)
#define RELAY_RL15_VANITY   RELAY_10

// RELAY_11 -> Tương ứng mạch RL14: Nguồn Điều hòa (AC / Air Conditioner)
#define RELAY_11            (1UL << 10)
#define RELAY_RL14_AC       RELAY_11

// RELAY_12 -> Tương ứng mạch RL13: Nguồn Ổ cắm phòng (Power Socket theo thẻ phòng)
#define RELAY_12            (1UL << 11)
#define RELAY_RL13_SOCKET   RELAY_12

// RELAY_13 -> Tương ứng mạch RL12: Chuông cửa (Doorbell Chime)
#define RELAY_13            (1UL << 12)
#define RELAY_RL12_BELL     RELAY_13

// RELAY_14 -> Tương ứng mạch RL11: Đèn ngủ gầm tủ đầu giường (S11 Nightlight)
#define RELAY_14            (1UL << 13)
#define RELAY_RL11_NIGHT    RELAY_14

// RELAY_15 -> Tương ứng mạch RL10: Đèn tranh trang trí đầu giường (S9)
#define RELAY_15            (1UL << 14)
#define RELAY_RL10_PICTURE  RELAY_15

// RELAY_16 -> Tương ứng mạch RL9: Đèn bàn làm việc (S8 Study Desk)
#define RELAY_16            (1UL << 15)
#define RELAY_RL9_DESK      RELAY_16

/* ====================================================================================================
 * 2. CÁC RELAY MỞ RỘNG (17 ĐẾN 32 - DỰ PHÒNG SHIFT REGISTER)
 * ====================================================================================================
 */
#define RELAY_17            (1UL << 16)
#define RELAY_18            (1UL << 17)
#define RELAY_19            (1UL << 18)
#define RELAY_20            (1UL << 19)
#define RELAY_21            (1UL << 20)
#define RELAY_22            (1UL << 21)
#define RELAY_23            (1UL << 22)
#define RELAY_24            (1UL << 23)
#define RELAY_25            (1UL << 24)
#define RELAY_26            (1UL << 25)
#define RELAY_27            (1UL << 26)
#define RELAY_28            (1UL << 27)
#define RELAY_29            (1UL << 28)
#define RELAY_30            (1UL << 29)
#define RELAY_31            (1UL << 30)
#define RELAY_32            (1UL << 31)

#ifdef __cplusplus
}
#endif

#endif // RELAY_MAP_H
