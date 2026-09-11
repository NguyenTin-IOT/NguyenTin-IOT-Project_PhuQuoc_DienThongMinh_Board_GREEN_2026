/**
 * ====================================================================================================
 * @file        room_logic.cpp
 * @brief       Cài đặt logic chi tiết phòng khách sạn PQ-TWINROOM
 * @project     PQ-TWINROOM - Hotel Room Controller
 * ====================================================================================================
 */

#include "room_logic.h"
#include "button_manager.h"
#include "shift_register.h"

// Định nghĩa các biến trạng thái
volatile uint8_t MASTER_SWITCH = 0;
volatile uint8_t DO_NOT_DISTURB = 0;

volatile uint8_t KEYCARD_ENABLE = 0;
volatile uint8_t KEYCARD_INSERT = 0;
volatile uint32_t KEYCARD_COUNTER = 0;
volatile uint32_t KEYCARD_COUNTER_CLOSE = 0;

volatile uint32_t BELL_COUNTER = 0;
volatile uint8_t BELL_ENABLE = 0;

void roomLogic_init(void) {
    // Khởi tạo các chân LED phản hồi công tắc là ngõ ra (OUTPUT)
    pinMode(PIN_LED_MUR_OUT, OUTPUT);
    pinMode(PIN_LED_DND_OUT, OUTPUT);
    pinMode(PIN_LED_BELL_OUT, OUTPUT);

    pinMode(PIN_LED_S1, OUTPUT);
    pinMode(PIN_LED_S2, OUTPUT);
    pinMode(PIN_LED_S5, OUTPUT);

    pinMode(PIN_LED_SL1, OUTPUT);
    pinMode(PIN_LED_S9, OUTPUT);

    pinMode(PIN_LED_S3_BATH1, OUTPUT);
    pinMode(PIN_LED_S4_VANITY, OUTPUT);
    pinMode(PIN_LED_PORT4_SPARE, OUTPUT);

    pinMode(PIN_LED_S7_BALCONY, OUTPUT);
    pinMode(PIN_LED_S8_DESK, OUTPUT);

    pinMode(PIN_LED_S3_BATH2, OUTPUT);
    pinMode(PIN_LED_MASTER, OUTPUT);

    pinMode(PIN_LED_S6_READING, OUTPUT);
    pinMode(PIN_LED_S11_NIGHT, OUTPUT);

    pinMode(PIN_LED_SPARE1, OUTPUT);
    pinMode(PIN_LED_SPARE2, OUTPUT);

    pinMode(PIN_LED_MUR_IN, OUTPUT);
    pinMode(PIN_LED_DND_IN, OUTPUT);

    pinMode(PIN_LED_SPARE3, OUTPUT);
    pinMode(PIN_LED_SPARE4, OUTPUT);

    pinMode(PIN_LED_KEYCARD, OUTPUT);

    // Tắt toàn bộ LED ban đầu
    roomLogic_turnOffAllLeds();
}

void roomLogic_turnOffAllLeds(void) {
    digitalWrite(PIN_LED_MUR_OUT, LOW);
    digitalWrite(PIN_LED_DND_OUT, LOW);
    digitalWrite(PIN_LED_BELL_OUT, LOW);

    digitalWrite(PIN_LED_S1, LOW);
    digitalWrite(PIN_LED_S2, LOW);
    digitalWrite(PIN_LED_S5, LOW);

    digitalWrite(PIN_LED_SL1, LOW);
    digitalWrite(PIN_LED_S9, LOW);

    digitalWrite(PIN_LED_S3_BATH1, LOW);
    digitalWrite(PIN_LED_S4_VANITY, LOW);
    digitalWrite(PIN_LED_PORT4_SPARE, LOW);

    digitalWrite(PIN_LED_S7_BALCONY, LOW);
    digitalWrite(PIN_LED_S8_DESK, LOW);

    digitalWrite(PIN_LED_S3_BATH2, LOW);
    digitalWrite(PIN_LED_MASTER, LOW);

    digitalWrite(PIN_LED_S6_READING, LOW);
    digitalWrite(PIN_LED_S11_NIGHT, LOW);

    digitalWrite(PIN_LED_SPARE1, LOW);
    digitalWrite(PIN_LED_SPARE2, LOW);

    digitalWrite(PIN_LED_MUR_IN, LOW);
    digitalWrite(PIN_LED_DND_IN, LOW);

    digitalWrite(PIN_LED_SPARE3, LOW);
    digitalWrite(PIN_LED_SPARE4, LOW);

    digitalWrite(PIN_LED_KEYCARD, LOW);
}

