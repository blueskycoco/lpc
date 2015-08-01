/* File: startup_ARMCM3.S
 * Purpose: startup file for Cortex-M3 devices. Should use with
 *   GCC for ARM Embedded Processors
 * Version: V1.3
 * Date: 08 Feb 2012
 *
 * Copyright (c) 2012, ARM Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the ARM Limited nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ARM LIMITED BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
    .syntax unified
    .arch armv7-m

    .section .stack
    .align 3
.ifdef __STACK_SIZE
    .equ    Stack_Size, __STACK_SIZE
.else
    .equ    Stack_Size, 0x400
.endif
    .globl    __StackTop
    .globl    __StackLimit
__StackLimit:
    .space    Stack_Size
    .size __StackLimit, . - __StackLimit
__StackTop:
    .size __StackTop, . - __StackTop

    .section .heap
    .align 3
.ifdef __HEAP_SIZE
    .equ    Heap_Size, __HEAP_SIZE
.else
    .equ    Heap_Size, 0xC00
.endif
    .globl    __HeapBase
    .globl    __HeapLimit
__HeapBase:
    .if    Heap_Size
    .space    Heap_Size
    .endif
    .size __HeapBase, . - __HeapBase
__HeapLimit:
    .size __HeapLimit, . - __HeapLimit

    .section .isr_vector
    .align 2
    .globl __isr_vector
__isr_vector:
    .long    __StackTop            /* Top of Stack */
    .long    Reset_Handler         /* Reset Handler */
    .long    NMI_Handler           /* NMI Handler */
    .long    HardFault_Handler     /* Hard Fault Handler */
    .long    MemManage_Handler     /* MPU Fault Handler */
    .long    BusFault_Handler      /* Bus Fault Handler */
    .long    UsageFault_Handler    /* Usage Fault Handler */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    SVC_Handler           /* SVCall Handler */
    .long    DebugMon_Handler      /* Debug Monitor Handler */
    .long    0                     /* Reserved */
    .long    PendSV_Handler        /* PendSV Handler */
    .long    SysTick_Handler       /* SysTick Handler */

    /* External interrupts */
	.long    WDT_IRQHandler                          /*16, 0x40 - WDT*/
    .long    TIMER0_IRQHandler                          /*17, 0x44 - TIMER0*/
    .long    TIMER1_IRQHandler                          /*18, 0x48 - TIMER1*/
    .long    TIMER2_IRQHandler                          /*19, 0x4c - TIMER2*/
    .long    TIMER3_IRQHandler                          /*20, 0x50 - TIMER3*/
    .long    UART0_IRQHandler                          /*21, 0x54 - UART0*/
    .long    UART1_IRQHandler                          /*22, 0x58 - UART1*/
    .long    UART2_IRQHandler                          /*23, 0x5c - UART2*/
    .long    UART3_IRQHandler                          /*24, 0x60 - UART3*/
    .long    PWM1_IRQHandler                          /* 25, 0x64 - PWM1*/
    .long    I2C0_IRQHandler                          /* 26, 0x68 - I2C0*/
    .long    I2C1_IRQHandler                          /* 27, 0x6c - I2C1*/
    .long    I2C2_IRQHandler                          /* 28, 0x70 - I2C2*/
    .long    SPI_IRQHandler                          /*29, 0x74 - SPI*/
    .long    SSP0_IRQHandler                          /* 30, 0x78 - SSP0*/
    .long    SSP1_IRQHandler                          /* 31, 0x7c - SSP1*/
    .long    PLL0_IRQHandler                          /* 32, 0x80 - PLL0 (Main PLL)*/
    .long    RTC_IRQHandler                          /*33, 0x84 - RTC*/
    .long    EINT0_IRQHandler                          /*34, 0x88 - EINT0*/
    .long    EINT1_IRQHandler                          /*35, 0x8c - EINT1*/
    .long    EINT2_IRQHandler                          /*36, 0x90 - EINT2*/
    .long    EINT3_IRQHandler                          /*37, 0x94 - EINT3*/
    .long    ADC_IRQHandler                          /*38, 0x98 - ADC*/
    .long    BOD_IRQHandler                          /*39, 0x9c - BOD*/
    .long    USB_IRQHandler                          /*40, 0xA0 - USB*/
    .long    CAN_IRQHandler                          /*41, 0xa4 - CAN*/
    .long    DMA_IRQHandler                          /*42, 0xa8 - GP DMA*/
    .long    I2S_IRQHandler                          /*43, 0xac - I2S*/
#if defined (__USE_LPCOPEN)
    .long    ETH_IRQHandler                          /*44, 0xb0 - Ethernet*/
#else
    .long    ENET_IRQHandler                          /* 44, 0xb0 - Ethernet*/
