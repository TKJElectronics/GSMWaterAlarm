#ifndef __GSM_H_
#define __GSM_H_

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

#endif /* __GSM_H_ */