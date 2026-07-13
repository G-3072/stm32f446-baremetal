
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

.word _sp_init

.word _sidata
.word _sdata
.word _edata

.word _sbss
.word _ebss

.weak _main
.global _main
.type _main, %function

.weak _start
.type _start, %function
.section .text._start 

_start:
    /* set stack pointer register*/
    ldr r0, =_sp_init   /* Load _sp_init symbol into r0 with LDR pseudo instruction */
    mov sp, r0          /* Move r0 into stack-pointer register */
    /* first LDR and then MOV because MOV-instruction on SP-reg can only move register without shift */

    /* copy .data section to ram */
    ldr r0, =_sidata    /* .data start address LMA */
    ldr r1, =_sdata     /* .data start address VMA */
    ldr r2, =_edata     /* .data end address VMA*/
    b copy_data_loop

copy_data:
    ldmia r0!, {r3}
    stmia r1!, {r3}

copy_data_loop:
    cmp r1, r2
    bcc copy_data

    /* Zero .bss section */
    ldr r1, =_sbss
    ldr r2, =_ebss
    mov r3, #0
    b zero_bss_loop

zero_bss:
    stmia r0!, {r3}

zero_bss_loop:
    cmp r1, r2
    bcc zero_bss
    
    bl _main

    b _end

.global _end
.weak _end
.section .text._end, "ax", %progbits

_end:
LoopForever:
    b LoopForever


.global _vectors
.type _vectors, %object
.section .vtable, "a", %progbits

