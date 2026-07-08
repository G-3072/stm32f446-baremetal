
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

.global _start
.weak _start
.type _start, %function
.section .text._start, "ax", %progbits

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
    .word NMI_Handler
    .word HardFault_Handler
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word DebugMon_Handler
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler
    .word WWDG_IRQHandler
    .word PVD_IRQHandler
    .word TAMP_STAMP_IRQHandler
    .word RTC_WKUP_IRQHandler
    .word FLASH_IRQHandler
    .word RCC_IRQHandler
    .word EXTI0_IRQHandler
    .word EXTI1_IRQHandler
    .word EXTI2_IRQHandler
    .word EXTI3_IRQHandler
    .word EXTI4_IRQHandler
    .word DMA1_Stream0_IRQHandler
    .word DMA1_Stream1_IRQHandler
    .word DMA1_Stream2_IRQHandler
    .word DMA1_Stream3_IRQHandler
    .word DMA1_Stream4_IRQHandler
    .word DMA1_Stream5_IRQHandler
    .word DMA1_Stream6_IRQHandler
    .word ADC_IRQHandler
    .word CAN1_TX_IRQHandler
    .word CAN1_RX0_IRQHandler
    .word CAN1_RX1_IRQHandler
    .word CAN1_SCE_IRQHandler
    .word EXTI9_5_IRQHandler
    .word TIM1_BRK_TIM9_IRQHandler
    .word TIM1_UP_TIM10_IRQHandler
    .word TIM1_TRG_COM_TIM11_IRQHandler
    .word TIM1_CC_IRQHandler
    .word TIM2_IRQHandler
    .word TIM3_IRQHandler
    .word TIM4_IRQHandler
    .word I2C1_EV_IRQHandler
    .word I2C1_ER_IRQHandler
    .word I2C2_EV_IRQHandler
    .word I2C2_ER_IRQHandler
    .word SPI1_IRQHandler
    .word SPI2_IRQHandler
    .word USART1_IRQHandler
    .word USART2_IRQHandler
    .word USART3_IRQHandler
    .word EXTI15_10_IRQHandler
    .word RTC_Alarm_IRQHandler
    .word OTG_FS_WKUP_IRQHandler
    .word TIM8_BRK_TIM12_IRQHandler
    .word TIM8_UP_TIM13_IRQHandler
    .word TIM8_TRG_COM_TIM14_IRQHandler
    .word TIM8_CC_IRQHandler
    .word DMA1_Stream7_IRQHandler
    .word FMC_IRQHandler
    .word SDIO_IRQHandler
    .word TIM5_IRQHandler
    .word SPI3_IRQHandler
    .word UART4_IRQHandler
    .word UART5_IRQHandler
    .word TIM6_DAC_IRQHandler
    .word TIM7_IRQHandler
    .word DMA2_Stream0_IRQHandler
    .word DMA2_Stream1_IRQHandler
    .word DMA2_Stream2_IRQHandler
    .word DMA2_Stream3_IRQHandler
    .word DMA2_Stream4_IRQHandler
    .word 0
    .word 0
    .word CAN2_TX_IRQHandler
    .word CAN2_RX0_IRQHandler
    .word CAN2_RX1_IRQHandler
    .word CAN2_SCE_IRQHandler
    .word OTG_FS_IRQHandler
    .word DMA2_Stream5_IRQHandler
    .word DMA2_Stream6_IRQHandler
    .word DMA2_Stream7_IRQHandler
    .word USART6_IRQHandler
    .word I2C3_EV_IRQHandler
    .word I2C3_ER_IRQHandler
    .word OTG_HS_EP1_OUT_IRQHandler
    .word OTG_HS_EP1_IN_IRQHandler
    .word OTG_HS_WKUP_IRQHandler
    .word OTG_HS_IRQHandler
    .word DCMI_IRQHandler
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word SPI4_IRQHandler
    .word 0
    .word 0
    .word SAI1_IRQHandler
    .word 0
    .word 0
    .word 0
    .word SAI2_IRQHandler
    .word QuadSPI_IRQHandler
    .word HDMI_CEC_IRQHandler
    .word SPDIF_Rx_IRQHandler
    .word FMPI2C1_IRQHandler
    .word FMPI2C1_error_IRQHandler

        .weak _sp_init
        .thumb_set _sp_init,_end

        .weak _start
        .thumb_set _start,_end

        .weak NMI_Handler
        .thumb_set NMI_Handler,_end

        .weak HardFault_Handler
        .thumb_set HardFault_Handler,_end

        .weak MemManage_Handler
        .thumb_set MemManage_Handler,_end

        .weak BusFault_Handler
        .thumb_set BusFault_Handler,_end

        .weak UsageFault_Handler
        .thumb_set UsageFault_Handler,_end

        .weak SVC_Handler
        .thumb_set SVC_Handler,_end

        .weak DebugMon_Handler
        .thumb_set DebugMon_Handler,_end

        .weak PendSV_Handler
        .thumb_set PendSV_Handler,_end

        .weak SysTick_Handler
        .thumb_set SysTick_Handler,_end

        .weak WWDG_IRQHandler
        .thumb_set WWDG_IRQHandler,_end

        .weak PVD_IRQHandler
        .thumb_set PVD_IRQHandler,_end

        .weak TAMP_STAMP_IRQHandler
        .thumb_set TAMP_STAMP_IRQHandler,_end

        .weak RTC_WKUP_IRQHandler
        .thumb_set RTC_WKUP_IRQHandler,_end

        .weak FLASH_IRQHandler
        .thumb_set FLASH_IRQHandler,_end

        .weak RCC_IRQHandler
        .thumb_set RCC_IRQHandler,_end

        .weak EXTI0_IRQHandler
        .thumb_set EXTI0_IRQHandler,_end

        .weak EXTI1_IRQHandler
        .thumb_set EXTI1_IRQHandler,_end

        .weak EXTI2_IRQHandler
        .thumb_set EXTI2_IRQHandler,_end

        .weak EXTI3_IRQHandler
        .thumb_set EXTI3_IRQHandler,_end

        .weak EXTI4_IRQHandler
        .thumb_set EXTI4_IRQHandler,_end

        .weak DMA1_Stream0_IRQHandler
        .thumb_set DMA1_Stream0_IRQHandler,_end

        .weak DMA1_Stream1_IRQHandler
        .thumb_set DMA1_Stream1_IRQHandler,_end

        .weak DMA1_Stream2_IRQHandler
        .thumb_set DMA1_Stream2_IRQHandler,_end

        .weak DMA1_Stream3_IRQHandler
        .thumb_set DMA1_Stream3_IRQHandler,_end

        .weak DMA1_Stream4_IRQHandler
        .thumb_set DMA1_Stream4_IRQHandler,_end

        .weak DMA1_Stream5_IRQHandler
        .thumb_set DMA1_Stream5_IRQHandler,_end

        .weak DMA1_Stream6_IRQHandler
        .thumb_set DMA1_Stream6_IRQHandler,_end

        .weak ADC_IRQHandler
        .thumb_set ADC_IRQHandler,_end

        .weak CAN1_TX_IRQHandler
        .thumb_set CAN1_TX_IRQHandler,_end

        .weak CAN1_RX0_IRQHandler
        .thumb_set CAN1_RX0_IRQHandler,_end

        .weak CAN1_RX1_IRQHandler
        .thumb_set CAN1_RX1_IRQHandler,_end

        .weak CAN1_SCE_IRQHandler
        .thumb_set CAN1_SCE_IRQHandler,_end

        .weak EXTI9_5_IRQHandler
        .thumb_set EXTI9_5_IRQHandler,_end

        .weak TIM1_BRK_TIM9_IRQHandler
        .thumb_set TIM1_BRK_TIM9_IRQHandler,_end

        .weak TIM1_UP_TIM10_IRQHandler
        .thumb_set TIM1_UP_TIM10_IRQHandler,_end

        .weak TIM1_TRG_COM_TIM11_IRQHandler
        .thumb_set TIM1_TRG_COM_TIM11_IRQHandler,_end

        .weak TIM1_CC_IRQHandler
        .thumb_set TIM1_CC_IRQHandler,_end

        .weak TIM2_IRQHandler
        .thumb_set TIM2_IRQHandler,_end

        .weak TIM3_IRQHandler
        .thumb_set TIM3_IRQHandler,_end

        .weak TIM4_IRQHandler
        .thumb_set TIM4_IRQHandler,_end

        .weak I2C1_EV_IRQHandler
        .thumb_set I2C1_EV_IRQHandler,_end

        .weak I2C1_ER_IRQHandler
        .thumb_set I2C1_ER_IRQHandler,_end

        .weak I2C2_EV_IRQHandler
        .thumb_set I2C2_EV_IRQHandler,_end

        .weak I2C2_ER_IRQHandler
        .thumb_set I2C2_ER_IRQHandler,_end

        .weak SPI1_IRQHandler
        .thumb_set SPI1_IRQHandler,_end

        .weak SPI2_IRQHandler
        .thumb_set SPI2_IRQHandler,_end

        .weak USART1_IRQHandler
        .thumb_set USART1_IRQHandler,_end

        .weak USART2_IRQHandler
        .thumb_set USART2_IRQHandler,_end

        .weak USART3_IRQHandler
        .thumb_set USART3_IRQHandler,_end

        .weak EXTI15_10_IRQHandler
        .thumb_set EXTI15_10_IRQHandler,_end

        .weak RTC_Alarm_IRQHandler
        .thumb_set RTC_Alarm_IRQHandler,_end

        .weak OTG_FS_WKUP_IRQHandler
        .thumb_set OTG_FS_WKUP_IRQHandler,_end

        .weak TIM8_BRK_TIM12_IRQHandler
        .thumb_set TIM8_BRK_TIM12_IRQHandler,_end

        .weak TIM8_UP_TIM13_IRQHandler
        .thumb_set TIM8_UP_TIM13_IRQHandler,_end

        .weak TIM8_TRG_COM_TIM14_IRQHandler
        .thumb_set TIM8_TRG_COM_TIM14_IRQHandler,_end

        .weak TIM8_CC_IRQHandler
        .thumb_set TIM8_CC_IRQHandler,_end

        .weak DMA1_Stream7_IRQHandler
        .thumb_set DMA1_Stream7_IRQHandler,_end

        .weak FMC_IRQHandler
        .thumb_set FMC_IRQHandler,_end

        .weak SDIO_IRQHandler
        .thumb_set SDIO_IRQHandler,_end

        .weak TIM5_IRQHandler
        .thumb_set TIM5_IRQHandler,_end

        .weak SPI3_IRQHandler
        .thumb_set SPI3_IRQHandler,_end

        .weak UART4_IRQHandler
        .thumb_set UART4_IRQHandler,_end

        .weak UART5_IRQHandler
        .thumb_set UART5_IRQHandler,_end

        .weak TIM6_DAC_IRQHandler
        .thumb_set TIM6_DAC_IRQHandler,_end

        .weak TIM7_IRQHandler
        .thumb_set TIM7_IRQHandler,_end

        .weak DMA2_Stream0_IRQHandler
        .thumb_set DMA2_Stream0_IRQHandler,_end

        .weak DMA2_Stream1_IRQHandler
        .thumb_set DMA2_Stream1_IRQHandler,_end

        .weak DMA2_Stream2_IRQHandler
        .thumb_set DMA2_Stream2_IRQHandler,_end

        .weak DMA2_Stream3_IRQHandler
        .thumb_set DMA2_Stream3_IRQHandler,_end

        .weak DMA2_Stream4_IRQHandler
        .thumb_set DMA2_Stream4_IRQHandler,_end

        .weak CAN2_TX_IRQHandler
        .thumb_set CAN2_TX_IRQHandler,_end

        .weak CAN2_RX0_IRQHandler
        .thumb_set CAN2_RX0_IRQHandler,_end

        .weak CAN2_RX1_IRQHandler
        .thumb_set CAN2_RX1_IRQHandler,_end

        .weak CAN2_SCE_IRQHandler
        .thumb_set CAN2_SCE_IRQHandler,_end

        .weak OTG_FS_IRQHandler
        .thumb_set OTG_FS_IRQHandler,_end

        .weak DMA2_Stream5_IRQHandler
        .thumb_set DMA2_Stream5_IRQHandler,_end

        .weak DMA2_Stream6_IRQHandler
        .thumb_set DMA2_Stream6_IRQHandler,_end

        .weak DMA2_Stream7_IRQHandler
        .thumb_set DMA2_Stream7_IRQHandler,_end

        .weak USART6_IRQHandler
        .thumb_set USART6_IRQHandler,_end

        .weak I2C3_EV_IRQHandler
        .thumb_set I2C3_EV_IRQHandler,_end

        .weak I2C3_ER_IRQHandler
        .thumb_set I2C3_ER_IRQHandler,_end

        .weak OTG_HS_EP1_OUT_IRQHandler
        .thumb_set OTG_HS_EP1_OUT_IRQHandler,_end

        .weak OTG_HS_EP1_IN_IRQHandler
        .thumb_set OTG_HS_EP1_IN_IRQHandler,_end

        .weak OTG_HS_WKUP_IRQHandler
        .thumb_set OTG_HS_WKUP_IRQHandler,_end

        .weak OTG_HS_IRQHandler
        .thumb_set OTG_HS_IRQHandler,_end

        .weak DCMI_IRQHandler
        .thumb_set DCMI_IRQHandler,_end

        .weak SPI4_IRQHandler
        .thumb_set SPI4_IRQHandler,_end

        .weak SAI1_IRQHandler
        .thumb_set SAI1_IRQHandler,_end

        .weak SAI2_IRQHandler
        .thumb_set SAI2_IRQHandler,_end

        .weak QuadSPI_IRQHandler
        .thumb_set QuadSPI_IRQHandler,_end

        .weak HDMI_CEC_IRQHandler
        .thumb_set HDMI_CEC_IRQHandler,_end

        .weak SPDIF_Rx_IRQHandler
        .thumb_set SPDIF_Rx_IRQHandler,_end

        .weak FMPI2C1_IRQHandler
        .thumb_set FMPI2C1_IRQHandler,_end

        .weak FMPI2C1_error_IRQHandler
        .thumb_set FMPI2C1_error_IRQHandler,_end
