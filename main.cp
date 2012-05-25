#line 1 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
#line 1 "c:/users/thomas/documents/htx filer/htx 2g filer/teknologi/vand (eksamen)/elektronik/pic board/gsm/main.h"




extern volatile const char WaterAlarmSMS[];
extern volatile const char UserSMS[];


void Buzzer_On(void);
void Buzzer_Off(void);
void Buzzer_Beep(char count);

void BeepAndBlink(char count);

void LED_On(void);
void LED_Off(void);
void LED_Blink(char count);

void KeyPadCount(void);
void KeyPadCountTo(char countToVar);
char GetKeyPad(void);

void CancelAlarmOnClick(void);

void main(void);

extern char TimeOut;
extern char CurrentKeyPadCount;

extern char i;
#line 1 "c:/users/thomas/documents/htx filer/htx 2g filer/teknologi/vand (eksamen)/elektronik/pic board/gsm/gsm.h"



extern volatile const char SIMPin[];

extern volatile char MobileNumber[9];
extern volatile char WaterAlarmFlag;

extern char WriteBuffer[30];
extern char RecieveChars[30];
extern char RecieveLength;

void WaitForRecieveCharAndBlink(char delimiterChar);
void WaitForRecieveChar(char delimiterChar);
void WaitForRecieveMessage(char message[]);
void UART1_Write_Text_Constant(const char *txt);
void EmptySerialBuffer(void);

void GSM_PowerOn(void);
void GSM_PowerOff(void);
void GSM_Initialize(char firstInit);
void SendSMS(const char message[]);
void SetNewNumber(void);
void SaveNumberToEEProm(void);
void ReadNumberFromEEProm(void);
char CheckNumber(void);
#line 5 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
volatile const char WaterAlarmSMS[] = "ALARM - Der er opdaget vand! Med venlig hilsen, Din Vandalarm";
volatile const char UserSMS[] = "Du er nu registreret som bruger. Med venlig hilsen, Din Vandalarm";

char TimeOut;
char CurrentKeyPadCount = 0;

char i = 0;

void Interrupt() {
 if (INTCON.INTF)
 {
 WaterAlarmFlag = 1;
 INTCON = 0b10010000;
 return;
 }
}

void Buzzer_On(void)
{
 PORTC.B4 = 1;
}
void Buzzer_Off(void)
{
 PORTC.B4 = 0;
}
void Buzzer_Beep(char count)
{
 while (count > 0) {
 PORTC.B4 = 1;
 Delay_ms(100);
 PORTC.B4 = 0;
 Delay_ms(100);
 count--;
 }
}

void BeepAndBlink(char count)
{
 while (count > 0) {
 PORTC.B2 = 1;
 PORTC.B4 = 1;
 Delay_ms(100);
 PORTC.B2 = 0;
 PORTC.B4 = 0;
 Delay_ms(100);
 count--;
 }
}

void LED_On(void)
{
 PORTC.B2 = 1;
}
void LED_Off(void)
{
 PORTC.B2 = 0;
}
void LED_Blink(char count)
{
 while (count > 0) {
 PORTC.B2 = 1;
 Delay_ms(100);
 PORTC.B2 = 0;
 Delay_ms(100);
 count--;
 }
}

void KeyPadPulse(void)
{
 PORTC.B7 = 1;
 Delay_ms(1);
 PORTC.B7 = 0;
 Delay_ms(1);
}

void KeyPadCountTo(char countToVar)
{
 if (CurrentKeyPadCount < countToVar)
 {
 while (CurrentKeyPadCount < countToVar)
 {
 KeyPadPulse();
 CurrentKeyPadCount++;
 }
 return;
 } else if (CurrentKeyPadCount > countToVar) {
 while (CurrentKeyPadCount < 9)
 {
 KeyPadPulse();
 CurrentKeyPadCount++;
 }

 KeyPadPulse();
 CurrentKeyPadCount = 0;


 while (CurrentKeyPadCount < countToVar)
 {
 KeyPadPulse();
 CurrentKeyPadCount++;
 }
 return;
 }
}

char GetKeyPad(void)
{
 KeyPadCountTo(1);
 Delay_ms(10);
 if (PORTC.B3) return '1';
 if (PORTC.B5) return '2';
 if (PORTC.B1) return '3';

 KeyPadCountTo(2);
 Delay_ms(10);
 if (PORTC.B3) return '4';
 if (PORTC.B5) return '5';
 if (PORTC.B1) return '6';

 KeyPadCountTo(4);
 Delay_ms(10);
 if (PORTC.B3) return '7';
 if (PORTC.B5) return '8';
 if (PORTC.B1) return '9';

 KeyPadCountTo(8);
 Delay_ms(10);
 if (PORTC.B3) return '*';
 if (PORTC.B5) return '0';
 if (PORTC.B1) return '#';

 return 0;
}

void CancelAlarmOnClick(void)
{

 if (WaterAlarmFlag != 0) {
 if (GetKeyPad() == '#') {
 WaterAlarmFlag = 0;
 Buzzer_Off();
 }
 }
}

void main(void)
{
 char PressedKey;

 OSCCON = 0b01110101;
 TRISA = 0b00000100;
 PORTA = 0;
 ANSEL = 0b00000000;
 ANSELH = 0b00000000;


 TRISB = 0;
 PORTB.B6 = 1;
 UART1_Init(9600);
 Delay_ms(100);

 TRISC = 0b00101010;
 PORTC = 0;

 CM1CON0 = 0;

 OPTION_REG = 0b10000000;
 Delay_ms(1500);

 ReadNumberFromEEProm();
#line 187 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
 GSM_PowerOn();
 GSM_Initialize(1);
 GSM_PowerOff();


 Buzzer_On();
 LED_On();
 Delay_ms(600);
 Buzzer_Off();
 LED_Off();
#line 203 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
 INTCON = 0b10010000;


 while (1) {
 if (WaterAlarmFlag != 0)
 {
 Buzzer_On();
 if (CheckNumber())
 SendSMS(WaterAlarmSMS);


 if (WaterAlarmFlag != 0) {
 LED_On();
 WaterAlarmFlag = 0;
 }
 }


 PressedKey = GetKeyPad();
 if (PressedKey != 0) {
 Buzzer_Beep(1);
 while (GetKeyPad() != 0);
 }
#line 232 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
 if (PressedKey == '*')
 {
#line 239 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
 PressedKey = 0;
 while (PressedKey == 0) {
 PressedKey = GetKeyPad();
 }
 Buzzer_Beep(1);
 while (GetKeyPad() != 0);

 if (PressedKey == '#') {
 Buzzer_Beep(1);
 while (GetKeyPad() != 0);

 INTCON.GIE = 0;
 BeepAndBlink(2);
#line 257 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/main.c"
 SetNewNumber();


 if (CheckNumber()) {
 SaveNumberToEEProm();

 Buzzer_On();
 LED_On();
 Delay_ms(600);
 Buzzer_Off();
 LED_Off();


 SendSMS(UserSMS);
 } else {
 ReadNumberFromEEProm();

 Buzzer_On();
 LED_On();
 Delay_ms(600);
 Buzzer_Off();
 LED_Off();
 Delay_ms(200);
 Buzzer_On();
 LED_On();
 Delay_ms(600);
 Buzzer_Off();
 LED_Off();
 }

 WaterAlarmFlag = 0;
 INTCON.GIE = 1;
 }
 }
 if (PressedKey == '#')
 {
 LED_Off();
 Buzzer_Off();
 }

 }
}
