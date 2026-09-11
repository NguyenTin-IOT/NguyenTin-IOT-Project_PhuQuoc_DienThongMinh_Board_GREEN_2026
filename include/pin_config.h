/**
 * ====================================================================================================
 * @file        pin_config.h
 * @brief       BẢNG CẤU HÌNH TẬP TRUNG TOÀN BỘ CHÂN I/O & THÔNG SỐ HỆ THỐNG
 * @project     PQ-TWINROOM - Hotel Room Controller (STM32F103VCT6)
 * @details     Định nghĩa toàn bộ chân Input, Output, 74HC595, Relay Mosfet và các thông số thời gian.
 *              Khi cần thay đổi chân tại hiện trường, CHỈ CẦN SỬA DUY NHẤT TẠI FILE NÀY!
 * ====================================================================================================
 */

#ifndef PIN_CONFIG_H
#define PIN_CONFIG_H

#include <Arduino.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ====================================================================================================
 * 1. CẤU HÌNH CHÂN ĐIỀU KHIỂN IC GHI DỊCH 74HC595 (XUẤT 32 BIT RA CÁC RELAY)
 * ====================================================================================================
 */
#define PIN_RELAY_DS            PD2     // Dữ liệu nối tiếp (Serial Data Input - DS / SER)
#define PIN_RELAY_OE            PD1     // Chân cho phép xuất (Output Enable - OE, Tích cực mức 0)
#define PIN_RELAY_ST_CP         PD0     // Xung chốt ngõ ra (Storage Register Clock - ST_CP / RCLK)
#define PIN_RELAY_SH_CP         PC12    // Xung dịch dữ liệu (Shift Register Clock - SH_CP / SRCLK)

/* ====================================================================================================
 * 2. CẤU HÌNH CHÂN NGUỒN 12V RELAY VÀ ĐÈN BÁO TRẠNG THÁI BO MẠCH
 * ====================================================================================================
 */
#define PIN_RELAY_PWR_12V       PC14    // Kích Mosfet IRF9530 cấp nguồn 12V cho cuộn dây Relay (1 = BẬT, 0 = TẮT)
#define PIN_SPARE_PWR_C15       PC15    // Dự phòng nguồn / Mosfet phụ (Mặc định mức 0)
#define PIN_STAT_LED            PA12    // Đèn LED báo trạng thái bo mạch CPU (Màu xanh dương)
#define PIN_HEARTBEAT_A8        PA8     // Đèn LED phụ trợ / Heartbeat đảo trạng thái mỗi chu kỳ quét phím

// Các chân dự phòng phần cứng (Spare / Duphong)
#define PIN_SPARE_PC9           PC9     // Dự phòng 66 (Mặc định kéo HIGH)
#define PIN_SPARE_PD6           PD6     // Dự phòng 87 (Mặc định kéo HIGH)
#define PIN_SPARE_PD7           PD7     // Dự phòng 88 (Mặc định kéo HIGH)
#define PIN_SPARE_PB3           PB3     // Dự phòng 89 (Mặc định kéo HIGH, chân JTDO giải phóng về GPIO)
#define PIN_SPARE_PB4           PB4     // Dự phòng 90 (Mặc định kéo HIGH, chân JNTRST giải phóng về GPIO)

/* ====================================================================================================
 * 3. CẤU HÌNH 24 NÚT NHẤN / CẢM BIẾN ĐẦU VÀO (INPUTS - TÍCH CỰC MỨC THẤP / ACTIVE LOW)
 * ====================================================================================================
 */
// --- PORT 1: KHU VỰC NGOÀI CỬA PHÒNG (DOOR OUTSIDE) ---
#define PIN_BUT_MUR_OUT         PE2     // Nút MUR ngoài cửa (Chỉ đọc/dự phòng cổng)
#define PIN_BUT_DND_OUT         PE4     // Nút DND ngoài cửa (Chỉ đọc/dự phòng cổng)
#define PIN_BUT_BELL_OUT        PE6     // Nút Chuông cửa ngoài phòng (Doorbell Button)

// --- PORT 2: CÔNG TẮC ĐÈN 1 - 2 - 5 ---
#define PIN_BUT_S1              PC0     // Nút S1: Đèn chiếu sáng chính 1
#define PIN_BUT_S2              PC2     // Nút S2: Đèn chiếu sáng chính 2
#define PIN_BUT_S5              PA0     // Nút S5: Đèn đầu giường (Bedside)

// --- PORT 3: CÔNG TẮC LỐI VÀO (ENTRANCE) ---
#define PIN_BUT_ENTRANCE_NC     PC5     // Dự phòng lối vào (Không dùng)
#define PIN_BUT_SL1             PB1     // Nút SL1: Đèn sảnh lối vào (Lobby Entrance Light)
#define PIN_BUT_S9              PE7     // Nút S9: Đèn tranh đầu giường (Picture Light)

