extern void setup();
extern void run();

int main(void){
  setup();
  run();
  return 0;
}

extern "C" {
  int _exit(){
    return 0;
  }
}
