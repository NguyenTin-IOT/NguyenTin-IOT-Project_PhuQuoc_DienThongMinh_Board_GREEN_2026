# Phú Quốc Smart Room Controller

Firmware điều khiển phòng khách sạn/căn hộ (RCU) sử dụng **STM32F103VCT6**. Repository gồm hai biến thể theo cấu hình phòng:

| Thư mục | Biến thể | Nền tảng mã nguồn |
| --- | --- | --- |
| [`PQ-TWINROOM-VSCode`](PQ-TWINROOM-VSCode) | Twin Room | PlatformIO + Arduino STM32, kiến trúc module C++ |
| [`PQ-KINGROOM-VSCode`](PQ-KINGROOM-VSCode) | King Room | PlatformIO/VS Code, mã C chuyển đổi từ MikroC |

## Chức năng chính

- Điều khiển relay chiếu sáng, ổ cắm, điều hòa và chuông qua chuỗi **74HC595** (dữ liệu 32 bit; hiện ánh xạ 16 relay).
- Quét 24 ngõ vào công tắc/cảm biến với chu kỳ 20 ms và chống dội 2 mẫu.
- Điều khiển các cụm đèn từ nhiều vị trí, đồng bộ LED phản hồi trên mặt công tắc.
- Hỗ trợ **MUR** (Make Up Room), **DND** (Do Not Disturb), chuông cửa và công tắc tổng Master.
- Điều khiển theo thẻ phòng (keycard): cấp tải khi cắm thẻ, ngắt tải sau thời gian trễ khi rút thẻ.
- Bảo vệ relay lúc khởi động: chỉ cấp nguồn cuộn relay 12 V sau tổng thời gian trễ 2,5 giây.
- Dự phòng giao tiếp RS485 và Ethernet ENC28J60 (Ethernet chưa được kích hoạt mặc định).

## Phần cứng

- MCU: STM32F103VCT6, LQFP-100, 256 KB Flash, 48 KB SRAM, 72 MHz.
- Nạp/debug: ST-Link V2 qua SWD (`PA13`/`PA14`).
- Relay: 74HC595 dùng `PD2` (DS), `PD1` (OE), `PD0` (latch), `PC12` (clock).
- MOSFET cấp nguồn relay 12 V: `PC14`.

> Lưu ý: firmware giải phóng JTAG để dùng `PB3`, `PB4`, `PA15` làm GPIO, nhưng vẫn giữ SWD để nạp và debug.

## Cấu trúc Twin Room

```text
PQ-TWINROOM-VSCode/
├── include/                 # Cấu hình chân, relay và giao diện module
├── src/
│   ├── main.cpp             # Khởi động và vòng lặp chính
│   ├── hw_init.cpp          # Khởi tạo GPIO/nguồn relay
│   ├── button_manager.cpp   # Quét phím và chống dội
│   ├── room_logic.cpp       # Logic vận hành phòng
│   └── shift_register.cpp   # Xuất dữ liệu 74HC595
├── platformio.ini
└── config.md                # Tài liệu cấu hình/pinout chi tiết
```

Các thông số cần thay đổi tại hiện trường (chân GPIO, thời gian quét, thời gian cấp nguồn relay, timeout chuông và thẻ phòng) được tập trung trong:

`PQ-TWINROOM-VSCode/include/pin_config.h`

## Build và nạp firmware

1. Cài [Visual Studio Code](https://code.visualstudio.com/) và extension PlatformIO IDE.
2. Mở riêng thư mục biến thể cần làm việc, ví dụ `PQ-TWINROOM-VSCode`.
3. Kết nối ST-Link V2 qua SWD.
4. Trong Terminal PlatformIO, chạy:

```powershell
pio run
pio run -t upload
```

Hoặc dùng các nút **Build** và **Upload** trong PlatformIO.

Môi trường build hiện dùng `genericSTM32F103VC`, framework Arduino STM32 và giao thức upload `stlink`.

## Quy tắc sửa đổi an toàn

- Đổi chân phần cứng: ưu tiên chỉ sửa file `pin_config.h` của biến thể tương ứng.
- Đổi quan hệ nút nhấn/relay hoặc quy tắc vận hành: sửa module logic (`room_logic.cpp` đối với Twin Room; `src/botrungtam.c` đối với King Room), rồi cập nhật tài liệu cấu hình.
- Không bỏ cơ chế chống dội 20 ms, trễ bảo vệ nguồn relay, hay cấu hình giữ SWD.
- Luôn build thành công trước khi nạp bo mạch thực tế.

## Tài liệu chi tiết

- [Twin Room – cấu hình và vận hành](PQ-TWINROOM-VSCode/config.md)
- [Twin Room – README kỹ thuật](PQ-TWINROOM-VSCode/README.md)
- [King Room – cấu hình và vận hành](PQ-KINGROOM-VSCode/config.md)
- [King Room – README kỹ thuật](PQ-KINGROOM-VSCode/README.md)

## Lưu ý repository

Các thư mục `PQ-*-RL9-10-FIX2LED` chứa tệp dự án/đầu ra từ MikroC (bao gồm `.hex`, `.asm`, `.lst`). Chúng được giữ lại để đối chiếu firmware cũ; mã nguồn phát triển trên VS Code nằm trong `src/`, `include/` và `platformio.ini`.
