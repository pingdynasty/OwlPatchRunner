/**
  ******************************************************************************
  * @file      startup_stm32f4xx.s
  * @author    MCD Application Team
  * @version   V1.0.0
  * @date      30-September-2011
  * @brief     STM32F4xx Devices vector table for Atollic TrueSTUDIO toolchain. 
  *            This module performs:
  *                - Set the initial SP
  *                - Set the initial PC == Reset_Handler,
  *                - Set the vector table entries with the exceptions ISR address
  *                - Configure the clock system and the external SRAM mounted on 
  *                  STM324xG-EVAL board to be used as data memory (optional, 
  *                  to be enabled by user)
  *                - Branches to main in the C library (which eventually
  *                  calls main()).
  *            After Reset the Cortex-M4 processor is in Thread mode,
  *            priority is Privileged, and the Stack is set to Main.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */
    
  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

.global  g_pfnVectors
;; .global  Default_Handler

/* start address for the initialization values of the .data section. 
defined in linker script */
.word  _sidata
/* start address for the .data section. defined in linker script */  
.word  _sdata
/* end address for the .data section. defined in linker script */
.word  _edata
/* start address for the .bss section. defined in linker script */
.word  _sbss
/* end address for the .bss section. defined in linker script */
.word  _ebss
/* stack used for SystemInit_ExtMemCtl; always internal RAM used */
	
/**
 * @brief  This is the code that gets called when the processor first
 *          starts execution following a reset event. Only the absolutely
 *          necessary set is performed, after which the application
 *          supplied main() routine is called. 
 * @param  None
 * @retval : None
*/

    .section  .text.Reset_Handler
  .weak  Reset_Handler
  .type  Reset_Handler, %function
Reset_Handler:  
;;  /* Relocate .text section (copy from flash to RAM) */
	/*
;;   movs r1, #0
;;   b  LoopCopyFastcode
;; CopyFastcode:
;;   ldr r3, =_text_load
;;   ldr r3, [r3, r1]
;;   str r3, [r0, r1]
;;   adds r1, r1, #4
;; LoopCopyFastcode:
;;   ldr  r0, =_text_start
;;   ldr  r3, =_text_end
;;   adds r2, r0, r1
;;   cmp  r2, r3
;;   bcc  CopyFastcode
	*/

;; /* Copy the data segment initializers from flash to SRAM */
	/*
;;   movs  r1, #0
;;   b  LoopCopyDataInit
;; CopyDataInit:
;;   ldr  r3, =_sidata
;;   ldr  r3, [r3, r1]
;;   str  r3, [r0, r1]
;;   adds  r1, r1, #4    
;; LoopCopyDataInit:
;;   ldr  r0, =_sdata
;;   ldr  r3, =_edata
;;   adds  r2, r0, r1
;;   cmp  r2, r3
;;   bcc  CopyDataInit
	*/

/* Zero fill the bss segment. */
  ldr  r2, =_sbss
  b  LoopFillZerobss
FillZerobss:
  movs  r3, #0
  str  r3, [r2], #4    
LoopFillZerobss:
  ldr  r3, = _ebss
  cmp  r2, r3
  bcc  FillZerobss

;; /* Call the clock system intitialization function.*/
	/*
	bl  SystemInit
	*/
;; /* Call static constructors */
	/*
    bl __libc_init_array
	*/
/* Call the application's entry point.*/
  bl  main
  bx  lr    
.size  Reset_Handler, .-Reset_Handler

;; Reboot_Loader:
;; 	ldr  r0, =0x1fff0000 /* address of the system memory for DFU */
;; 	ldr  sp, [r0, #0]
;; 	ldr  r0, [r0, #4]
;; 	bx   r0
;; .size Reboot_Loader, .-Reboot_Loader



/**
 * @brief  This is the code that gets called when the processor receives an 
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 * @param  None     
 * @retval None       
*/
;;     .section  .text.Default_Handler,"ax",%progbits
;; Default_Handler:
;; Infinite_Loop:
;;   b  Infinite_Loop
;;   .size  Default_Handler, .-Default_Handler
/******************************************************************************
*
* The minimal vector table for a Cortex M3. Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
* 
*******************************************************************************/
