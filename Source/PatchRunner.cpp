#include "SharedMemory.h"

void setup(){
}

void run(){
  for(;;){
    if(smem.audio_status){
      // process audio
      smem.audio_status = false;
    }
  }
}
