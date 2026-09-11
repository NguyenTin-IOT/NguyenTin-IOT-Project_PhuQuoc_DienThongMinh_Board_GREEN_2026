/**
 * ====================================================================================================
 * @file        shift_register.cpp
 * @brief       Cài đặt hàm xuất dữ liệu 32-bit ra IC ghi dịch 74HC595
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#include "shift_register.h"
#include "pin_config.h"

// Khởi tạo biến toàn cục out_relay
volatile uint32_t out_relay = 0;

void shiftRegister_init(void) {
    pinMode(PIN_RELAY_DS, OUTPUT);
    pinMode(PIN_RELAY_OE, OUTPUT);
    pinMode(PIN_RELAY_ST_CP, OUTPUT);
    pinMode(PIN_RELAY_SH_CP, OUTPUT);

    digitalWrite(PIN_RELAY_OE, HIGH);    // Tắt ngõ ra ban đầu (OE = 1)
    digitalWrite(PIN_RELAY_DS, LOW);
    digitalWrite(PIN_RELAY_ST_CP, LOW);
    digitalWrite(PIN_RELAY_SH_CP, LOW);

    // Xuất trạng thái an toàn toàn bộ 0
    shiftRegister_write32(0);
}

void shiftRegister_write32(uint32_t data_dich) {
    uint8_t vt_dich = 32;
    uint32_t shift_data = data_dich;

    // Giống mã gốc: OE = 1 trong quá trình dịch
    digitalWrite(PIN_RELAY_OE, HIGH);

    do {
        vt_dich--;
        // Xuất từng bit từ MSB (bit 31) xuống LSB (bit 0)
        uint8_t bit_val = (shift_data >> vt_dich) & 0x01;
        digitalWrite(PIN_RELAY_DS, bit_val ? HIGH : LOW);

        // Tạo xung dịch SH_CP (0 -> 1)
        digitalWrite(PIN_RELAY_SH_CP, LOW);
        digitalWrite(PIN_RELAY_SH_CP, HIGH);
    } while (vt_dich > 0);

    // Bật lại ngõ ra (OE = 0)
    digitalWrite(PIN_RELAY_OE, LOW);

    // Tạo xung chốt ngõ ra ST_CP (0 -> 1)
    digitalWrite(PIN_RELAY_ST_CP, LOW);
    digitalWrite(PIN_RELAY_ST_CP, HIGH);
}

void xuat_32bit(uint32_t data) {
    shiftRegister_write32(data);
}