void roomLogic_processButtons(void) {

    // ===== PORT 1: KHU VỰC NGOÀI CỬA =====
    // but_status[0]: MUR ngoài cửa (không dùng nút)
    // but_status[1]: DND ngoài cửa (không dùng nút)

    // but_status[2]: NÚT CHUÔNG CỬA NGOÀI PHÒNG (DOORBELL) -> RELAY 13
    if (but_status[IDX_BUT_BELL_OUT] == PRES_DOW) {
        digitalWrite(PIN_LED_BELL_OUT, HIGH);
        if (!DO_NOT_DISTURB) {
            out_relay |= RELAY_13;
            BELL_ENABLE = 1;
        }
    } else if (but_status[IDX_BUT_BELL_OUT] == PRES_UP) {
        digitalWrite(PIN_LED_BELL_OUT, LOW);
        // Relay chuông tự tắt theo BELL_COUNTER trong loop()
    }

    // ===== PORT 2: ĐÈN 1 - ĐÈN 2 - ĐÈN ĐẦU GIƯỜNG =====
    // but_status[3]: NÚT S1 (ĐÈN CHÍNH 1) -> RELAY 7
    if (but_status[IDX_BUT_S1] == PRES_DOW) {
        digitalWrite(PIN_LED_S1, HIGH);
        out_relay ^= RELAY_7;
    } else if (but_status[IDX_BUT_S1] == PRES_UP) {
        digitalWrite(PIN_LED_S1, (out_relay & RELAY_7) ? HIGH : LOW);
    }

    // but_status[4]: NÚT S2 (ĐÈN CHÍNH 2) -> RELAY 6
    if (but_status[IDX_BUT_S2] == PRES_DOW) {
        digitalWrite(PIN_LED_S2, HIGH);
        out_relay ^= RELAY_6;
    } else if (but_status[IDX_BUT_S2] == PRES_UP) {
        digitalWrite(PIN_LED_S2, (out_relay & RELAY_6) ? HIGH : LOW);
    }

    // but_status[5]: NÚT S5 (ĐÈN ĐẦU GIƯỜNG) -> RELAY 3
    if (but_status[IDX_BUT_S5] == PRES_DOW) {
        digitalWrite(PIN_LED_S5, HIGH);
        out_relay ^= RELAY_3;
    } else if (but_status[IDX_BUT_S5] == PRES_UP) {
        digitalWrite(PIN_LED_S5, (out_relay & RELAY_3) ? HIGH : LOW);
    }

    // ===== PORT 3: KHU VỰC LỐI VÀO (ENTRANCE) =====
    // but_status[6]: Dự phòng (không dùng)

    // but_status[7]: NÚT SL1 (ĐÈN SẢNH LOBBY) -> RELAY 8
    if (but_status[IDX_BUT_SL1] == PRES_DOW) {
        digitalWrite(PIN_LED_SL1, HIGH);
        out_relay ^= RELAY_8;
    } else if (but_status[IDX_BUT_SL1] == PRES_UP) {
        digitalWrite(PIN_LED_SL1, (out_relay & RELAY_8) ? HIGH : LOW);
    }

    // but_status[8]: NÚT S9 (ĐÈN TRANH ĐẦU GIƯỜNG) -> RELAY 15
    if (but_status[IDX_BUT_S9] == PRES_DOW) {
        digitalWrite(PIN_LED_S9, HIGH);
        out_relay ^= RELAY_15;
    } else if (but_status[IDX_BUT_S9] == PRES_UP) {
        digitalWrite(PIN_LED_S9, (out_relay & RELAY_15) ? HIGH : LOW);
    }

    // ===== PORT 4: PHÒNG TẮM & TRANG ĐIỂM =====
    // but_status[9]: NÚT S3 (ĐÈN PHÒNG TẮM VỊ TRÍ 1) -> RELAY 9 (ĐỒNG BỘ VỚI PORT 6)
    if (but_status[IDX_BUT_S3_BATH1] == PRES_DOW) {
        digitalWrite(PIN_LED_S3_BATH1, HIGH);
        out_relay ^= RELAY_9;
    } else if (but_status[IDX_BUT_S3_BATH1] == PRES_UP) {
        uint8_t state = (out_relay & RELAY_9) ? HIGH : LOW;
        digitalWrite(PIN_LED_S3_BATH1, state);
        digitalWrite(PIN_LED_S3_BATH2, state); // Đồng bộ LED S3 tại cửa phòng tắm
    }

    // but_status[10]: NÚT S4 (ĐÈN GƯƠNG & TRANG ĐIỂM) -> RELAY 10
    if (but_status[IDX_BUT_S4_VANITY] == PRES_DOW) {
        digitalWrite(PIN_LED_S4_VANITY, HIGH);
        out_relay ^= RELAY_10;
    } else if (but_status[IDX_BUT_S4_VANITY] == PRES_UP) {
        digitalWrite(PIN_LED_S4_VANITY, (out_relay & RELAY_10) ? HIGH : LOW);
    }

    // ===== PORT 5: BAN CÔNG & BÀN LÀM VIỆC =====
    // but_status[11]: NÚT S7 (ĐÈN BAN CÔNG) -> RELAY 1
    if (but_status[IDX_BUT_S7_BALCONY] == PRES_DOW) {
        digitalWrite(PIN_LED_S7_BALCONY, HIGH);
        out_relay ^= RELAY_1;
    } else if (but_status[IDX_BUT_S7_BALCONY] == PRES_UP) {
        digitalWrite(PIN_LED_S7_BALCONY, (out_relay & RELAY_1) ? HIGH : LOW);
    }

    // but_status[12]: NÚT S8 (ĐÈN BÀN LÀM VIỆC) -> RELAY 16
    if (but_status[IDX_BUT_S8_DESK] == PRES_DOW) {
        digitalWrite(PIN_LED_S8_DESK, HIGH);
        out_relay ^= RELAY_16;
    } else if (but_status[IDX_BUT_S8_DESK] == PRES_UP) {
        digitalWrite(PIN_LED_S8_DESK, (out_relay & RELAY_16) ? HIGH : LOW);
    }

    // ===== PORT 6: ĐÈN PHÒNG TẮM VỊ TRÍ 2 (CỬA PHÒNG TẮM) =====
    // but_status[13]: NÚT S3 (VỊ TRÍ 2) -> RELAY 9 (ĐỒNG BỘ VỚI PORT 4)
    if (but_status[IDX_BUT_S3_BATH2] == PRES_DOW) {
        digitalWrite(PIN_LED_S3_BATH2, HIGH);
        out_relay ^= RELAY_9;
    } else if (but_status[IDX_BUT_S3_BATH2] == PRES_UP) {
        uint8_t state = (out_relay & RELAY_9) ? HIGH : LOW;
        digitalWrite(PIN_LED_S3_BATH2, state);
        digitalWrite(PIN_LED_S3_BATH1, state); // Đồng bộ LED S3 trong phòng tắm
    }

    // ===== PORT 7: NÚT TỔNG MASTER (BEDSIDE RIGHT) =====
    // but_status[14]: NÚT MASTER -> TẮT HẾT ĐÈN TRỪ ĐÈN SẢNH SL1 (RELAY 8)
    if (but_status[IDX_BUT_MASTER] == PRES_DOW) {
        digitalWrite(PIN_LED_MASTER, HIGH);
        MASTER_SWITCH = 1;
    } else if (but_status[IDX_BUT_MASTER] == PRES_UP) {
        digitalWrite(PIN_LED_MASTER, LOW);
        MASTER_SWITCH = 0;
    }

    // ===== PORT 8: ĐẦU GIƯỜNG TRÁI (BEDSIDE LEFT) =====
    // but_status[15]: NÚT S6 (ĐÈN ĐỌC SÁCH TRẦN ĐẦU GIƯỜNG) -> RELAY 2
    if (but_status[IDX_BUT_S6_READING] == PRES_DOW) {
        digitalWrite(PIN_LED_S6_READING, HIGH);
        out_relay ^= RELAY_2;
    } else if (but_status[IDX_BUT_S6_READING] == PRES_UP) {
        digitalWrite(PIN_LED_S6_READING, (out_relay & RELAY_2) ? HIGH : LOW);
    }

    // but_status[16]: NÚT S11 (ĐÈN NGỦ CHÂN TỦ ĐẦU GIƯỜNG) -> RELAY 14
    if (but_status[IDX_BUT_S11_NIGHT] == PRES_DOW) {
        digitalWrite(PIN_LED_S11_NIGHT, HIGH);
        out_relay ^= RELAY_14;
    } else if (but_status[IDX_BUT_S11_NIGHT] == PRES_UP) {
        digitalWrite(PIN_LED_S11_NIGHT, (out_relay & RELAY_14) ? HIGH : LOW);
    }

    // ===== PORT 9: DỰ PHÒNG 1 & 2 =====
    if (but_status[IDX_BUT_SPARE1] == PRES_DOW) {
        digitalWrite(PIN_LED_SPARE1, !digitalRead(PIN_LED_SPARE1));
    }
    if (but_status[IDX_BUT_SPARE2] == PRES_DOW) {
        digitalWrite(PIN_LED_SPARE2, !digitalRead(PIN_LED_SPARE2));
    }

    // ===== PORT 10: DỊCH VỤ TRONG PHÒNG (MUR & DND) =====
    // but_status[19]: NÚT MUR (YÊU CẦU DỌN PHÒNG)
    if (but_status[IDX_BUT_MUR_IN] == PRES_DOW) {
        if (!DO_NOT_DISTURB) {
            uint8_t mur_new = !digitalRead(PIN_LED_MUR_IN);
            digitalWrite(PIN_LED_MUR_IN, mur_new);
            digitalWrite(PIN_LED_MUR_OUT, mur_new);
        }
    }

    // but_status[20]: NÚT DND (XIN ĐỪNG LÀM PHIỀN)
    if (but_status[IDX_BUT_DND_IN] == PRES_DOW) {
        uint8_t dnd_new = !digitalRead(PIN_LED_DND_IN);
        digitalWrite(PIN_LED_DND_IN, dnd_new);
        digitalWrite(PIN_LED_DND_OUT, dnd_new);

        // Khi bật DND -> Tự động hủy MUR
        digitalWrite(PIN_LED_MUR_IN, LOW);
        digitalWrite(PIN_LED_MUR_OUT, LOW);

        DO_NOT_DISTURB ^= 0x01;
    }

    // ===== PORT 11: DỰ PHÒNG 3 & 4 =====
    if (but_status[IDX_BUT_SPARE3] == PRES_DOW) {
        digitalWrite(PIN_LED_SPARE3, !digitalRead(PIN_LED_SPARE3));
    }
    if (but_status[IDX_BUT_SPARE4] == PRES_DOW) {
        digitalWrite(PIN_LED_SPARE4, !digitalRead(PIN_LED_SPARE4));
    }

    // ===== PORT 12: CẢM BIẾN CẮM THẺ PHÒNG (KEYCARD) =====
    if (but_status[IDX_BUT_KEYCARD] == PRES_DOW) {
        KEYCARD_COUNTER_CLOSE = 0;
        KEYCARD_INSERT = 1;
    } else if (but_status[IDX_BUT_KEYCARD] == PRES_UP) {
        KEYCARD_INSERT = 0;
    }

    // ===== XỬ LÝ LỆNH MASTER SWITCH =====
    if (MASTER_SWITCH == 1) {
        // Tắt toàn bộ relay tải trừ SL1 (RELAY_8)
        out_relay &= ~RELAY_1;
        out_relay &= ~RELAY_2;
        out_relay &= ~RELAY_3;
        out_relay &= ~RELAY_4;
        out_relay &= ~RELAY_5;
        out_relay &= ~RELAY_6;
        out_relay &= ~RELAY_7;
        out_relay |= RELAY_8;   // SL1 VẪN BẬT KHI NHẤN MASTER
        out_relay &= ~RELAY_16;
        out_relay &= ~RELAY_15;
        out_relay &= ~RELAY_14;
        out_relay &= ~RELAY_13;
        out_relay &= ~RELAY_10;
        out_relay &= ~RELAY_9;

        // Tắt tất cả LED phản hồi ngoại trừ LED SL1
        digitalWrite(PIN_LED_SPARE3, LOW);
        digitalWrite(PIN_LED_SPARE4, LOW);
        digitalWrite(PIN_LED_SPARE1, LOW);
        digitalWrite(PIN_LED_SPARE2, LOW);

        digitalWrite(PIN_LED_MUR_IN, LOW);
        digitalWrite(PIN_LED_DND_IN, LOW);
        DO_NOT_DISTURB = 0;

        digitalWrite(PIN_LED_S6_READING, LOW);
        digitalWrite(PIN_LED_S11_NIGHT, LOW);

        digitalWrite(PIN_LED_S3_BATH2, LOW);
        digitalWrite(PIN_LED_S7_BALCONY, LOW);
        digitalWrite(PIN_LED_S8_DESK, LOW);

        digitalWrite(PIN_LED_S3_BATH1, LOW);
        digitalWrite(PIN_LED_S4_VANITY, LOW);

        digitalWrite(PIN_LED_SL1, HIGH); // LED SL1 BẬT SÁNG
        digitalWrite(PIN_LED_S9, LOW);

        digitalWrite(PIN_LED_S1, LOW);
        digitalWrite(PIN_LED_S2, LOW);
        digitalWrite(PIN_LED_S5, LOW);

        digitalWrite(PIN_LED_MUR_OUT, LOW);
        digitalWrite(PIN_LED_DND_OUT, LOW);
    }

    // Xuất ngay 32-bit trạng thái mới ra IC ghi dịch 74HC595
    shiftRegister_write32(out_relay);
}

