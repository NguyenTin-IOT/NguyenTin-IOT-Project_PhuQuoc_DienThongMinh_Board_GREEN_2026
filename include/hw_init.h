/**
 * ====================================================================================================
 * @file        hw_init.h
 * @brief       Khởi tạo phần cứng an toàn, cấu hình Remap AFIO (nhả JTAG) và bảo vệ nguồn Relay 12V
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#ifndef HW_INIT_H
#define HW_INIT_H

#include <Arduino.h>
#include "pin_config.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Khởi tạo toàn bộ phần cứng, chân GPIO và bảo vệ nguồn
 */
void hw_init_all(void);

/**
 * @brief Bật nguồn 12V cuộn dây Relay sau khi hệ thống đã ổn định
 */
void hw_enable_relay_power(void);

#ifdef __cplusplus
}
#endif

#endif // HW_INIT_H
