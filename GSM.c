#include "GSM.h"
#include "main.h"
//#define DEBUG

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
             //UART1_Write(recieveChar);
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
             //UART1_Write(recieveChar);
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
     Delay_ms(2000);                 // Wait for GSM Module to power up
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
     UART1_Write(13); //Carriage return (new line)
     Delay_ms(500);
     UART1_Write_Text_Constant("AT");
     UART1_Write(13); //Carriage return (new line)
     WaitForRecieveChar(0x0A);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     if (firstInit == 1) BeepAndBlink(1);
     
     UART1_Write_Text_Constant("AT+CPIN=");
     // Write PIN Code
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
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     if (firstInit == 1) BeepAndBlink(1);
     
     UART1_Write_Text_Constant("AT+CREG?");
     UART1_Write(13); //Carriage return (new line)
     WaitForRecieveChar(0x0D);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     if (firstInit == 1) BeepAndBlink(1);
     
     #ifndef DEBUG
     Delay_ms(10000); // Wait for the GSM module to connect to the GSM network (Response +CREG: 0,1)
     UART1_Write_Text_Constant("AT+CREG?");
     UART1_Write(13);
     WaitForRecieveChar(0x0D);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     if (firstInit == 1) BeepAndBlink(1);
     #endif

}

void SendSMS(const char message[])   // Send SMS to danish number
{
     GSM_PowerOn();
     LED_On(); // Turn on LED
     GSM_Initialize(0);
     UART1_Write_Text_Constant("AT+CMGF=1");
     UART1_Write(13); //Carriage return (new line)
     Delay_ms(10);
     WaitForRecieveChar(0x0D);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     
     UART1_Write_Text_Constant("AT+CSCS=");
     UART1_Write(34); // "
     UART1_Write_Text_Constant("GSM");
     UART1_Write(34); // "
     UART1_Write(13); //Carriage return (new line)
     Delay_ms(10);
     WaitForRecieveChar(0x0D);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
     
     // Set mobile number
     UART1_Write_Text_Constant("AT+CMGS=");
     UART1_Write(34); // "
     UART1_Write_Text_Constant("45"); // Country code (Denmark)
     UART1_Write_Text(MobileNumber);
     UART1_Write(34); // "
     UART1_Write(13); //Carriage return (new line)
     Delay_ms(500);
     WaitForRecieveChar(0x0A);
     
     // Write message
     i = 0;
     while (message[i] != 0)
     {
           UART1_Write(message[i]);
           i++;
     }
     UART1_Write(26); // Substitution (CTRL+Z)
     WaitForRecieveCharAndBlink(0x0A);
     EmptySerialBuffer();
     CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer

     Delay_ms(1000); // Give time to send the message
     GSM_PowerOff();
}

void SetNewNumber(void)
{
        char i;
        char PressedKey;
        for(i = 0; i < 8; i++)
        {
                #ifdef DEBUG
                       UART1_Write_Text_Constant("Waiting for press");
                       UART1_Write(13); //Carriage return (new line)
                #endif
                do
                {
                  PressedKey = GetKeyPad();
                } while (PressedKey == 0); // Wait for press
                MobileNumber[i] = PressedKey;
                Buzzer_Beep(1);
                #ifdef DEBUG
                       UART1_Write(MobileNumber[i]);
                       UART1_Write_Text_Constant(" pressed. ");
                       UART1_Write(i+48);
                       UART1_Write('=');
                       UART1_Write(MobileNumber[i]);
                       UART1_Write_Text_Constant(" - Waiting for release");
                       UART1_Write(13); //Carriage return (new line)
                #endif
                while(GetKeyPad() != 0); // Wait for release
        }
        MobileNumber[8] = 0;

        #ifdef DEBUG
               UART1_Write_Text(MobileNumber);
        #endif
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

/* Check the number in the RAM to see if it's correct */
char CheckNumber(void)
{
        for(i = 0; i < 8; i++)
        {
              if (MobileNumber[i] < '0' || MobileNumber[i] > '9')
                 return 0; // Return that the saved number is WRONG
        }
        return 1; // Return that the saved number is OK
}