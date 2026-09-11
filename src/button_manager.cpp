/**
 * ====================================================================================================
 * @file        button_manager.cpp
 * @brief       Cài đặt quét và lọc chống dội (Debounce) cho 24 nút nhấn
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#include "button_manager.h"
#include <string.h>

// Định nghĩa các mảng trạng thái
volatile uint8_t but_sample[SUM_BUT][SAMPLE] = {{0}};
volatile uint8_t but_state[SUM_BUT] = {0};
volatile uint8_t but_status[SUM_BUT] = {0};
volatile uint8_t but_sum_sample[SUM_BUT] = {0};

// Bảng ánh xạ chân nút nhấn
static const uint32_t button_pins[SUM_BUT] = {
    PIN_BUT_MUR_OUT,     // 0
    PIN_BUT_DND_OUT,     // 1
    PIN_BUT_BELL_OUT,    // 2
    PIN_BUT_S1,          // 3
    PIN_BUT_S2,          // 4
    PIN_BUT_S5,          // 5
    PIN_BUT_ENTRANCE_NC, // 6
    PIN_BUT_SL1,         // 7
    PIN_BUT_S9,          // 8
    PIN_BUT_S3_BATH1,    // 9
    PIN_BUT_S4_VANITY,   // 10
    PIN_BUT_S7_BALCONY,   // 11
    PIN_BUT_S8_DESK,      // 12
    PIN_BUT_S3_BATH2,    // 13
    PIN_BUT_MASTER,      // 14
    PIN_BUT_S6_READING,   // 15
    PIN_BUT_S11_NIGHT,   // 16
    PIN_BUT_SPARE1,      // 17
    PIN_BUT_SPARE2,      // 18
    PIN_BUT_MUR_IN,      // 19
    PIN_BUT_DND_IN,      // 20
    PIN_BUT_SPARE3,      // 21
    PIN_BUT_SPARE4,      // 22
    PIN_BUT_KEYCARD      // 23
};

void buttonManager_init(void) {
    for (uint8_t i = 0; i < SUM_BUT; i++) {
        pinMode(button_pins[i], INPUT_PULLUP);
    }
    memset((void*)but_sample, 0, sizeof(but_sample));
    memset((void*)but_state, 0, sizeof(but_state));
    memset((void*)but_status, 0, sizeof(but_status));
    memset((void*)but_sum_sample, 0, sizeof(but_sum_sample));
}

void buttonManager_scan(void) {
    uint8_t but_isr = 0;
    uint8_t i_isr = 0;

    // 1. Đọc giá trị tức thời của 24 nút nhấn (Active LOW: nút bấm = 0 -> !digitalRead = 1)
    for (but_isr = 0; but_isr < SUM_BUT; but_isr++) {
        but_sample[but_isr][SAMPLE - 1] = !digitalRead(button_pins[but_isr]);
    }

    // 2. Thuật toán dịch mẫu và xác định trạng thái (Khớp 100% mã gốc MikroC)
    for (but_isr = 0; but_isr < SUM_BUT; but_isr++) {
        for (i_isr = 0; i_isr < SAMPLE - 1; i_isr++) {
            but_sample[but_isr][i_isr] = but_sample[but_isr][i_isr + 1];
        }

        but_sum_sample[but_isr] = 0;
        for (i_isr = 0; i_isr < SAMPLE; i_isr++) {
            but_sum_sample[but_isr] += but_sample[but_isr][i_isr];
        }

        if (but_sum_sample[but_isr] >= PRESS) {
            but_state[but_isr] = PRESS;
        } else if (but_sum_sample[but_isr] == UNPRESS) {
            but_state[but_isr] = UNPRESS;
        }

        if (but_state[but_isr] == PRESS) {
            if (but_status[but_isr] == UNPRESS) {
                but_status[but_isr] = PRES_DOW;
            } else if (but_status[but_isr] == PRES_DOW) {
                but_status[but_isr] = PRESSING;
            } else if (but_status[but_isr] == PRESSING) {
                but_status[but_isr] = PRESSING;
            }
        } else if (but_state[but_isr] == UNPRESS) {
            if ((but_status[but_isr] == PRESSING) || (but_status[but_isr] == PRES_DOW)) {
                but_status[but_isr] = PRES_UP;
            } else if (but_status[but_isr] == PRES_UP) {
                but_status[but_isr] = UNPRESS;
            } else if (but_status[but_isr] == UNPRESS) {
                but_status[but_isr] = UNPRESS;
            }
        }
    }

    // 3. Đảo trạng thái LED Heartbeat PA8 báo chu kỳ quét
    static uint8_t heartbeat = 0;
    heartbeat = !heartbeat;
    digitalWrite(PIN_HEARTBEAT_A8, heartbeat ? HIGH : LOW);
}
