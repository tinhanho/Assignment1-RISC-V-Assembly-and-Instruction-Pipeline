#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

extern uint64_t get_cycles();

uint16_t count_leading_zeros(uint64_t x){
  x |= (x >> 1);
  x |= (x >> 2);
  x |= (x >> 4);
  x |= (x >> 8);
  x |= (x >> 16);
  x |= (x >> 32);
  
  x -= ((x >> 1) & 0x55555555);
  x = ((x >> 2) & 0x33333333) + (x & 0x33333333);
  x = ((x >> 4) + x) & 0x0f0f0f0f;
  x += (x >> 8);
  x += (x >> 16);
  x += (x >> 32);

  return (32 - (x & 0x7f)); 
}

int main(){
 uint64_t oldcount = get_cycles();
 uint32_t test_data[] = {0x00000011, 0x00001101, 0x00010011};

  for (int i = 0; i < sizeof(test_data) / sizeof(test_data[0]); i++){
    uint32_t clz = count_leading_zeros(test_data[i]);
    if (clz < 32){
      uint32_t msb = (uint32_t)(31 - clz);
      printf("Test Data %d:\n", i + 1);
      printf("Input: 0x%08lx\n", test_data[i]);
      printf("Leading Zeros: %lu\n", clz);
      printf("MSB: %lu\n", msb);
    }
    else{
      printf("Test Data %d: Invalid input, cannot calculate MSB.\n", i + 1);
    }
    printf("\n");
  }
 uint64_t cyclecount = get_cycles() - oldcount;
 printf("cycle count: %u\n", (unsigned int) cyclecount); 
 return 0;