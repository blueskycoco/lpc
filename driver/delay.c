#include <stm32f0xx.h>
#include "cmx865a.h"
static unsigned char  fac_us=0;//us延时倍乘数
static unsigned short fac_ms=0;//ms延时倍乘数
//初始化延迟函数
void delay_init(unsigned char SYSCLK)//SYSCLK =48
{
 SysTick->VAL=0X00000000;           //清空计数器     
 SysTick->CTRL&=0xfffffffb;//选择内部时钟 HCLK/8
 fac_us=SYSCLK/8;      
 fac_ms=(unsigned short)fac_us*1000;
SysTick->CTRL&=0XFFFFFFFE;		   //关闭计数器
SysTick->VAL=0X00000000;		   //清空计数器 	
 
}            
//延时Nms
//注意Nms的范围
//Nms<=0xffffff*8/SYSCLK
//对72M条件下,Nms<=1864 
void delay_ms(unsigned short nms)
{    
 SysTick->LOAD=(unsigned long)nms*fac_ms; //时间加载  
 SysTick->CTRL|=0x01;               //开始倒数    
 while(!(SysTick->CTRL&(1<<16)));   //等待时间到达 
 SysTick->CTRL&=0XFFFFFFFE;         //关闭计数器
 SysTick->VAL=0X00000000;           //清空计数器     
 
}   
//延时us           
void delay_us(unsigned long Nus)
{ 
 SysTick->LOAD=Nus*fac_us;       //时间加载      
 SysTick->CTRL|=0x01;            //开始倒数    
 while(!(SysTick->CTRL&(1<<16)));//等待时间到达 
 SysTick->CTRL=0X00000000;       //关闭计数器
 SysTick->VAL=0X00000000;        //清空计数器     
}  
