/**
 * ====================================================================================================
 * @file        shift_register.h
 * @brief       Giao tiếp điều khiển IC ghi dịch 74HC595 (Xuất 32-bit ra Relay)
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#ifndef SHIFT_REGISTER_H
#define SHIFT_REGISTER_H

#include <Arduino.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Biến lưu trạng thái toàn bộ 32 bit Relay hiện tại
extern volatile uint32_t out_relay;

/**
 * @brief Khởi tạo các chân điều khiển 74HC595
 */
void shiftRegister_init(void);

/**
 * @brief Xuất dữ liệu 32-bit ra chuỗi IC 74HC595
 * @param data Dữ liệu 32 bit (tương ứng Relay 1 - 32)
 */
void shiftRegister_write32(uint32_t data);

/**
 * @brief Alias tương thích với hàm gốc trong MikroC: xuat_32bit()
 */
void xuat_32bit(uint32_t data);

#ifdef __cplusplus
}
#endif

#endif // SHIFT_REGISTER_H