_vectors:
    .word _sp_init

    .word _start

    .weak NMI_Handler
    .thumb_set NMI_Handler, _end
    .word NMI_Handler

    .weak HardFault_Handler
    .thumb_set HardFault_Handler, _end
    .word HardFault_Handler

    .weak MemManage_Handler
    .thumb_set MemManage_Handler, _end
    .word MemManage_Handler

    .weak BusFault_Handler
    .thumb_set BusFault_Handler, _end
    .word BusFault_Handler

    .weak UsageFault_Handler
    .thumb_set UsageFault_Handler, _end
    .word UsageFault_Handler

    .word 0
    .word 0
    .word 0
    .word 0

    .weak SVC_Handler
    .thumb_set SVC_Handler, _end
    .word SVC_Handler

    .weak DebugMon_Handler
    .thumb_set DebugMon_Handler, _end
    .word DebugMon_Handler

    .word 0

    .weak PendSV_Handler
    .thumb_set PendSV_Handler, _end
    .word PendSV_Handler

    .weak SysTick_Handler
    .thumb_set SysTick_Handler, _end
    .word SysTick_Handler

    .weak WWDG_IRQHandler
    .thumb_set WWDG_IRQHandler, _end
    .word WWDG_IRQHandler

    .weak PVD_IRQHandler
    .thumb_set PVD_IRQHandler, _end
    .word PVD_IRQHandler

    .weak TAMP_STAMP_IRQHandler
    .thumb_set TAMP_STAMP_IRQHandler, _end
    .word TAMP_STAMP_IRQHandler

    .weak RTC_WKUP_IRQHandler
    .thumb_set RTC_WKUP_IRQHandler, _end
    .word RTC_WKUP_IRQHandler

    .weak FLASH_IRQHandler
    .thumb_set FLASH_IRQHandler, _end
    .word FLASH_IRQHandler

    .weak RCC_IRQHandler
    .thumb_set RCC_IRQHandler, _end
    .word RCC_IRQHandler

    .weak EXTI0_IRQHandler
    .thumb_set EXTI0_IRQHandler, _end
    .word EXTI0_IRQHandler

    .weak EXTI1_IRQHandler
    .thumb_set EXTI1_IRQHandler, _end
    .word EXTI1_IRQHandler

    .weak EXTI2_IRQHandler
    .thumb_set EXTI2_IRQHandler, _end
    .word EXTI2_IRQHandler

    .weak EXTI3_IRQHandler
    .thumb_set EXTI3_IRQHandler, _end
    .word EXTI3_IRQHandler

    .weak EXTI4_IRQHandler
    .thumb_set EXTI4_IRQHandler, _end
    .word EXTI4_IRQHandler

    .weak DMA1_Stream0_IRQHandler
    .thumb_set DMA1_Stream0_IRQHandler, _end
    .word DMA1_Stream0_IRQHandler

    .weak DMA1_Stream1_IRQHandler
    .thumb_set DMA1_Stream1_IRQHandler, _end
    .word DMA1_Stream1_IRQHandler

    .weak DMA1_Stream2_IRQHandler
    .thumb_set DMA1_Stream2_IRQHandler, _end
    .word DMA1_Stream2_IRQHandler

    .weak DMA1_Stream3_IRQHandler
    .thumb_set DMA1_Stream3_IRQHandler, _end
    .word DMA1_Stream3_IRQHandler

    .weak DMA1_Stream4_IRQHandler
    .thumb_set DMA1_Stream4_IRQHandler, _end
    .word DMA1_Stream4_IRQHandler

    .weak DMA1_Stream5_IRQHandler
    .thumb_set DMA1_Stream5_IRQHandler, _end
    .word DMA1_Stream5_IRQHandler

    .weak DMA1_Stream6_IRQHandler
    .thumb_set DMA1_Stream6_IRQHandler, _end
    .word DMA1_Stream6_IRQHandler

    .weak ADC_IRQHandler
    .thumb_set ADC_IRQHandler, _end
    .word ADC_IRQHandler

    .weak CAN1_TX_IRQHandler
    .thumb_set CAN1_TX_IRQHandler, _end
    .word CAN1_TX_IRQHandler

    .weak CAN1_RX0_IRQHandler
    .thumb_set CAN1_RX0_IRQHandler, _end
    .word CAN1_RX0_IRQHandler

    .weak CAN1_RX1_IRQHandler
    .thumb_set CAN1_RX1_IRQHandler, _end
    .word CAN1_RX1_IRQHandler

    .weak CAN1_SCE_IRQHandler
    .thumb_set CAN1_SCE_IRQHandler, _end
    .word CAN1_SCE_IRQHandler

    .weak EXTI9_5_IRQHandler
    .thumb_set EXTI9_5_IRQHandler, _end
    .word EXTI9_5_IRQHandler

    .weak TIM1_BRK_TIM9_IRQHandler
    .thumb_set TIM1_BRK_TIM9_IRQHandler, _end
    .word TIM1_BRK_TIM9_IRQHandler

    .weak TIM1_UP_TIM10_IRQHandler
    .thumb_set TIM1_UP_TIM10_IRQHandler, _end
    .word TIM1_UP_TIM10_IRQHandler

    .weak TIM1_TRG_COM_TIM11_IRQHandler
    .thumb_set TIM1_TRG_COM_TIM11_IRQHandler, _end
    .word TIM1_TRG_COM_TIM11_IRQHandler

    .weak TIM1_CC_IRQHandler
    .thumb_set TIM1_CC_IRQHandler, _end
    .word TIM1_CC_IRQHandler

    .weak TIM2_IRQHandler
    .thumb_set TIM2_IRQHandler, _end
    .word TIM2_IRQHandler

    .weak TIM3_IRQHandler
    .thumb_set TIM3_IRQHandler, _end
    .word TIM3_IRQHandler

    .weak TIM4_IRQHandler
    .thumb_set TIM4_IRQHandler, _end
    .word TIM4_IRQHandler

    .weak I2C1_EV_IRQHandler
    .thumb_set I2C1_EV_IRQHandler, _end
    .word I2C1_EV_IRQHandler

    .weak I2C1_ER_IRQHandler
    .thumb_set I2C1_ER_IRQHandler, _end
    .word I2C1_ER_IRQHandler

    .weak I2C2_EV_IRQHandler
    .thumb_set I2C2_EV_IRQHandler, _end
    .word I2C2_EV_IRQHandler

    .weak I2C2_ER_IRQHandler
    .thumb_set I2C2_ER_IRQHandler, _end
    .word I2C2_ER_IRQHandler

    .weak SPI1_IRQHandler
    .thumb_set SPI1_IRQHandler, _end
    .word SPI1_IRQHandler

    .weak SPI2_IRQHandler
    .thumb_set SPI2_IRQHandler, _end
    .word SPI2_IRQHandler

    .weak USART1_IRQHandler
    .thumb_set USART1_IRQHandler, _end
    .word USART1_IRQHandler

    .weak USART2_IRQHandler
    .thumb_set USART2_IRQHandler, _end
    .word USART2_IRQHandler

    .weak USART3_IRQHandler
    .thumb_set USART3_IRQHandler, _end
    .word USART3_IRQHandler

    .weak EXTI15_10_IRQHandler
    .thumb_set EXTI15_10_IRQHandler, _end
    .word EXTI15_10_IRQHandler

    .weak RTC_Alarm_IRQHandler
    .thumb_set RTC_Alarm_IRQHandler, _end
    .word RTC_Alarm_IRQHandler

    .weak OTG_FS_WKUP_IRQHandler
    .thumb_set OTG_FS_WKUP_IRQHandler, _end
    .word OTG_FS_WKUP_IRQHandler

    .weak TIM8_BRK_TIM12_IRQHandler
    .thumb_set TIM8_BRK_TIM12_IRQHandler, _end
    .word TIM8_BRK_TIM12_IRQHandler

    .weak TIM8_UP_TIM13_IRQHandler
    .thumb_set TIM8_UP_TIM13_IRQHandler, _end
    .word TIM8_UP_TIM13_IRQHandler

    .weak TIM8_TRG_COM_TIM14_IRQHandler
    .thumb_set TIM8_TRG_COM_TIM14_IRQHandler, _end
    .word TIM8_TRG_COM_TIM14_IRQHandler

    .weak TIM8_CC_IRQHandler
    .thumb_set TIM8_CC_IRQHandler, _end
    .word TIM8_CC_IRQHandler

    .weak DMA1_Stream7_IRQHandler
    .thumb_set DMA1_Stream7_IRQHandler, _end
    .word DMA1_Stream7_IRQHandler

    .weak FMC_IRQHandler
    .thumb_set FMC_IRQHandler, _end
    .word FMC_IRQHandler

    .weak SDIO_IRQHandler
    .thumb_set SDIO_IRQHandler, _end
    .word SDIO_IRQHandler

    .weak TIM5_IRQHandler
    .thumb_set TIM5_IRQHandler, _end
    .word TIM5_IRQHandler

    .weak SPI3_IRQHandler
    .thumb_set SPI3_IRQHandler, _end
    .word SPI3_IRQHandler

    .weak UART4_IRQHandler
    .thumb_set UART4_IRQHandler, _end
    .word UART4_IRQHandler

    .weak UART5_IRQHandler
    .thumb_set UART5_IRQHandler, _end
    .word UART5_IRQHandler

    .weak TIM6_DAC_IRQHandler
    .thumb_set TIM6_DAC_IRQHandler, _end
    .word TIM6_DAC_IRQHandler

    .weak TIM7_IRQHandler
    .thumb_set TIM7_IRQHandler, _end
    .word TIM7_IRQHandler

    .weak DMA2_Stream0_IRQHandler
    .thumb_set DMA2_Stream0_IRQHandler, _end
    .word DMA2_Stream0_IRQHandler

    .weak DMA2_Stream1_IRQHandler
    .thumb_set DMA2_Stream1_IRQHandler, _end
    .word DMA2_Stream1_IRQHandler

    .weak DMA2_Stream2_IRQHandler
    .thumb_set DMA2_Stream2_IRQHandler, _end
    .word DMA2_Stream2_IRQHandler

    .weak DMA2_Stream3_IRQHandler
    .thumb_set DMA2_Stream3_IRQHandler, _end
    .word DMA2_Stream3_IRQHandler

    .weak DMA2_Stream4_IRQHandler
    .thumb_set DMA2_Stream4_IRQHandler, _end
    .word DMA2_Stream4_IRQHandler

    .word 0
    .word 0

    .weak CAN2_TX_IRQHandler
    .thumb_set CAN2_TX_IRQHandler, _end
    .word CAN2_TX_IRQHandler

    .weak CAN2_RX0_IRQHandler
    .thumb_set CAN2_RX0_IRQHandler, _end
    .word CAN2_RX0_IRQHandler

    .weak CAN2_RX1_IRQHandler
    .thumb_set CAN2_RX1_IRQHandler, _end
    .word CAN2_RX1_IRQHandler

    .weak CAN2_SCE_IRQHandler
    .thumb_set CAN2_SCE_IRQHandler, _end
    .word CAN2_SCE_IRQHandler

    .weak OTG_FS_IRQHandler
    .thumb_set OTG_FS_IRQHandler, _end
    .word OTG_FS_IRQHandler

    .weak DMA2_Stream5_IRQHandler
    .thumb_set DMA2_Stream5_IRQHandler, _end
    .word DMA2_Stream5_IRQHandler

    .weak DMA2_Stream6_IRQHandler
    .thumb_set DMA2_Stream6_IRQHandler, _end
    .word DMA2_Stream6_IRQHandler

    .weak DMA2_Stream7_IRQHandler
    .thumb_set DMA2_Stream7_IRQHandler, _end
    .word DMA2_Stream7_IRQHandler

    .weak USART6_IRQHandler
    .thumb_set USART6_IRQHandler, _end
    .word USART6_IRQHandler

    .weak I2C3_EV_IRQHandler
    .thumb_set I2C3_EV_IRQHandler, _end
    .word I2C3_EV_IRQHandler

    .weak I2C3_ER_IRQHandler
    .thumb_set I2C3_ER_IRQHandler, _end
    .word I2C3_ER_IRQHandler

    .weak OTG_HS_EP1_OUT_IRQHandler
    .thumb_set OTG_HS_EP1_OUT_IRQHandler, _end
    .word OTG_HS_EP1_OUT_IRQHandler

    .weak OTG_HS_EP1_IN_IRQHandler
    .thumb_set OTG_HS_EP1_IN_IRQHandler, _end
    .word OTG_HS_EP1_IN_IRQHandler

    .weak OTG_HS_WKUP_IRQHandler
    .thumb_set OTG_HS_WKUP_IRQHandler, _end
    .word OTG_HS_WKUP_IRQHandler

    .weak OTG_HS_IRQHandler
    .thumb_set OTG_HS_IRQHandler, _end
    .word OTG_HS_IRQHandler

    .weak DCMI_IRQHandler
    .thumb_set DCMI_IRQHandler, _end
    .word DCMI_IRQHandler

    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

    .weak SPI4_IRQHandler
    .thumb_set SPI4_IRQHandler, _end
    .word SPI4_IRQHandler

    .word 0
    .word 0

    .weak SAI1_IRQHandler
    .thumb_set SAI1_IRQHandler, _end
    .word SAI1_IRQHandler

    .word 0
    .word 0
    .word 0

    .weak SAI2_IRQHandler
    .thumb_set SAI2_IRQHandler, _end
    .word SAI2_IRQHandler

    .weak QuadSPI_IRQHandler
    .thumb_set QuadSPI_IRQHandler, _end
    .word QuadSPI_IRQHandler

    .weak HDMI_CEC_IRQHandler
    .thumb_set HDMI_CEC_IRQHandler, _end
    .word HDMI_CEC_IRQHandler

    .weak SPDIF_Rx_IRQHandler
    .thumb_set SPDIF_Rx_IRQHandler, _end
    .word SPDIF_Rx_IRQHandler

    .weak FMPI2C1_IRQHandler
    .thumb_set FMPI2C1_IRQHandler, _end
    .word FMPI2C1_IRQHandler

    .weak FMPI2C1_error_IRQHandler
    .thumb_set FMPI2C1_error_IRQHandler, _end
    .word FMPI2C1_error_IRQHandler
