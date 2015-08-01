#******************************************************************************
#
# Makefile - Rules for building the uart_echo example.
#
# Copyright (c) 2013-2014 Texas Instruments Incorporated.  All rights reserved.
# Software License Agreement
# 
# Texas Instruments (TI) is supplying this software for use solely and
# exclusively on TI's microcontroller products. The software is owned by
# TI and/or its suppliers, and is protected under applicable copyright
# laws. You may not combine this software with "viral" open-source
# software in order to form a larger program.
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
# CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
# 
# This is part of revision 2.1.0.12573 of the EK-TM4C1294XL Firmware Package.
#
#******************************************************************************

#
# The base directory for TivaWare.
#
ROOT=.

#
# Include the common make definitions.
#
include ${ROOT}/makedefs

#
# Where to find header files that do not live in the source directory.
#
IPATH=./inc
IPATH+=./driverlib/chip/inc
IPATH+=./driverlib/board/inc
VPATH=./driver
VPATH+=./driverlib/board/src
VPATH+=./driverlib/chip/src
#
# The default rule, which causes the uart_echo example to be built.
#
all: ${COMPILER}
all: ${COMPILER}/pstn.axf

#
# The rule to clean out all the build products.
#
clean:
	@rm -rf ${COMPILER} ${wildcard *~}
install:
	openocd -f openocd.cfg -c "flash_image"
#	"c:/Program Files/STMicroelectronics/Software/Flash Loader Demonstrator/STMFlashLoader.exe" -c --pn 1 --br 115200 --db 8 --pr EVEN --sb 1 --ec OFF  --to 10000 -i STM32F0_16K -e --sec 13 0 1 2 3 4 5 6 7 8 9 10 11 12 -d --fn gcc/pstn.bin --a 0x08000000 --v -r --a 8000000
reset:
	openocd -f openocd.cfg -c "reset1"

#
# The rule to create the target directory.
#
${COMPILER}:
	@mkdir -p ${COMPILER}

#
# Rules for building the uart_echo example.
#
${COMPILER}/pstn.axf: ${COMPILER}/startup_${COMPILER}.o
${COMPILER}/pstn.axf: ${COMPILER}/sysinit.o
${COMPILER}/pstn.axf: ${COMPILER}/syscalls.o
${COMPILER}/pstn.axf: ${COMPILER}/board_sysinit.o
${COMPILER}/pstn.axf: ${COMPILER}/board.o
${COMPILER}/pstn.axf: ${COMPILER}/adc.o
${COMPILER}/pstn.axf: ${COMPILER}/adc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/can_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/chip_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/clock_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/cmp_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/crc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/dac_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/eeprom_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/emc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/enet_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/gpdma_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/gpio_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/gpioint_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/i2c_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/i2s_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/iap.o
${COMPILER}/pstn.axf: ${COMPILER}/iocon_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/lcd_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/pmu_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/ring_buffer.o
${COMPILER}/pstn.axf: ${COMPILER}/ritimer_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/rtc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/sdc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/sdmmc_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/spi_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/ssp_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/stopwatch_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/sysctl_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/sysinit_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/timer_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/uart_17xx_40xx.o
${COMPILER}/pstn.axf: ${COMPILER}/wwdt_17xx_40xx.o
#${COMPILER}/pstn.axf: ${ROOT}/driverlib/${COMPILER}/libdriver.a
${COMPILER}/pstn.axf: lpc1768.ld
SCATTERgcc_pstn=lpc1768.ld
ENTRY_pstn=Reset_Handler
CFLAGSgcc=-DCORE_M3 

#
# Include the automatically generated dependency files.
#
ifneq (${MAKECMDGOALS},clean)
-include ${wildcard ${COMPILER}/*.d} __dummy__
endif
