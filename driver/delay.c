#include <stm32f0xx.h>
#include "cmx865a.h"
static unsigned char  fac_us=0;//us��ʱ������
static unsigned short fac_ms=0;//ms��ʱ������
//��ʼ���ӳٺ���
void delay_init(unsigned char SYSCLK)//SYSCLK =48
{
 SysTick->VAL=0X00000000;           //��ռ�����     
 SysTick->CTRL&=0xfffffffb;//ѡ���ڲ�ʱ�� HCLK/8
 fac_us=SYSCLK/8;      
 fac_ms=(unsigned short)fac_us*1000;
SysTick->CTRL&=0XFFFFFFFE;		   //�رռ�����
SysTick->VAL=0X00000000;		   //��ռ����� 	
 
}            
//��ʱNms
//ע��Nms�ķ�Χ
//Nms<=0xffffff*8/SYSCLK
//��72M������,Nms<=1864 
void delay_ms(unsigned short nms)
{    
 SysTick->LOAD=(unsigned long)nms*fac_ms; //ʱ�����  
 SysTick->CTRL|=0x01;               //��ʼ����    
 while(!(SysTick->CTRL&(1<<16)));   //�ȴ�ʱ�䵽�� 
 SysTick->CTRL&=0XFFFFFFFE;         //�رռ�����
 SysTick->VAL=0X00000000;           //��ռ�����     
 
}   
//��ʱus           
void delay_us(unsigned long Nus)
{ 
 SysTick->LOAD=Nus*fac_us;       //ʱ�����      
 SysTick->CTRL|=0x01;            //��ʼ����    
 while(!(SysTick->CTRL&(1<<16)));//�ȴ�ʱ�䵽�� 
 SysTick->CTRL=0X00000000;       //�رռ�����
 SysTick->VAL=0X00000000;        //��ռ�����     
}  