void roomLogic_processLoop(void) {
    // 1. Xử lý tắt chuông cửa sau khoảng thời gian định sẵn
    if (BELL_ENABLE) {
        BELL_COUNTER++;
        if (BELL_COUNTER >= BELL_TIMEOUT_CYCLES) {
            out_relay &= ~RELAY_13;  // Tắt chuông cửa
            shiftRegister_write32(out_relay);
            BELL_COUNTER = 0;
            BELL_ENABLE = 0;
        }
    }

    // 2. Xử lý Thẻ phòng (Keycard)
    if (KEYCARD_INSERT) {
        KEYCARD_COUNTER++;
        KEYCARD_COUNTER_CLOSE = 0;

        if (KEYCARD_COUNTER >= KEYCARD_INSERT_CYCLES) {
            KEYCARD_COUNTER = 0;
            if (!KEYCARD_ENABLE) {
                // Tự động bật các tải chào đón khi cắm thẻ:
                // RELAY_12: Ổ cắm (Socket)
                // RELAY_11: Điều hòa (AC)
                // RELAY_15: Đèn tranh đầu giường (S9)
                // RELAY_8:  Đèn sảnh lối vào (SL1)
                out_relay |= (RELAY_12 | RELAY_11 | RELAY_15 | RELAY_8);
                shiftRegister_write32(out_relay);

                digitalWrite(PIN_LED_SL1, HIGH); // Bật LED SL1
                digitalWrite(PIN_LED_S9, HIGH);  // Bật LED S9

                KEYCARD_ENABLE = 1;
            }
        }
    }

    if (!KEYCARD_INSERT) {
        KEYCARD_COUNTER_CLOSE++;
        if (KEYCARD_COUNTER_CLOSE >= KEYCARD_REMOVE_CYCLES) {
            KEYCARD_COUNTER_CLOSE = 0;
            KEYCARD_ENABLE = 0;

            // Rút thẻ -> Tắt toàn bộ thiết bị và LED trong phòng
            out_relay = 0;
            shiftRegister_write32(out_relay);

            roomLogic_turnOffAllLeds();
            DO_NOT_DISTURB = 0;
        }
    }
}
