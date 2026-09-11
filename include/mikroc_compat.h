#ifndef MIKROC_COMPAT_H
#define MIKROC_COMPAT_H

#include <Arduino.h>
#include <stm32f1xx.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#ifdef __cplusplus
extern "C" {
#endif

// MikroC keyword compatibility
#define code
#define sfr
#define sbit

#define delay_ms(ms) delay(ms)
#define Delay_ms(ms) delay(ms)

// ARM Cortex-M3 Bit-Band Alias Helper for 1-instruction bit operations
#define BITBAND_PERIPH_REF(addr, bit) (*((volatile uint32_t *)(0x42000000 + ((uint32_t)&(addr) - 0x40000000) * 32 + (bit) * 4)))
#define GPIO_BIT(port, reg, bit) BITBAND_PERIPH_REF((port)->reg, bit)

// String and utility functions in MikroC
static inline void LongWordToStr(uint32_t input, char *output) {
    sprintf(output, "%lu", (unsigned long)input);
}

// STM32F103 Flash Programming Register Helper
static inline void FLASH_ErasePage(uint32_t Address) {
    FLASH->KEYR = 0x45670123;
    FLASH->KEYR = 0xCDEF89AB;
    FLASH->CR |= FLASH_CR_PER;
    FLASH->AR = Address;
    FLASH->CR |= FLASH_CR_STRT;
    while (FLASH->SR & FLASH_SR_BSY);
    FLASH->CR &= ~FLASH_CR_PER;
    FLASH->CR |= FLASH_CR_LOCK;
}

static inline void FLASH_Write_Word(uint32_t Address, uint32_t Data) {
    FLASH->KEYR = 0x45670123;
    FLASH->KEYR = 0xCDEF89AB;
    FLASH->CR |= FLASH_CR_PG;
    *(volatile uint16_t*)Address = (uint16_t)(Data & 0xFFFF);
    while (FLASH->SR & FLASH_SR_BSY);
    *(volatile uint16_t*)(Address + 2) = (uint16_t)(Data >> 16);
    while (FLASH->SR & FLASH_SR_BSY);
    FLASH->CR &= ~FLASH_CR_PG;
    FLASH->CR |= FLASH_CR_LOCK;
}

// Dummy GPIO_Digital_... macros for legacy MikroC GPIO calls
#define GPIO_Digital_Output(port, mask) do {} while(0)
#define GPIO_Digital_Input(port, mask) do {} while(0)
#define _GPIO_PINMASK_14 0
#define _GPIO_PINMASK_15 0
#define _GPIO_PINMASK_12 0
#define _GPIO_PINMASK_8  0
#define _GPIO_PINMASK_9  0
#define _GPIO_PINMASK_6  0
#define _GPIO_PINMASK_7  0
#define _GPIO_PINMASK_3  0
#define _GPIO_PINMASK_4  0

#ifdef __cplusplus
}
#endif

#endif // MIKROC_COMPAT_H
