/**
 * ====================================================================================================
 * @file        main.cpp
 * @brief       Chương trình chính điều khiển phòng khách sạn PQ-TWINROOM (STM32F103VCT6)
 * @details     Chuyển đổi hoàn chỉnh từ MikroC for ARM (botrungtam.c) sang PlatformIO (Arduino Framework)
 * ====================================================================================================
 */

#include <Arduino.h>
#include "pin_config.h"
#include "relay_map.h"
#include "shift_register.h"
#include "button_manager.h"
#include "room_logic.h"
#include "hw_init.h"

// Con trỏ quản lý Hardware Timer ngắt 20ms
static HardwareTimer *scanTimer = nullptr;

/**
 * @brief Hàm phục vụ ngắt Timer chu kỳ 20ms (tương đương timer1_isr trong MikroC)
 *        - Quét 24 nút bấm & lọc chống dội (Debounce 2 mẫu)
 *        - Xử lý sự kiện nhấn/nhả nút, điều khiển Relay và LED phản hồi
 */
void timerCallback(void) {
    buttonManager_scan();
    roomLogic_processButtons();
}

void setup() {
    // 1. Khởi tạo toàn bộ chân GPIO, giải phóng JTAG và khóa nguồn Relay 12V
    hw_init_all();

    // 2. Trễ an toàn 1.5s chờ nguồn vi điều khiển và cảm biến ổn định
    delay(POWERON_DELAY_1_MS);

    // 3. Khởi tạo Timer phần cứng TIM1 chu kỳ 20ms cho quét phím
    scanTimer = new HardwareTimer(TIM1);
    scanTimer->setOverflow(SCAN_TIMER_INTERVAL_US, MICROSEC_FORMAT);
    scanTimer->attachInterrupt(timerCallback);

    // 4. Trễ thêm 1.0s trước khi cấp nguồn cho cuộn dây Relay
    delay(POWERON_DELAY_2_MS);

    // 5. Đóng Mosfet IRF9530 cấp nguồn 12V cho các cuộn hút Relay
    hw_enable_relay_power();

    // 6. Kích hoạt Timer bắt đầu quét nút bấm
    scanTimer->resume();
}

void loop() {
    // Xử lý các tác vụ nền:
    // - Tự ngắt chuông cửa khi hết thời gian reo chuông
    // - Tự động bật tải chào đón khi cắm thẻ phòng
    // - Tự động ngắt toàn bộ điện phòng sau khi rút thẻ
    roomLogic_processLoop();
}