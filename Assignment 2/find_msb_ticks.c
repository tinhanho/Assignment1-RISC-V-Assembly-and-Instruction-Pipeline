#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

typedef uint64_t ticks;
static inline ticks getticks(void)
{
    uint64_t result;
    uint32_t l, h, h2;
    asm volatile(
        "rdcycleh %0\n"
        "rdcycle %1\n"
        "rdcycleh %2\n"
        "sub %0, %0, %2\n"
        "seqz %0, %0\n"
        "sub %0, zero, %0\n"
        "and %1, %1, %0\n"
        : "=r"(h), "=r"(l), "=r"(h2));
    result = (((uint64_t) h) << 32) | ((uint64_t) l);
    return result;
}

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
 ticks t0 = getticks(); 
 uint32_t test_data[] = {0x00000011, 0x00001101, 0x00010011};

  for (int i = 0; i < sizeof(test_data) / sizeof(test_data[0]); i++){
    uint32_t clz = count_leading_zeros(test_data[i]);
    if (clz < 32){
      uint32_t msb = (uint32_t)(31 - clz);
      printf("Test Data %d:\n", i + 1);
      printf("Input: 0x%08x\n", test_data[i]);
      printf("Leading Zeros: %u\n", clz);
      printf("MSB: %u\n", msb);
    }
    else{
      printf("Test Data %d: Invalid input, cannot calculate MSB.\n", i + 1);
    }
    printf("\n");
  }
  ticks t1 = getticks();
  printf("elapsed cycle: %" PRIu64 "\n", t1 - t0);
  return 0;
}