// --- PORT 4: CÔNG TẮC PHÒNG TẮM & TRANG ĐIỂM (BATH & VANITY) ---
#define PIN_BUT_S3_BATH1        PE9     // Nút S3: Đèn trần phòng tắm & bồn tắm nằm (Vị trí 1)
#define PIN_BUT_S4_VANITY       PE11    // Nút S4: Đèn trang trí gương & hắt trần phòng tắm

// --- PORT 5: CÔNG TẮC BAN CÔNG & BÀN LÀM VIỆC ---
#define PIN_BUT_S7_BALCONY      PE13    // Nút S7: Đèn ban công ngoài trời
#define PIN_BUT_S8_DESK         PE15    // Nút S8: Đèn trần bàn làm việc (Study Desk Downlight)

// --- PORT 6: CÔNG TẮC ĐÈN TẮM VỊ TRÍ 2 (ĐẢO CHIỀU VỚI S3 VỊ TRÍ 1) ---
#define PIN_BUT_S3_BATH2        PB11    // Nút S3: Đèn phòng tắm (Vị trí 2 - Cửa phòng tắm)

// --- PORT 7: CÔNG TẮC TỔNG (MASTER SWITCH) ---
#define PIN_BUT_MASTER          PB13    // Nút MASTER: Tắt toàn bộ đèn phòng, giữ lại đèn sảnh SL1

// --- PORT 8: CÔNG TẮC ĐẦU GIƯỜNG TRÁI (BEDSIDE LEFT) ---
#define PIN_BUT_S6_READING      PB15    // Nút S6: Đèn đọc sách trên trần đầu giường
#define PIN_BUT_S11_NIGHT       PD9     // Nút S11: Đèn ngủ gầm tủ đầu giường (Nightlight)

// --- PORT 9: CÔNG TẮC DỰ PHÒNG 1 & 2 ---
#define PIN_BUT_SPARE1          PD11    // Nút dự phòng 1 (Nhấn toggle LED test)
#define PIN_BUT_SPARE2          PD13    // Nút dự phòng 2 (Nhấn toggle LED test)

// --- PORT 10: CÔNG TẮC DỊCH VỤ TRONG PHÒNG (SERVICE INSIDE ROOM) ---
#define PIN_BUT_MUR_IN          PD15    // Nút MUR: Yêu cầu dọn phòng (Make Up Room)
#define PIN_BUT_DND_IN          PC7     // Nút DND: Chế độ xin đừng làm phiền (Do Not Disturb)

// --- PORT 11: CÔNG TẮC DỰ PHÒNG 3 & 4 ---
#define PIN_BUT_SPARE3          PB6     // Nút dự phòng 3 (Nhấn toggle LED test)
#define PIN_BUT_SPARE4          PB8     // Nút dự phòng 4 (Nhấn toggle LED test)

// --- PORT 12: CẢM BIẾN CẮM THẺ PHÒNG (KEYCARD SENSOR) ---
#define PIN_BUT_KEYCARD         PE0     // Cảm biến cắm thẻ phòng (Keycard Switch - 0: Có thẻ, 1: Rút thẻ)

/* ====================================================================================================
 * 4. CẤU HÌNH 16+ ĐÈN LED PHẢN HỒI TRÊN MẶT CÔNG TẮC (OUTPUTS - TÍCH CỰC MỨC CAO / ACTIVE HIGH)
 * ====================================================================================================
 */
// --- PORT 1: ĐÈN BÁO NGOÀI CỬA (OUTSIDE INDICATORS) ---
#define PIN_LED_MUR_OUT         PE3     // LED MUR ngoài cửa (Báo yêu cầu dọn phòng)
#define PIN_LED_DND_OUT         PE5     // LED DND ngoài cửa (Báo xin đừng làm phiền)
#define PIN_LED_BELL_OUT        PC13    // LED Nút chuông ngoài cửa (Sáng khi đang bấm chuông)

// --- PORT 2: LED BÁO CÔNG TẮC ĐÈN 1 - 2 - 5 ---
#define PIN_LED_S1              PC1     // LED phản hồi S1 (Đèn 1)
#define PIN_LED_S2              PC3     // LED phản hồi S2 (Đèn 2)
#define PIN_LED_S5              PA1     // LED phản hồi S5 (Đèn đầu giường)

// --- PORT 3: LED BÁO LỐI VÀO (ENTRANCE) ---
#define PIN_LED_SL1             PB0     // LED phản hồi SL1 (Đèn sảnh Lobby)
#define PIN_LED_S9              PB2     // LED phản hồi S9 (Đèn tranh)

