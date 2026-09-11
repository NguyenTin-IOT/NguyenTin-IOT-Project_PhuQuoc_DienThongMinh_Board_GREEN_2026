/**
 * ====================================================================================================
 * @file        button_manager.h
 * @brief       Quản lý quét phím và khử rung (Debounce) cho 24 nút nhấn / cảm biến
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#ifndef BUTTON_MANAGER_H
#define BUTTON_MANAGER_H

#include <Arduino.h>
#include <stdint.h>
#include "pin_config.h"

#ifdef __cplusplus
extern "C" {
#endif

// Các định nghĩa trạng thái nút nhấn (Khớp 100% mã gốc MikroC)
#define SAMPLE          BUTTON_SAMPLE_COUNT // 2 mẫu kiểm tra liên tiếp
#define SUM_BUT         TOTAL_BUTTONS       // 24 nút nhấn / cảm biến

#define UNPRESS         0                   // Không nhấn
#define PRESS           2                   // Đã xác nhận nhấn qua bộ lọc
#define PRE_PRESS       3                   // Dự bị nhấn
#define PRES_UP         4                   // Sự kiện vừa nhả phím (Release Event)
#define PRES_DOW        5                   // Sự kiện vừa nhấn xuống (Press Down Event)
#define PRESSING        6                   // Đang giữ phím (Holding)

// Chỉ số nút nhấn (Index 0 - 23)
enum ButtonIndex {
    IDX_BUT_MUR_OUT   = 0,
    IDX_BUT_DND_OUT   = 1,
    IDX_BUT_BELL_OUT  = 2,
    IDX_BUT_S1        = 3,
    IDX_BUT_S2        = 4,
    IDX_BUT_S5        = 5,
    IDX_BUT_ENTRANCE  = 6,
    IDX_BUT_SL1       = 7,
    IDX_BUT_S9        = 8,
    IDX_BUT_S3_BATH1  = 9,
    IDX_BUT_S4_VANITY = 10,
    IDX_BUT_S7        = 11,
    IDX_BUT_S7_BALCONY = 11,
    IDX_BUT_S8        = 12,
    IDX_BUT_S8_DESK   = 12,
    IDX_BUT_S3_BATH2  = 13,
    IDX_BUT_MASTER    = 14,
    IDX_BUT_S6        = 15,
    IDX_BUT_S6_READING = 15,
    IDX_BUT_S11       = 16,
    IDX_BUT_S11_NIGHT = 16,
    IDX_BUT_SPARE1    = 17,
    IDX_BUT_SPARE2    = 18,
    IDX_BUT_MUR_IN    = 19,
    IDX_BUT_DND_IN    = 20,
    IDX_BUT_SPARE3    = 21,
    IDX_BUT_SPARE4    = 22,
    IDX_BUT_KEYCARD   = 23
};

// Mảng trạng thái toàn cục
extern volatile uint8_t but_sample[SUM_BUT][SAMPLE];
extern volatile uint8_t but_state[SUM_BUT];
extern volatile uint8_t but_status[SUM_BUT];
extern volatile uint8_t but_sum_sample[SUM_BUT];

/**
 * @brief Khởi tạo các chân GPIO cho 24 nút nhấn
 */
void buttonManager_init(void);

/**
 * @brief Hàm quét nút được gọi từ ngắt Timer (chu kỳ 20ms)
 */
void buttonManager_scan(void);

#ifdef __cplusplus
}
#endif

#endif // BUTTON_MANAGER_H
