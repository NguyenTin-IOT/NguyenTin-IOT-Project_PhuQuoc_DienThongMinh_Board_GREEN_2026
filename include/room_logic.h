/**
 * ====================================================================================================
 * @file        room_logic.h
 * @brief       Xử lý logic vận hành phòng khách sạn PQ-TWINROOM
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#ifndef ROOM_LOGIC_H
#define ROOM_LOGIC_H

#include <Arduino.h>
#include <stdint.h>
#include "pin_config.h"
#include "relay_map.h"

#ifdef __cplusplus
extern "C" {
#endif

// Các biến cờ trạng thái phòng (Toàn cục)
extern volatile uint8_t MASTER_SWITCH;
extern volatile uint8_t DO_NOT_DISTURB;

extern volatile uint8_t KEYCARD_ENABLE;
extern volatile uint8_t KEYCARD_INSERT;
extern volatile uint32_t KEYCARD_COUNTER;
extern volatile uint32_t KEYCARD_COUNTER_CLOSE;

extern volatile uint32_t BELL_COUNTER;
extern volatile uint8_t BELL_ENABLE;

/**
 * @brief Khởi tạo các chân LED phản hồi và biến trạng thái
 */
void roomLogic_init(void);

/**
 * @brief Xử lý sự kiện 24 nút nhấn (Được gọi từ chu kỳ ngắt Timer 20ms)
 */
void roomLogic_processButtons(void);

/**
 * @brief Xử lý tiến trình nền trong vòng lặp loop() (Thời gian chuông, Thẻ phòng)
 */
void roomLogic_processLoop(void);

/**
 * @brief Tắt toàn bộ đèn LED phản hồi (Khi rút thẻ hoặc reset)
 */
void roomLogic_turnOffAllLeds(void);

#ifdef __cplusplus
}
#endif

#endif // ROOM_LOGIC_H