// --- PORT 4: LED BÁO PHÒNG TẮM & TRANG ĐIỂM ---
#define PIN_LED_S3_BATH1        PE8     // LED phản hồi S3 (Đèn phòng tắm vị trí 1)
#define PIN_LED_S4_VANITY       PE10    // LED phản hồi S4 (Đèn trang điểm)
#define PIN_LED_PORT4_SPARE     PE12    // LED dự phòng Port 4

// --- PORT 5: LED BÁO BAN CÔNG & BÀN LÀM VIỆC ---
#define PIN_LED_S7_BALCONY      PE14    // LED phản hồi S7 (Đèn ban công)
#define PIN_LED_S8_DESK         PB10    // LED phản hồi S8 (Đèn bàn làm việc)

// --- PORT 6: LED BÁO PHÒNG TẮM VỊ TRÍ 2 ---
#define PIN_LED_S3_BATH2        PB12    // LED phản hồi S3 (Đèn phòng tắm vị trí 2 - đồng bộ với LED_S3_BATH1)

// --- PORT 7: LED BÁO NÚT TỔNG MASTER ---
#define PIN_LED_MASTER          PB14    // LED phản hồi Nút Master (Sáng khi nhấn giữ Master)

// --- PORT 8: LED BÁO ĐẦU GIƯỜNG TRÁI ---
#define PIN_LED_S6_READING      PD8     // LED phản hồi S6 (Đèn đọc sách)
#define PIN_LED_S11_NIGHT       PD10    // LED phản hồi S11 (Đèn ngủ)

// --- PORT 9: LED DỰ PHÒNG 1 & 2 ---
#define PIN_LED_SPARE1          PD12    // LED phản hồi dự phòng 1
#define PIN_LED_SPARE2          PD14    // LED phản hồi dự phòng 2

// --- PORT 10: LED BÁO DỊCH VỤ TRONG PHÒNG ---
#define PIN_LED_MUR_IN          PC6     // LED MUR trong phòng (Đồng bộ với LED MUR ngoài cửa)
#define PIN_LED_DND_IN          PC8     // LED DND trong phòng (Đồng bộ với LED DND ngoài cửa)

// --- PORT 11: LED DỰ PHÒNG 3 & 4 ---
#define PIN_LED_SPARE3          PB7     // LED phản hồi dự phòng 3
#define PIN_LED_SPARE4          PB9     // LED phản hồi dự phòng 4

// --- PORT 12: LED KHAY CẮM THẺ PHÒNG ---
#define PIN_LED_KEYCARD         PE1     // LED chỉ dẫn khe cắm thẻ phòng

/* ====================================================================================================
 * 5. CẤU HÌNH CHÂN TRUYỀN THÔNG (RS485, DIMMER, ETHERNET)
 * ====================================================================================================
 */
#define PIN_RS485_1_DE          PA11    // RS485 Cổng 1 (Chân điều hướng TX/RX DE1)
#define PIN_RS485_4_DE          PA15    // RS485 Cổng 4 Touch Panel (Chân điều hướng TX/RX DE4 - Remap từ JTDI)
#define PIN_ETH_CS              PA4     // Chân chọn chip Ethernet ENC28J60 (CS)
#define PIN_ETH_RST             PC4     // Chân Reset Ethernet ENC28J60 (RST)

/* ====================================================================================================
 * 6. HẰNG SỐ THỜI GIAN & THÔNG SỐ VẬN HÀNH HỆ THỐNG
 * ====================================================================================================
 */
#define SCAN_TIMER_INTERVAL_US  20000   // Chu kỳ ngắt Timer quét nút: 20,000 us (20ms)
#define BUTTON_SAMPLE_COUNT     2       // Số mẫu kiểm tra chống rung phím (2 mẫu = 40ms)
#define TOTAL_BUTTONS           24      // Tổng số ngõ vào nút nhấn / cảm biến

// Thời gian trễ bảo vệ khởi động nguồn Relay 12V
#define POWERON_DELAY_1_MS      1500    // Trễ ổn định nguồn lúc vừa bật điện
#define POWERON_DELAY_2_MS      1000    // Trễ sau khi khởi tạo Timer trước khi đóng Mosfet 12V

// Thông số thời gian chuông cửa & thẻ phòng (Khớp với vòng lặp MCU 72MHz)
#define BELL_TIMEOUT_CYCLES     0x1DFFFF // Số chu kỳ vòng lặp duy trì chuông (~300 - 500ms)
#define KEYCARD_INSERT_CYCLES   0x0FFF   // Số chu kỳ xác nhận cắm thẻ (~10 - 20ms debounce)
#define KEYCARD_REMOVE_CYCLES   0xFFFFFF // Số chu kỳ duy trì điện sau khi rút thẻ (Bộ Hager có thêm trễ ~30s)

#ifdef __cplusplus
}
#endif

#endif // PIN_CONFIG_H
