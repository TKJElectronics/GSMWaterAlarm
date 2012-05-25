#line 1 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/GSM.c"
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
#line 5 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/GSM.c"
volatile const char SIMPin[] = "7456";

volatile char MobileNumber[9];
volatile char WaterAlarmFlag = 0;

char WriteBuffer[30];
char RecieveChars[30];
char RecieveLength;


void WaitForRecieveCharAndBlink(char delimiterChar)
{
 char recieveChar = 0;
 while (1)
 {
 LED_Blink(1);
 if (UART1_Data_Ready() > 0) {
 recieveChar = UART1_Read();

 }
 if (recieveChar == delimiterChar)
 {
 LED_Off();
 break;
 }
 }
}

void WaitForRecieveChar(char delimiterChar)
{
 char recieveChar = 0;
 while (1)
 {
 if (UART1_Data_Ready() > 0) {
 recieveChar = UART1_Read();

 }
 if (recieveChar == delimiterChar) break;
 }
}

void WaitForRecieveMessage(const char message[])
{
 char pos = 0;
 while (message[pos] != 0)
 {
 WaitForRecieveChar(message[pos]);
 pos++;
 }
}

void UART1_Write_Text_Constant(const char *txt)
{
 while (*txt!=0)
 {
 UART1_Write(*txt);
 txt++;
 }
}

void EmptySerialBuffer(void)
{
 char recieveChar;
 while (UART1_Data_Ready() == 1) {
 recieveChar = UART1_Read();
 }
}

void GSM_PowerOn(void)
{
 PORTB.B6 = 0;
 Delay_ms(1500);
 PORTB.B6 = 1;
 Delay_ms(2000);
}
void GSM_PowerOff(void)
{
 PORTB.B6 = 0;
 Delay_ms(1000);
 PORTB.B6 = 1;
 Delay_ms(2000);
}

void GSM_Initialize(const char firstInit)
{
 UART1_Write_Text_Constant("AT");
 UART1_Write(13);
 Delay_ms(500);
 UART1_Write_Text_Constant("AT");
 UART1_Write(13);
 WaitForRecieveChar(0x0A);
 EmptySerialBuffer();
 CancelAlarmOnClick();
 if (firstInit == 1) BeepAndBlink(1);

 UART1_Write_Text_Constant("AT+CPIN=");

 i = 0;
 while (SIMPin[i] != 0)
 {
 UART1_Write(SIMPin[i]);
 i++;
 }
 UART1_Write(13);
 WaitForRecieveChar(0x0A);
 EmptySerialBuffer();
 if (firstInit == 1) BeepAndBlink(1);

 WaitForRecieveMessage("Call Ready");
 EmptySerialBuffer();
 CancelAlarmOnClick();
 if (firstInit == 1) BeepAndBlink(1);

 UART1_Write_Text_Constant("AT+CREG?");
 UART1_Write(13);
 WaitForRecieveChar(0x0D);
 EmptySerialBuffer();
 CancelAlarmOnClick();
 if (firstInit == 1) BeepAndBlink(1);


 Delay_ms(10000);
 UART1_Write_Text_Constant("AT+CREG?");
 UART1_Write(13);
 WaitForRecieveChar(0x0D);
 EmptySerialBuffer();
 CancelAlarmOnClick();
 if (firstInit == 1) BeepAndBlink(1);


}

void SendSMS(const char message[])
{
 GSM_PowerOn();
 LED_On();
 GSM_Initialize(0);
 UART1_Write_Text_Constant("AT+CMGF=1");
 UART1_Write(13);
 Delay_ms(10);
 WaitForRecieveChar(0x0D);
 EmptySerialBuffer();
 CancelAlarmOnClick();

 UART1_Write_Text_Constant("AT+CSCS=");
 UART1_Write(34);
 UART1_Write_Text_Constant("GSM");
 UART1_Write(34);
 UART1_Write(13);
 Delay_ms(10);
 WaitForRecieveChar(0x0D);
 EmptySerialBuffer();
 CancelAlarmOnClick();


 UART1_Write_Text_Constant("AT+CMGS=");
 UART1_Write(34);
 UART1_Write_Text_Constant("45");
 UART1_Write_Text(MobileNumber);
 UART1_Write(34);
 UART1_Write(13);
 Delay_ms(500);
 WaitForRecieveChar(0x0A);


 i = 0;
 while (message[i] != 0)
 {
 UART1_Write(message[i]);
 i++;
 }
 UART1_Write(26);
 WaitForRecieveCharAndBlink(0x0A);
 EmptySerialBuffer();
 CancelAlarmOnClick();

 Delay_ms(1000);
 GSM_PowerOff();
}

void SetNewNumber(void)
{
 char i;
 char PressedKey;
 for(i = 0; i < 8; i++)
 {
#line 195 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/GSM.c"
 do
 {
 PressedKey = GetKeyPad();
 } while (PressedKey == 0);
 MobileNumber[i] = PressedKey;
 Buzzer_Beep(1);
#line 210 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/GSM.c"
 while(GetKeyPad() != 0);
 }
 MobileNumber[8] = 0;
#line 217 "C:/Users/Thomas/Documents/HTX Filer/HTX 2g filer/Teknologi/Vand (Eksamen)/Elektronik/PIC Board/GSM/GSM.c"
}

void SaveNumberToEEProm(void)
{
 EEPROM_Write(0x00, MobileNumber[0]);
 EEPROM_Write(0x01, MobileNumber[1]);
 EEPROM_Write(0x02, MobileNumber[2]);
 EEPROM_Write(0x03, MobileNumber[3]);
 EEPROM_Write(0x04, MobileNumber[4]);
 EEPROM_Write(0x05, MobileNumber[5]);
 EEPROM_Write(0x06, MobileNumber[6]);
 EEPROM_Write(0x07, MobileNumber[7]);
}

void ReadNumberFromEEProm(void)
{
 MobileNumber[0] = EEPROM_Read(0x00);
 MobileNumber[1] = EEPROM_Read(0x01);
 MobileNumber[2] = EEPROM_Read(0x02);
 MobileNumber[3] = EEPROM_Read(0x03);
 MobileNumber[4] = EEPROM_Read(0x04);
 MobileNumber[5] = EEPROM_Read(0x05);
 MobileNumber[6] = EEPROM_Read(0x06);
 MobileNumber[7] = EEPROM_Read(0x07);
 MobileNumber[8] = 0;
}


char CheckNumber(void)
{
 for(i = 0; i < 8; i++)
 {
 if (MobileNumber[i] < '0' || MobileNumber[i] > '9')
 return 0;
 }
 return 1;
}
