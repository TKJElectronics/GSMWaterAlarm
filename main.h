#ifndef __MAIN_H_
#define __MAIN_H_


extern volatile const char WaterAlarmSMS[];
extern volatile const char UserSMS[];


void Buzzer_On(void);
void Buzzer_Off(void);
void Buzzer_Beep(char count);

void BeepAndBlink(char count);

void LED_On(void);
void LED_Off(void);
void LED_Blink(char count);

void KeyPadCountTo(char countToVar);
char GetKeyPad(void);

void CancelAlarmOnClick(void);

void main(void);

extern char TimeOut;
extern char CurrentKeyPadCount;

extern char i; // Global temporary byte (variable)

#endif /* __MAIN_H_ */