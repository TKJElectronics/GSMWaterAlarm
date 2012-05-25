#include "main.h"
#include "GSM.h"
//#define DEBUG

volatile const char WaterAlarmSMS[] = "ALARM - Der er opdaget vand! Med venlig hilsen, Din Vandalarm";
volatile const char UserSMS[] = "Du er nu registreret som bruger. Med venlig hilsen, Din Vandalarm";

char TimeOut;
char CurrentKeyPadCount = 0;

char i = 0; // Global temporary byte (variable)

void Interrupt() {
     if (INTCON.INTF) 
     {
         WaterAlarmFlag = 1;
         INTCON = 0b10010000; // Reset Interrupt Flag  and  Re-enable Interrupt
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
     if (CurrentKeyPadCount < countToVar)  // Needed count is higher than current count counted to
     {
          while (CurrentKeyPadCount < countToVar)
          {
                KeyPadPulse();
                CurrentKeyPadCount++;
          }
          return;
     } else if (CurrentKeyPadCount > countToVar) {  // Needed count is lower than current count counted to, therefor we have to roll over
          while (CurrentKeyPadCount < 9)  // Count to max of BCD Chip
          {
                KeyPadPulse();
                CurrentKeyPadCount++;
          }
          /* Count 1 extra, so it roll overs (becomes 0) */
          KeyPadPulse();
          CurrentKeyPadCount = 0;
          
          /* Count to the count needed (countToVar) */
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
     /* Always be able to disable alarm by pressing #, even when GSM transmisson is in progress */
     if (WaterAlarmFlag != 0) {
        if (GetKeyPad() == '#') {
            WaterAlarmFlag = 0; // Clear the Alarm Flag, so the LED isn't turned on after GSM transmission has finished
            Buzzer_Off(); // Disable Alarm
        }
     }
}

void main(void) 
{
     char PressedKey;
     	 
     OSCCON = 0b01110101; // Set the PIC to use the internal 8MHz clock
     TRISA = 0b00000100;  // Set RA2 as input, and the rest on PORTA to output
     PORTA = 0;           // Set all the PORTA outputs to LOW
     ANSEL = 0b00000000;  // Disable all analog inputs
     ANSELH = 0b00000000; // ---------- || -----------

     /* GSM Module */
     TRISB = 0;
     PORTB.B6 = 1;       // Set RB1 to HIGH (GSM PWRKEY should be HIGH or toggled)
     UART1_Init(9600);   // Initialize UART module at 9600 bps
     Delay_ms(100);      // Wait for UART module to stabilize

     TRISC = 0b00101010; // Set RC1, RC3, RC5 to input, and the rest on PORTC to output
     PORTC = 0;          // Set all the PORTC outputs to LOW
     CM1CON0 = 0;        // Disable all the comparators on PORTC
     	
     OPTION_REG = 0b10000000; // Disable PORTB Internal Pull-Ups, and set RA2 interrupt to Falling Edge
     Delay_ms(1500); // Wait for powersupply to counter to stabalize

     ReadNumberFromEEProm();
     #ifdef DEBUG
          UART1_Write_Text_Constant("Current mobile number:");
          UART1_Write_Text(MobileNumber);
          UART1_Write(13); //Carriage return (new line)
     #endif
     
     #ifdef DEBUG
          UART1_Write_Text_Constant("Initializing GSM");
          UART1_Write(13); //Carriage return (new line)
     #endif
     
     GSM_PowerOn();
     GSM_Initialize(1);
     GSM_PowerOff();
     
     /* Finished initializing GSM - inform the user */
     Buzzer_On();
     LED_On();
     Delay_ms(600);
     Buzzer_Off();
     LED_Off();
     
     #ifdef DEBUG
          UART1_Write_Text_Constant("Finished initializing GSM");
          UART1_Write(13); //Carriage return (new line)
     #endif

     INTCON = 0b10010000; // Enable interrupt
     
     
     while (1) {                     // Endless loop
           if (WaterAlarmFlag != 0)
           {
              Buzzer_On(); // Buzzer on
              if (CheckNumber()) // Send alarm SMS to the user, if the saved number is valid
                 SendSMS(WaterAlarmSMS);
                 
              /* If WaterAlarmFlag is still set (has not been cleared by pressing # when GSM tranmission is in progress), turn LED On and clear the flag */
              if (WaterAlarmFlag != 0) {
                 LED_On(); // Turn on LED
                 WaterAlarmFlag = 0;
              }
           }


           PressedKey = GetKeyPad();
           if (PressedKey != 0) {
              Buzzer_Beep(1);
              while (GetKeyPad() != 0); // Wait for release
           }

           #ifdef DEBUG
                  if (PressedKey != 0)
                     UART1_Write(PressedKey);
           #endif
           
           if (PressedKey == '*')
           {
                   #ifdef DEBUG
                          UART1_Write_Text_Constant("* is pressed");
                          UART1_Write_Text(WriteBuffer);
                          UART1_Write(13); //Carriage return (new line)
                   #endif
                   PressedKey = 0;
                   while (PressedKey == 0) {
                      PressedKey = GetKeyPad();
                   }
                   Buzzer_Beep(1);
                   while (GetKeyPad() != 0); // Wait for release

                   if (PressedKey == '#') {
                      Buzzer_Beep(1);
                      while (GetKeyPad() != 0); // Wait for release
                      
                      INTCON.GIE = 0; // Disable global interrupt
                      BeepAndBlink(2);
                      #ifdef DEBUG
                             UART1_Write_Text_Constant("Setting new number...");
                             UART1_Write_Text(WriteBuffer);
                             UART1_Write(13); //Carriage return (new line)
                      #endif
                      SetNewNumber();
                                   
                      /* Finished getting number */
                      if (CheckNumber()) {
                         SaveNumberToEEProm(); // Save the number in the internal EEProm
                         /* Inform the user that the number is correct (OK) = One long beep */
                         Buzzer_On();
                         LED_On();
                         Delay_ms(600);
                         Buzzer_Off();
                         LED_Off();
                                      
                         /* Send SMS to the new user to indicate the number was correct */
                         SendSMS(UserSMS);
                      } else {
                         ReadNumberFromEEProm(); // Because the number in the RAM is incorrect, read the last saved number into RAM
                         /* Inform the user that the number is incorrect (WRONG) = Two long beeps */
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
                       INTCON.GIE = 1; // Enable global interrupt
                   }
            }
            if (PressedKey == '#')
            {
                   LED_Off(); // Turn off LED
                   Buzzer_Off(); // Buzzer off
            }
            
     }
}