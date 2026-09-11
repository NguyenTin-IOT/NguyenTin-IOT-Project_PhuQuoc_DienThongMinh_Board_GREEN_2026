# TÀI LIỆU CẤU HÌNH & HƯỚNG DẪN VẬN HÀNH HỆ THỐNG PQ-TWINROOM
**Dự Án:** Bộ Điều Khiển Phòng Khách Sạn / Căn Hộ (Hotel Room Controller)  
**Vi Điều Khiển:** STM32F103VCT6 (LQFP-100, 256KB Flash, 48KB SRAM, 72MHz)  
**Môi Trường Lập Trình:** Visual Studio Code + PlatformIO (Framework Arduino-STM32)  
**Thiết Bị Nạp / Gỡ Lỗi:** Mạch nạp ST-Link V2 (Giao thức SWD: SWDIO-PA13, SWCLK-PA14)  

---

## MỤC LỤC
1. [Giới Thiệu Kiến Trúc Hệ Thống](#1-giới-thiệu-kiến-trúc-hệ-thống)
2. [Bảng Cấu Trúc Toàn Bộ Chân Vi Điều Khiển (Pinout Map)](#2-bảng-cấu-trúc-toàn-bộ-chân-vi-điều-khiển-pinout-map)
3. [Bảng Ánh Xạ 16 Relay Qua IC Chốt 74HC595](#3-bảng-ánh-xạ-16-relay-qua-ic-chốt-74hc595)
4. [Cấu Trúc Logic Hoạt Động (Bật / Tắt / Liên Động)](#4-cấu-trúc-logic-hoạt-động-bật--tắt--liên-động)
5. [Quy Trình Khởi Động & Bảo Vệ Nguồn 12V Relay](#5-quy-trình-khởi-động--bảo-vệ-nguồn-12v-relay)
6. [Hướng Dẫn Sửa Đổi Nhanh Trong Tình Huống Cấp Bách](#6-hướng-dẫn-sửa-đổi-nhanh-trong-tình-huống-cấp-bách)
7. [ĐOẠN PROMPT CHUẨN KHI CẦN SỬA GẤP TẠI CÔNG TRÌNH](#7-đoạn-prompt-chuẩn-khi-cần-sửa-gấp-tại-công-trình)

---

## 1. GIỚI THIỆU KIẾN TRÚC HỆ THỐNG

Dự án được thiết kế chuyên dụng cho hệ thống điều khiển phòng khách sạn cao cấp, vận hành 24/7 với độ tin cậy và an toàn điện tối đa:
- **Cấu hình tập trung tại một nơi:** Toàn bộ chân kết nối phần cứng và hằng số thời gian được quản lý tập trung tại file [`include/pin_config.h`](file:///include/pin_config.h).
- **Bộ lọc chống nhiễu / chống dội nút bấm (Debounce):** Được thực thi trong ngắt Timer phần cứng `TIM1` chu kỳ **20ms**, lấy 2 mẫu liên tiếp (40ms xác nhận trạng thái), triệt tiêu hoàn toàn tia lửa điện và nhiễu cảm ứng trên dây dẫn dài từ mặt công tắc về tủ điện trung tâm.
- **Mở rộng Relay qua IC ghi dịch 74HC595:** Điều khiển chuỗi 16/32 Relay chỉ với 4 chân vi điều khiển (`DS`, `OE`, `ST_CP`, `SH_CP`), giúp tiết kiệm chân và cách ly nhiễu cuộn hút.
- **Bảo vệ chống nảy rơ-le khi khởi động:** Sử dụng Mosfet P-Channel IRF9530 điều khiển bằng chân `PC14` để ngắt hoàn toàn nguồn 12V cấp cuộn dây Relay khi vừa cắm điện. Sau 2.5 giây khi vi điều khiển đã ổn định, nguồn 12V mới được đóng.
- **Giải phóng JTAG:** Kích hoạt chức năng `__HAL_AFIO_REMAP_SWJ_NOJTAG()` giúp các chân `PB3`, `PB4`, `PA15` hoạt động độc lập như GPIO thông thường mà vẫn giữ 2 chân `PA13` (SWDIO) và `PA14` (SWCLK) để nạp code và debug bằng ST-Link.

---

## 2. BẢNG CẤU TRÚC TOÀN BỘ CHÂN VI ĐIỀU KHIỂN (PINOUT MAP)

### 2.1. Nhóm Điều Khiển 74HC595 (Relay Output)
| Tên Tín Hiệu | Chân MCU | Cấu Hình | Mức Tích Cực | Mô Tả Chức Năng |
| :--- | :---: | :---: | :---: | :--- |
| `PIN_RELAY_DS` | **PD2** | OUTPUT | 0/1 | Đường truyền dữ liệu nối tiếp (Serial Data Input) |
| `PIN_RELAY_OE` | **PD1** | OUTPUT | Mức THẤP (0) | Chân cho phép xuất (Output Enable - 0: Bật, 1: Khóa ngõ ra) |
| `PIN_RELAY_ST_CP` | **PD0** | OUTPUT | Xung cạnh lên (0->1) | Xung chốt ngõ ra (Storage Register Clock / Latch Clock) |
| `PIN_RELAY_SH_CP` | **PC12** | OUTPUT | Xung cạnh lên (0->1) | Xung dịch dữ liệu (Shift Register Clock) |

### 2.2. Nhóm Nguồn 12V Relay & Đèn Trạng Thái Bo Mạch
| Tên Tín Hiệu | Chân MCU | Cấu Hình | Mức Tích Cực | Mô Tả Chức Năng |
| :--- | :---: | :---: | :---: | :--- |
| `PIN_RELAY_PWR_12V` | **PC14** | OUTPUT | Mức CAO (1) | Kích Mosfet IRF9530 cấp nguồn 12V cho cuộn dây Relay |
| `PIN_SPARE_PWR_C15` | **PC15** | OUTPUT | Mức CAO (1) | Dự phòng nguồn phụ / Mosfet phụ (Mặc định mức 0) |
| `PIN_STAT_LED` | **PA12** | OUTPUT | Mức CAO (1) | Đèn LED báo nguồn/trạng thái bo mạch CPU (Màu xanh da trời) |
| `PIN_HEARTBEAT_A8` | **PA8** | OUTPUT | Đảo trạng thái | Đèn báo xung quét phím (Đảo trạng thái mỗi 20ms) |
| `PIN_SPARE_PC9` | **PC9** | OUTPUT | Mức CAO (1) | Chân dự phòng 66 (Mặc định kéo HIGH) |
| `PIN_SPARE_PD6` | **PD6** | OUTPUT | Mức CAO (1) | Chân dự phòng 87 (Mặc định kéo HIGH) |
| `PIN_SPARE_PD7` | **PD7** | OUTPUT | Mức CAO (1) | Chân dự phòng 88 (Mặc định kéo HIGH) |
| `PIN_SPARE_PB3` | **PB3** | OUTPUT | Mức CAO (1) | Chân dự phòng 89 (Giải phóng từ chân JTDO) |
| `PIN_SPARE_PB4` | **PB4** | OUTPUT | Mức CAO (1) | Chân dự phòng 90 (Giải phóng từ chân JNTRST) |

### 2.3. Nhóm 24 Nút Bấm / Cảm Biến Đầu Vào (Inputs - Tích Cực Mức THẤP / Active LOW)
> *Lưu ý:* Tất cả các chân đều được cấu hình nội vi `INPUT_PULLUP`. Khi tiếp điểm đóng xuống GND, MCU đọc mức 0.

| Cổng (Port) | Index | Chân MCU | Tên Nút / Cảm Biến | Tải / Chức Năng Tương Ứng |
| :--- | :---: | :---: | :--- | :--- |
| **PORT 1** | 0 | **PE2** | `PIN_BUT_MUR_OUT` | Nút MUR ngoài cửa (Dự phòng cổng ngoài) |
| | 1 | **PE4** | `PIN_BUT_DND_OUT` | Nút DND ngoài cửa (Dự phòng cổng ngoài) |
| | 2 | **PE6** | `PIN_BUT_BELL_OUT` | **Nút Chuông cửa (Doorbell Button)** ngoài hành lang |
| **PORT 2** | 3 | **PC0** | `PIN_BUT_S1` | **Nút S1:** Đèn chiếu sáng chính 1 (Relay 7) |
| | 4 | **PC2** | `PIN_BUT_S2` | **Nút S2:** Đèn chiếu sáng chính 2 (Relay 6) |
| | 5 | **PA0** | `PIN_BUT_S5` | **Nút S5:** Đèn đầu giường Bedside (Relay 3) |
| **PORT 3** | 6 | **PC5** | `PIN_BUT_ENTRANCE_NC`| Nút dự phòng lối vào (Không dùng) |
| | 7 | **PB1** | `PIN_BUT_SL1` | **Nút SL1:** Đèn sảnh lối vào Lobby (Relay 8) |
| | 8 | **PE7** | `PIN_BUT_S9` | **Nút S9:** Đèn tranh đầu giường Picture (Relay 15) |
| **PORT 4** | 9 | **PE9** | `PIN_BUT_S3_BATH1` | **Nút S3 (Vị trí 1):** Đèn trần phòng tắm & bồn tắm (Relay 9) |
| | 10 | **PE11** | `PIN_BUT_S4_VANITY` | **Nút S4:** Đèn trang trí gương & hắt trần phòng tắm (Relay 10) |
| **PORT 5** | 11 | **PE13** | `PIN_BUT_S7_BALCONY`| **Nút S7:** Đèn ban công ngoài trời (Relay 1) |
| | 12 | **PE15** | `PIN_BUT_S8_DESK` | **Nút S8:** Đèn bàn làm việc Study Desk (Relay 16) |
| **PORT 6** | 13 | **PB11** | `PIN_BUT_S3_BATH2` | **Nút S3 (Vị trí 2):** Đèn phòng tắm tại cửa ra vào (Relay 9) |
| **PORT 7** | 14 | **PB13** | `PIN_BUT_MASTER` | **Nút MASTER:** Tắt toàn bộ đèn phòng, giữ lại đèn sảnh SL1 |
| **PORT 8** | 15 | **PB15** | `PIN_BUT_S6_READING`| **Nút S6:** Đèn đọc sách trần đầu giường (Relay 2) |
| | 16 | **PD9** | `PIN_BUT_S11_NIGHT` | **Nút S11:** Đèn ngủ gầm tủ đầu giường Nightlight (Relay 14) |
| **PORT 9** | 17 | **PD11** | `PIN_BUT_SPARE1` | Nút dự phòng 1 (Nhấn toggle LED test) |
| | 18 | **PD13** | `PIN_BUT_SPARE2` | Nút dự phòng 2 (Nhấn toggle LED test) |
| **PORT 10** | 19 | **PD15** | `PIN_BUT_MUR_IN` | **Nút MUR trong phòng:** Yêu cầu dọn phòng |
| | 20 | **PC7** | `PIN_BUT_DND_IN` | **Nút DND trong phòng:** Chế độ xin đừng làm phiền |
| **PORT 11** | 21 | **PB6** | `PIN_BUT_SPARE3` | Nút dự phòng 3 (Nhấn toggle LED test) |
| | 22 | **PB8** | `PIN_BUT_SPARE4` | Nút dự phòng 4 (Nhấn toggle LED test) |
| **PORT 12** | 23 | **PE0** | `PIN_BUT_KEYCARD` | **Cảm biến Thẻ phòng (Keycard Sensor):** 0 = Cắm thẻ, 1 = Rút thẻ |

### 2.4. Nhóm Đèn LED Phản Hồi Trên Mặt Công Tắc (Outputs - Tích Cực Mức CAO / Active HIGH)
| Cổng (Port) | Chân MCU | Tên Đèn LED | Chức Năng Báo Hiệu |
| :--- | :---: | :--- | :--- |
| **PORT 1** | **PE3** | `PIN_LED_MUR_OUT` | LED MUR ngoài cửa (Khách yêu cầu dọn phòng) |
| | **PE5** | `PIN_LED_DND_OUT` | LED DND ngoài cửa (Khách yêu cầu không làm phiền) |
| | **PC13** | `PIN_LED_BELL_OUT` | LED Nút chuông ngoài cửa (Sáng khi đang bấm chuông) |
| **PORT 2** | **PC1** | `PIN_LED_S1` | LED phản hồi Đèn chính 1 |
| | **PC3** | `PIN_LED_S2` | LED phản hồi Đèn chính 2 |
| | **PA1** | `PIN_LED_S5` | LED phản hồi Đèn đầu giường |
| **PORT 3** | **PB0** | `PIN_LED_SL1` | LED phản hồi Đèn sảnh lối vào SL1 |
| | **PB2** | `PIN_LED_S9` | LED phản hồi Đèn tranh đầu giường S9 |
| **PORT 4** | **PE8** | `PIN_LED_S3_BATH1` | LED phản hồi Đèn tắm S3 (Đồng bộ với LED tại Port 6) |
| | **PE10** | `PIN_LED_S4_VANITY`| LED phản hồi Đèn gương trang điểm S4 |
| | **PE12** | `PIN_LED_PORT4_SPARE`| LED dự phòng Port 4 |
| **PORT 5** | **PE14** | `PIN_LED_S7_BALCONY`| LED phản hồi Đèn ban công S7 |
| | **PB10** | `PIN_LED_S8_DESK` | LED phản hồi Đèn bàn làm việc S8 |
| **PORT 6** | **PB12** | `PIN_LED_S3_BATH2` | LED phản hồi Đèn tắm S3 (Đồng bộ với LED tại Port 4) |
| **PORT 7** | **PB14** | `PIN_LED_MASTER` | LED phản hồi Nút Master Switch |
| **PORT 8** | **PD8** | `PIN_LED_S6_READING`| LED phản hồi Đèn đọc sách S6 |
| | **PD10** | `PIN_LED_S11_NIGHT`| LED phản hồi Đèn ngủ S11 |
| **PORT 9** | **PD12** | `PIN_LED_SPARE1` | LED phản hồi nút dự phòng 1 |
| | **PD14** | `PIN_LED_SPARE2` | LED phản hồi nút dự phòng 2 |
| **PORT 10** | **PC6** | `PIN_LED_MUR_IN` | LED MUR trong phòng (Đồng bộ với LED ngoài cửa PE3) |
| | **PC8** | `PIN_LED_DND_IN` | LED DND trong phòng (Đồng bộ với LED ngoài cửa PE5) |
| **PORT 11** | **PB7** | `PIN_LED_SPARE3` | LED phản hồi nút dự phòng 3 |
| | **PB9** | `PIN_LED_SPARE4` | LED phản hồi nút dự phòng 4 |
| **PORT 12** | **PE1** | `PIN_LED_KEYCARD` | LED chỉ dẫn khe cắm thẻ phòng |

### 2.5. Nhóm Chân Truyền Thông Mở Rộng (Ngoại Vi)
| Tên Tín Hiệu | Chân MCU | Hướng | Mô Tả |
| :--- | :---: | :---: | :--- |
| `PIN_RS485_1_DE` | **PA11** | OUTPUT | Chân điều hướng truyền nhận DE cho cổng RS485 số 1 |
| `PIN_RS485_4_DE` | **PA15** | OUTPUT | Chân điều hướng DE cho cổng RS485 số 4 (Màn hình cảm ứng Touch Panel - Giải phóng từ JTDI) |
| `PIN_ETH_CS` | **PA4** | OUTPUT | Chân chọn chip SPI cho module Ethernet ENC28J60 (Dự phòng) |
| `PIN_ETH_RST` | **PC4** | OUTPUT | Chân Reset cho module Ethernet ENC28J60 (Dự phòng) |

---

## 3. BẢNG ÁNH XẠ 16 RELAY QUA IC CHỐT 74HC595

Dữ liệu điều khiển Relay là số nguyên không dấu 32-bit (`out_relay`). Thứ tự xuất bit qua hàm `shiftRegister_write32()` được dịch từ MSB (bit 31) xuống LSB (bit 0):

| Tên Trong Code | Vị Trí Bit | Mặt Nạ (Bitmask) | Ký Hiệu Mạch | Tên Tải Điện Thực Tế Điều Khiển |
| :--- | :---: | :---: | :---: | :--- |
| `RELAY_1` | Bit 0 | `1UL << 0` | **RL8** | **Đèn Ban Công (S7)** |
| `RELAY_2` | Bit 1 | `1UL << 1` | **RL7** | **Đèn Đọc Sách Đầu Giường (S6)** |
| `RELAY_3` | Bit 2 | `1UL << 2` | **RL6** | **Đèn Chiếu Sáng Đầu Giường (S5)** |
| `RELAY_4` | Bit 3 | `1UL << 3` | **RL5** | Rèm Đóng / Tải Mở Rộng RL5 |
| `RELAY_5` | Bit 4 | `1UL << 4` | **RL4** | Rèm Mở / Tải Mở Rộng RL4 |
| `RELAY_6` | Bit 5 | `1UL << 5` | **RL3** | **Đèn Chiếu Sáng Chính 2 (S2)** |
| `RELAY_7` | Bit 6 | `1UL << 6` | **RL2** | **Đèn Chiếu Sáng Chính 1 (S1)** |
| `RELAY_8` | Bit 7 | `1UL << 7` | **RL1** | **Đèn Sảnh Lối Vào (SL1 - Giữ sáng khi bấm Master)** |
| `RELAY_9` | Bit 8 | `1UL << 8` | **RL16** | **Đèn Trần Phòng Tắm & Bồn Tắm Nằm (S3 - Đảo Chiều)** |
| `RELAY_10`| Bit 9 | `1UL << 9` | **RL15** | **Đèn Trang Trí Gương & Hắt Trần Phòng Tắm (S4)** |
| `RELAY_11`| Bit 10 | `1UL << 10` | **RL14** | **Nguồn Điều Hòa Không Khí (AC)** |
| `RELAY_12`| Bit 11 | `1UL << 11` | **RL13** | **Nguồn Ổ Cắm Điện Theo Thẻ Phòng (Power Socket)** |
| `RELAY_13`| Bit 12 | `1UL << 12` | **RL12** | **Chuông Cửa (Doorbell Chime)** |
| `RELAY_14`| Bit 13 | `1UL << 13` | **RL11** | **Đèn Ngủ Gầm Tủ Đầu Giường (S11 Nightlight)** |
| `RELAY_15`| Bit 14 | `1UL << 14` | **RL10** | **Đèn Tranh Trang Trí Đầu Giường (S9)** |
| `RELAY_16`| Bit 15 | `1UL << 15` | **RL9** | **Đèn Bàn Làm Việc (S8 Study Desk)** |

---

## 4. CẤU TRÚC LOGIC HOẠT ĐỘNG (BẬT / TẮT / LIÊN ĐỘNG)

### 4.1. Logic Chuông Cửa (Doorbell - PE6)
- **Khi nhấn nút chuông (`PE6`):**
  - LED nút chuông ngoài cửa (`PC13`) bật sáng ngay lập tức.
  - Kiểm tra cờ `DO_NOT_DISTURB`:
    - Nếu **KHÔNG BẬT DND (`DO_NOT_DISTURB == 0`):** Kích hoạt `RELAY_13` (Chuông reo), bật cờ `BELL_ENABLE = 1`.
    - Nếu **ĐANG BẬT DND (`DO_NOT_DISTURB == 1`):** Không kích Relay chuông (chuông im lặng, tránh làm phiền khách đang nghỉ ngơi).
- **Khi nhả nút chuông:**
  - LED nút chuông ngoài cửa (`PC13`) tắt.
  - Chuông tiếp tục reo cho đến khi biến đếm `BELL_COUNTER >= BELL_TIMEOUT_CYCLES` trong vòng lặp `loop()`, hệ thống tự động tắt `RELAY_13` và reset bộ đếm chuông.

### 4.2. Logic Các Cụm Đèn Đơn (S1, S2, S5, S6, S7, S8, S9, S11)
- Vận hành theo cơ chế **Chuyển Mạch (Toggle):**
  - Nhấn nút lần 1: Bật Relay tương ứng, bật sáng đèn LED phản hồi trên mặt công tắc.
  - Nhấn nút lần 2: Tắt Relay tương ứng, tắt đèn LED phản hồi trên mặt công tắc.
- **Quan hệ cụ thể:**
  - Nút S1 (`PC0`) $\leftrightarrow$ Relay 7 (`RL2`) $\leftrightarrow$ LED S1 (`PC1`).
  - Nút S2 (`PC2`) $\leftrightarrow$ Relay 6 (`RL3`) $\leftrightarrow$ LED S2 (`PC3`).
  - Nút S5 (`PA0`) $\leftrightarrow$ Relay 3 (`RL6`) $\leftrightarrow$ LED S5 (`PA1`).
  - Nút S6 (`PB15`) $\leftrightarrow$ Relay 2 (`RL7`) $\leftrightarrow$ LED S6 (`PD8`).
  - Nút S7 (`PE13`) $\leftrightarrow$ Relay 1 (`RL8`) $\leftrightarrow$ LED S7 (`PE14`).
  - Nút S8 (`PE15`) $\leftrightarrow$ Relay 16 (`RL9`) $\leftrightarrow$ LED S8 (`PB10`).
  - Nút S9 (`PE7`) $\leftrightarrow$ Relay 15 (`RL10`) $\leftrightarrow$ LED S9 (`PB2`).
  - Nút S11 (`PD9`) $\leftrightarrow$ Relay 14 (`RL11`) $\leftrightarrow$ LED S11 (`PD10`).
  - Nút SL1 (`PB1`) $\leftrightarrow$ Relay 8 (`RL1`) $\leftrightarrow$ LED SL1 (`PB0`).

### 4.3. Logic Công Tắc Đảo Chiều 2 Vị Trí Cho Đèn Phòng Tắm (S3)
- Đèn phòng tắm (Relay 9 / `RL16`) được điều khiển độc lập từ **2 vị trí khác nhau:**
  - Vị trí 1: Cụm công tắc trong phòng tắm (Nút `PE9`, LED `PE8`).
  - Vị trí 2: Cụm công tắc tại cửa ra vào phòng tắm (Nút `PB11`, LED `PB12`).
- **Liên động:**
  - Khách bấm ở vị trí nào thì Relay 9 cũng đảo trạng thái (Bật $\rightarrow$ Tắt hoặc Tắt $\rightarrow$ Bật).
  - Khi đèn thay đổi trạng thái, **cả 2 đèn LED phản hồi `PE8` và `PB12` tự động đồng bộ cùng sáng hoặc cùng tắt**, giúp báo hiệu chính xác ở cả 2 đầu.

### 4.4. Logic Công Tắc Tổng Master Switch (Bedside Right - PB13)
- Được bố trí tại đầu giường bên phải để khách chuẩn bị đi ngủ hoặc rời phòng:
- **Khi nhấn nút Master:**
  - Bật đèn LED Master (`PB14`).
  - Kích hoạt chế độ tắt toàn bộ đèn: Tắt Relay 1, 2, 3, 4, 5, 6, 7, 9, 10, 13, 14, 15, 16.
  - **ĐẶC BIỆT:** **Giữ lại Relay 8 (Đèn sảnh lối vào SL1) luôn BẬT** để khách vẫn có ánh sáng định hướng khi thức dậy trong đêm.
  - Tắt toàn bộ đèn LED phản hồi trên các mặt công tắc trong phòng, **chỉ giữ lại duy nhất đèn LED SL1 (`PB0`) BẬT**.
  - Hủy trạng thái DND (`DO_NOT_DISTURB = 0`).
- **Khi nhả nút Master:**
  - LED Master (`PB14`) tắt, trả hệ thống về chế độ hoạt động bình thường.

### 4.5. Logic Liên Động Dịch Vụ Khách Sạn: DND (Không Làm Phiền) & MUR (Dọn Phòng)
- **Nút MUR trong phòng (`PD15`):**
  - Nếu **đang bật DND:** Không cho phép kích hoạt MUR.
  - Nếu **không bật DND:** Nhấn nút sẽ đảo trạng thái đèn báo MUR trong phòng (`PC6`) và đèn báo MUR ngoài cửa (`PE3`) đồng thời.
- **Nút DND trong phòng (`PC7`):**
  - Nhấn nút sẽ đảo trạng thái DND (`DO_NOT_DISTURB ^= 0x01`).
  - Đèn báo DND trong phòng (`PC8`) và ngoài cửa (`PE5`) tự động đồng bộ trạng thái.
  - **KHÓA LIÊN ĐỘNG (INTERLOCK):** Khi bật DND, hệ thống **tự động tắt ngay lập tức đèn báo MUR** cả trong phòng (`PC6`) lẫn ngoài cửa (`PE3`).
  - Khi DND đang bật, **nút chuông ngoài cửa sẽ bị vô hiệu hóa âm thanh**.

### 4.6. Logic Cảm Biến Cắm Thẻ Phòng (Keycard Sensor - PE0)
- Phù hợp với các loại khay cắm thẻ thông dụng (như Hager, Schneider, v.v.):
- **Khi khách cắm thẻ (`PE0` xuống mức 0):**
  - Bộ lọc thời gian đếm xác nhận cắm thẻ (`KEYCARD_COUNTER >= KEYCARD_INSERT_CYCLES`).
  - Sau khi xác nhận thẻ đã cắm:
    - Bật ngay Relay 12 (`RL13` - Ổ cắm điện phòng).
    - Bật ngay Relay 11 (`RL14` - Nguồn điều hòa nhiệt độ AC).
    - Bật ngay Relay 15 (`RL10` - Đèn tranh đầu giường S9 chào đón).
    - Bật ngay Relay 8 (`RL1` - Đèn sảnh lối vào SL1 chào đón).
    - Bật sáng đèn LED SL1 (`PB0`) và LED S9 (`PB2`).
- **Khi khách rút thẻ (`PE0` lên mức 1):**
  - Hệ thống duy trì điện đếm thời gian trễ an toàn (`KEYCARD_COUNTER_CLOSE >= KEYCARD_REMOVE_CYCLES`). *(Lưu ý: Bộ khay thẻ Hager bản thân đã có độ trễ cơ học/mạch trễ khoảng 30 giây)*.
  - Hết thời gian trễ:
    - Cắt toàn bộ 16 Relay (`out_relay = 0`), tắt toàn bộ điện thiết bị trong phòng.
    - Tắt toàn bộ các đèn LED chỉ thị trên mặt công tắc.
    - Tự động xóa trạng thái DND.

---

## 5. QUY TRÌNH KHỞI ĐỘNG & BẢO VỆ NGUỒN 12V RELAY

Để triệt tiêu hiện tượng sụt áp, tia lửa điện và rơ-le nhảy loạn xạ khi vừa cấp điện lưới vào tủ điện, hệ thống thực hiện nghiêm ngặt chuỗi khởi động tuần tự:

```
[BẬT NGUỒN TỦ ĐIỆN]
       │
       ▼
1. Giữ PC14 = 0 (Khóa Mosfet IRF9530, CUỘN HÚT RELAY 12V CHƯA CÓ ĐIỆN)
       │
       ▼
2. Xuất toàn bộ 0 ra IC 74HC595 (out_relay = 0, chốt ngõ ra an toàn)
       │
       ▼
3. Cấu hình GPIO (24 Input kéo PULL-UP, các chân LED kéo LOW)
       │
       ▼
4. Cấu hình Remap AFIO (Nhả PB3, PB4, PA15 về GPIO, giữ SWD PA13/PA14)
       │
       ▼
5. TRỄ AN TOÀN LẦN 1: 1500ms (Chờ nguồn 3.3V và 5V vi điều khiển ổn định)
       │
       ▼
6. Khởi tạo Timer phần cứng TIM1 chu kỳ 20ms
       │
       ▼
7. TRỄ AN TOÀN LẦN 2: 1000ms (Chờ ngoại vi và các mạch cảm biến ổn định)
       │
       ▼
8. KÍCH PC14 = 1 (Mở Mosfet IRF9530 cấp nguồn 12V cho các cuộn dây Relay)
       │
       ▼
9. Kích hoạt ngắt Timer TIM1 bắt đầu quét phím và vận hành phòng
```

---

## 6. HƯỚNG DẪN SỬA ĐỔI NHANH TRONG TÌNH HUỐNG CẤP BÁCH

Khi đang đi công trình hoặc lắp đặt tại nhà khách, nếu gặp tình huống:
- Đứt dây, chập chân vi điều khiển, cần chuyển chức năng sang chân dự phòng.
- Đổi nút nhấn từ công tắc này sang công tắc khác.
- Đổi chân điều khiển Relay hoặc chân cấp nguồn Mosfet.

### Các Bước Thực Hiện:
1. Mở file [`include/pin_config.h`](file:///include/pin_config.h).
2. Tìm đến mục tương ứng (Mục 1: 74HC595, Mục 2: Nguồn, Mục 3: Nút nhấn, Mục 4: LED phản hồi).
3. Đổi tên chân vi điều khiển (ví dụ: muốn đổi nút S1 từ `PC0` sang chân dự phòng `PD11`, chỉ cần sửa `#define PIN_BUT_S1 PD11`).
4. Lưu file và mở Terminal trong VSCode gõ lệnh nạp lại:
   ```bash
   pio run -t upload
   ```
5. Toàn bộ logic nội bộ, bộ lọc chống dội và điều khiển LED sẽ tự động áp dụng sang chân mới mà không cần chỉnh sửa bất kỳ dòng code nào khác!

---

## 7. ĐOẠN PROMPT CHUẨN KHI CẦN SỬA GẤP TẠI CÔNG TRÌNH

> **HƯỚNG DẪN:** Khi bạn đang ở công trình nhà khách và cần AI hỗ trợ sửa gấp chân cắm hoặc thay đổi logic hoạt động, hãy **sao chép toàn bộ đoạn khung bên dưới**, điền các thông tin bạn muốn thay đổi vào dấu ngoặc vuông `[...]` và gửi cho AI:

```markdown
Chào bạn, tôi đang trực tiếp lắp đặt và vận hành hệ thống PQ-TWINROOM trên bo mạch STM32F103VCT6 (dùng VSCode + PlatformIO Arduino).
Hệ thống hiện tại có cấu hình tập trung trong file include/pin_config.h, mapping relay trong include/relay_map.h và logic vận hành trong src/room_logic.cpp.

Tôi đang có việc gấp cần bạn xử lý ngay:
[MÔ TẢ YÊU CẦU CỦA BẠN TẠI ĐÂY, VÍ DỤ:]
1. Đổi chân:
   - Chân cũ: [Ví dụ: Nút S1 đang ở chân PC0 bị chập] -> Hãy chuyển sang chân mới: [Ví dụ: PD11]
   - Đèn LED phản hồi cũ: [Ví dụ: LED S1 đang ở chân PC1] -> Hãy chuyển sang chân mới: [Ví dụ: PD12]
2. Thay đổi logic (nếu có):
   - [Ví dụ: Nút S1 muốn đổi sang điều khiển Relay 6 thay vì Relay 7]
   - [Ví dụ: Nút Master muốn giữ lại cả đèn S9 và SL1 thay vì chỉ giữ SL1]
   - [Ví dụ: Rút thẻ phòng muốn trễ lâu hơn hoặc tắt ngay lập tức]

Yêu cầu đối với bạn:
1. Sửa trực tiếp vào các file tương ứng trong dự án (ưu tiên sửa trong pin_config.h hoặc room_logic.cpp).
2. Giữ nguyên 100% tính năng an toàn hiện có:
   - Quét ngắt 20ms chống dội 2 mẫu (debounce).
   - Bảo vệ nguồn Relay 12V (Mosfet PC14 trễ 2.5s khi khởi động).
   - Giữ giải phóng JTAG (PB3, PB4, PA15) và giữ SWD (PA13, PA14) cho ST-Link.
   - Giữ nguyên logic đồng bộ LED và tính năng chống làm phiền DND / chuông cửa.
3. Sau khi sửa, hãy tự động chạy lệnh kiểm tra biên dịch bằng PlatformIO:
   & "$env:USERPROFILE\.platformio\penv\Scripts\platformio.exe" run
   để đảm bảo code biên dịch thành công 100% không có bất kỳ lỗi nào trước khi báo lại cho tôi nạp mạch.
```
