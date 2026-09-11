/**
 * ====================================================================================================
 * @file        hw_init.cpp
 * @brief       Cài đặt khởi tạo phần cứng an toàn cho STM32F103VCT6
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#include "hw_init.h"
#include "shift_register.h"
#include "button_manager.h"
#include "room_logic.h"

void hw_init_all(void) {
    // 1. Cấu hình giải phóng JTAG-DP, giữ lại SW-DP (PA13/PA14) cho ST-Link
    // Giúp các chân PB3, PB4, PA15 hoạt động như GPIO thông thường (tương đương AFIO_MAPR |= 0x02000000)
    __HAL_RCC_AFIO_CLK_ENABLE();
    __HAL_AFIO_REMAP_SWJ_NOJTAG();

    // 2. Tắt nguồn 12V cuộn dây Relay ngay khi cấp điện để tránh nhảy relay đột ngột
    pinMode(PIN_RELAY_PWR_12V, OUTPUT);
    pinMode(PIN_SPARE_PWR_C15, OUTPUT);
    digitalWrite(PIN_RELAY_PWR_12V, LOW); // Mosfet IRF9530 OFF
    digitalWrite(PIN_SPARE_PWR_C15, LOW);

    // 3. Khởi tạo IC ghi dịch 74HC595 và tắt toàn bộ Relay
    shiftRegister_init();

    // 4. Khởi tạo 24 nút bấm và bộ lọc chống dội
    buttonManager_init();

    // 5. Khởi tạo các LED phản hồi trên mặt công tắc
    roomLogic_init();

    // 6. Cấu hình các chân báo trạng thái và chân dự phòng
    pinMode(PIN_STAT_LED, OUTPUT);
    pinMode(PIN_HEARTBEAT_A8, OUTPUT);
    pinMode(PIN_SPARE_PC9, OUTPUT);
    pinMode(PIN_SPARE_PD6, OUTPUT);
    pinMode(PIN_SPARE_PD7, OUTPUT);
    pinMode(PIN_SPARE_PB3, OUTPUT);
    pinMode(PIN_SPARE_PB4, OUTPUT);

    digitalWrite(PIN_STAT_LED, HIGH);     // STAT LED sáng xanh
    digitalWrite(PIN_HEARTBEAT_A8, HIGH);
    digitalWrite(PIN_SPARE_PC9, HIGH);
    digitalWrite(PIN_SPARE_PD6, HIGH);
    digitalWrite(PIN_SPARE_PD7, HIGH);
    digitalWrite(PIN_SPARE_PB3, HIGH);
    digitalWrite(PIN_SPARE_PB4, HIGH);
}

void hw_enable_relay_power(void) {
    // Đóng Mosfet IRF9530 cấp nguồn 12V cho các cuộn hút Relay
    digitalWrite(PIN_RELAY_PWR_12V, HIGH);
}
