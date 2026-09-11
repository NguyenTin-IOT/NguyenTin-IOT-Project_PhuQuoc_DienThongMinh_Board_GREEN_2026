# Walkthrough - Porting MikroC to PlatformIO (STM32F103VC)

Đã chuyển đổi thành công toàn bộ mã nguồn của dự án `PQ-KINGROOM-RL9-10-FIX2LED` sang môi trường PlatformIO GCC ARM.

## Changes Made

### Configuration & Headers
- **`platformio.ini`**: Cấu hình môi trường `genericSTM32F103VC`, thêm cờ biên dịch `-I include`, `-I src`, `-Wl,--allow-multiple-definition`.
- **`include/mikroc_compat.h`**: Tạo tệp tương thích bao gồm:
  - Macro chuyển đổi từ khóa MikroC (`code`, `sbit`, `sfr`).
  - Bit-banding ARM Cortex-M3 (`GPIO_BIT(...)`) giúp truy cập đọc/ghi thanh ghi I/O chuẩn xác theo thời gian thực (1 instruction).
  - Hàm ghi/xóa Flash STM32 chuẩn (`FLASH_ErasePage`, `FLASH_Write_Word`).
  - Thư viện C chuẩn (`<Arduino.h>`, `<stm32f1xx.h>`, `<string.h>`, `<stdio.h>`, `<ctype.h>`).
- **`include/init.h`**: Đồng bộ kiểu dữ liệu `get_point` và cập nhật macro Bit-band cho các chân 595 và RS485.
- **`include/main.h`**: Loại bỏ `#include "init.c"`, thay thế toàn bộ macro `BUTx_y` và `LED_x_y` bằng macro `GPIO_BIT`.
- **`include/__EthEnc28j60.h`**: Cập nhật khai báo nguyên mẫu hàm cho trình biên dịch GCC ARM.

### Source Files
- **`src/init.c`**: Chuyển đổi toàn bộ hàm khởi tạo thanh ghi (`gpio_init`, `timer1_init`, `usart1_init`, `usart2_init`, `uart4__init`, `rs485_u4`) sang chuẩn CMSIS STM32F103.
- **`src/botrungtam.c`**:
  - Loại bỏ cú pháp `sfr sbit ... at ...`.
  - Đổi tên các hàm ngắt MikroC (`iv IVT_INT_...`) sang trình xử lý ngắt chuẩn GCC ARM (`TIM1_UP_IRQHandler`, `UART4_IRQHandler`).
  - Bổ sung hàm stub ENC28J60 để dự án liên kết (link) hoàn chỉnh.

---

## Verification Results

### Automated Build Verification
Lệnh biên dịch:
```powershell
& "$env:USERPROFILE\.platformio\penv\Scripts\pio.exe" run
```

Kết quả:
```text
========================= [SUCCESS] Took 13.66 seconds =========================
RAM:   [          ]   1.7% (used 860 bytes from 49152 bytes)
Flash: [          ]   1.7% (used 4568 bytes from 262144 bytes)
Building .pio\build\genericSTM32F103VC\firmware.bin
```
Tệp nạp `firmware.elf` và `firmware.bin` đã được tạo ra thành công tại đường dẫn `.pio/build/genericSTM32F103VC/`.
