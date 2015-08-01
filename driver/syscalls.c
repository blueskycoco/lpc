#include <sys/stat.h>
#include <stdio.h>
#include <unistd.h>
extern void uart_wait_rcv();
extern int uart_read();
extern int uart_send(unsigned char byte);
int _close(int file) {
  return 0;
}

int _fstat(int file, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

int _isatty(int file) {
  return 1;
}

int _lseek(int file, int ptr, int dir) {
  return 0;
}

int _open(const char *name, int flags, int mode) {
return -1;
}

int _read(int file, char *ptr, int len) {
  int todo,ch;
  if(len == 0)
    return 0;
  //uart_wait_rcv();
  //*ptr++ = uart_read();
  for(todo = 1; todo < len; todo++) {
  	//ch=uart_read();
    if(ch==-1) { break; }
    *ptr++ = ch;
  }
  return todo;
}

char *heap_end = 0;
caddr_t _sbrk(int incr) {
  extern char end; /* Defined by the linker */
  extern char __HeapLimit; /* Defined by the linker */
  char *prev_heap_end;
  if (heap_end == 0) {
    heap_end = &end;
  }  
  prev_heap_end = heap_end;
  if (heap_end + incr > &__HeapLimit) {
    /* Heap and stack collision */
    return (caddr_t)0;
  }
  heap_end += incr;
  return (caddr_t) prev_heap_end;
}

int _write(int file, char *ptr, int len) {
  int todo;
  for (todo = 0; todo < len; todo++) {
    //uart_send(*ptr++ & (unsigned short)0x01ff);
  }
  return len;
}
int fputc(int ch, FILE *f)  
{
	//uart_send(ch);
	return ch;
}/*
int put_char(char *buf)
{
	char ch=0,i=0;
	for(i=0;i<strlen(buf);i++)
	{
		ch=buf[i];
		if(ch=='\n')
			uart_send('\r');
		uart_send(ch&(unsigned short)0x01ff);
	}
	return ch;
}*/