#endif
    .long    RIT_IRQHandler                          /*45, 0xb4 - RITINT*/
    .long    MCPWM_IRQHandler                          /*46, 0xb8 - Motor Control PWM*/
    .long    QEI_IRQHandler                          /*47, 0xbc - Quadrature Encoder*/
    .long    PLL1_IRQHandler                          /* 48, 0xc0 - PLL1 (USB PLL)*/
    .long    USBActivity_IRQHandler                          /* 49, 0xc4 - USB Activity interrupt to wakeup*/
    .long    CANActivity_IRQHandler                          /* 50, 0xc8 - CAN Activity interrupt to wakeup*/
    
    .size    __isr_vector, . - __isr_vector

    .text
    .thumb
    .thumb_func
    .align 2
    .globl    Reset_Handler
    .type    Reset_Handler, %function
Reset_Handler:
/*     Loop to copy data from read only memory to RAM. The ranges
 *      of copy from/to are specified by following symbols evaluated in
 *      linker script.
 *      __etext: End of code section, i.e., begin of data sections to copy from.
 *      __data_start__/__data_end__: RAM address range that data should be
 *      copied to. Both must be aligned to 4 bytes boundary.  */

    ldr    r1, =__etext
    ldr    r2, =__data_start__
    ldr    r3, =__data_end__

.if 1
/* Here are two copies of loop implemenations. First one favors code size
 * and the second one favors performance. Default uses the first one.
 * Change to "#if 0" to use the second one */
.flash_to_ram_loop:
    cmp     r2, r3
    ittt    lt
    ldrlt   r0, [r1], #4
    strlt   r0, [r2], #4
    blt    .flash_to_ram_loop
.else
    subs    r3, r2
    ble    .flash_to_ram_loop_end
.flash_to_ram_loop:
    subs    r3, #4
    ldr    r0, [r1, r3]
    str    r0, [r2, r3]
    bgt    .flash_to_ram_loop
.flash_to_ram_loop_end:
.endif

#.ifndef __NO_SYSTEM_INIT
    ldr    r0, =SystemInit
    blx    r0
#.endif
#    ldr     r0, =retarget_init
#    blx     r0

    ldr    r0, =Reset_Handler
    bx    r0
    .pool
    .size Reset_Handler, . - Reset_Handler

/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers */
    .macro    def_irq_handler    handler_name
    .align 1
    .thumb_func
    .weak    \handler_name
    .type    \handler_name, %function
\handler_name :
    b    .
    .size    \handler_name, . - \handler_name
    .endm

    def_irq_handler    NMI_Handler
    def_irq_handler    HardFault_Handler
    def_irq_handler    MemManage_Handler
    def_irq_handler    BusFault_Handler
    def_irq_handler    UsageFault_Handler
    def_irq_handler    SVC_Handler
    def_irq_handler    DebugMon_Handler
    def_irq_handler    PendSV_Handler
    def_irq_handler    SysTick_Handler
    def_irq_handler    Default_Handler

    def_irq_handler    WDT_IRQHandler
    def_irq_handler    RTC_IRQHandler
    def_irq_handler    TIM0_IRQHandler
    def_irq_handler    TIM2_IRQHandler
    def_irq_handler    MCIA_IRQHandler
    def_irq_handler    MCIB_IRQHandler
    def_irq_handler    UART0_IRQHandler
    def_irq_handler    UART1_IRQHandler
    def_irq_handler    UART2_IRQHandler
    def_irq_handler    UART3_IRQHandler
    def_irq_handler    UART4_IRQHandler
    def_irq_handler    AACI_IRQHandler
    def_irq_handler    CLCD_IRQHandler
    def_irq_handler    ENET_IRQHandler
    def_irq_handler    USBDC_IRQHandler
    def_irq_handler    USBHC_IRQHandler
    def_irq_handler    CHLCD_IRQHandler
    def_irq_handler    FLEXRAY_IRQHandler
    def_irq_handler    CAN_IRQHandler
    def_irq_handler    LIN_IRQHandler
    def_irq_handler    I2C_IRQHandler
    def_irq_handler    CPU_CLCD_IRQHandler
    def_irq_handler    SPI_IRQHandler
	def_irq_handler    TIMER0_IRQHandler
	def_irq_handler    TIMER1_IRQHandler
	def_irq_handler    TIMER2_IRQHandler
	def_irq_handler    TIMER3_IRQHandler
	def_irq_handler    PWM1_IRQHandler
	def_irq_handler    I2C0_IRQHandler
	def_irq_handler    I2C1_IRQHandler
	def_irq_handler    I2C2_IRQHandler
	def_irq_handler    SSP0_IRQHandler
	def_irq_handler    SSP1_IRQHandler
	def_irq_handler    PLL0_IRQHandler
	def_irq_handler    EINT0_IRQHandler
	def_irq_handler    EINT1_IRQHandler
	def_irq_handler    EINT2_IRQHandler
	def_irq_handler    EINT3_IRQHandler
	def_irq_handler    BOD_IRQHandler
	def_irq_handler    USB_IRQHandler
	def_irq_handler    I2S_IRQHandler
	def_irq_handler    RIT_IRQHandler
	def_irq_handler    MCPWM_IRQHandler
	def_irq_handler    QEI_IRQHandler
	def_irq_handler    PLL1_IRQHandler
	def_irq_handler    USBActivity_IRQHandler
	def_irq_handler    CANActivity_IRQHandler
    .end