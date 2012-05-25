
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;main.c,13 :: 		void Interrupt() {
;main.c,14 :: 		if (INTCON.INTF)
	BTFSS      INTCON+0, 1
	GOTO       L_Interrupt0
;main.c,16 :: 		WaterAlarmFlag = 1;
	MOVLW      1
	MOVWF      _WaterAlarmFlag+0
;main.c,17 :: 		INTCON = 0b10010000; // Reset Interrupt Flag  and  Re-enable Interrupt
	MOVLW      144
	MOVWF      INTCON+0
;main.c,18 :: 		return;
	RETURN
;main.c,19 :: 		}
L_Interrupt0:
;main.c,20 :: 		}
L__Interrupt68:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Buzzer_On:

;main.c,22 :: 		void Buzzer_On(void)
;main.c,24 :: 		PORTC.B4 = 1;
	BSF        PORTC+0, 4
;main.c,25 :: 		}
	RETURN
; end of _Buzzer_On

_Buzzer_Off:

;main.c,26 :: 		void Buzzer_Off(void)
;main.c,28 :: 		PORTC.B4 = 0;
	BCF        PORTC+0, 4
;main.c,29 :: 		}
	RETURN
; end of _Buzzer_Off

_Buzzer_Beep:

;main.c,30 :: 		void Buzzer_Beep(char count)
;main.c,32 :: 		while (count > 0) {
L_Buzzer_Beep1:
	MOVF       FARG_Buzzer_Beep_count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_Buzzer_Beep2
;main.c,33 :: 		PORTC.B4 = 1;
	BSF        PORTC+0, 4
;main.c,34 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Buzzer_Beep3:
	DECFSZ     R13+0, 1
	GOTO       L_Buzzer_Beep3
	DECFSZ     R12+0, 1
	GOTO       L_Buzzer_Beep3
	DECFSZ     R11+0, 1
	GOTO       L_Buzzer_Beep3
	NOP
;main.c,35 :: 		PORTC.B4 = 0;
	BCF        PORTC+0, 4
;main.c,36 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Buzzer_Beep4:
	DECFSZ     R13+0, 1
	GOTO       L_Buzzer_Beep4
	DECFSZ     R12+0, 1
	GOTO       L_Buzzer_Beep4
	DECFSZ     R11+0, 1
	GOTO       L_Buzzer_Beep4
	NOP
;main.c,37 :: 		count--;
	DECF       FARG_Buzzer_Beep_count+0, 1
;main.c,38 :: 		}
	GOTO       L_Buzzer_Beep1
L_Buzzer_Beep2:
;main.c,39 :: 		}
	RETURN
; end of _Buzzer_Beep

_BeepAndBlink:

;main.c,41 :: 		void BeepAndBlink(char count)
;main.c,43 :: 		while (count > 0) {
L_BeepAndBlink5:
	MOVF       FARG_BeepAndBlink_count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_BeepAndBlink6
;main.c,44 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;main.c,45 :: 		PORTC.B4 = 1;
	BSF        PORTC+0, 4
;main.c,46 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_BeepAndBlink7:
	DECFSZ     R13+0, 1
	GOTO       L_BeepAndBlink7
	DECFSZ     R12+0, 1
	GOTO       L_BeepAndBlink7
	DECFSZ     R11+0, 1
	GOTO       L_BeepAndBlink7
	NOP
;main.c,47 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;main.c,48 :: 		PORTC.B4 = 0;
	BCF        PORTC+0, 4
;main.c,49 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_BeepAndBlink8:
	DECFSZ     R13+0, 1
	GOTO       L_BeepAndBlink8
	DECFSZ     R12+0, 1
	GOTO       L_BeepAndBlink8
	DECFSZ     R11+0, 1
	GOTO       L_BeepAndBlink8
	NOP
;main.c,50 :: 		count--;
	DECF       FARG_BeepAndBlink_count+0, 1
;main.c,51 :: 		}
	GOTO       L_BeepAndBlink5
L_BeepAndBlink6:
;main.c,52 :: 		}
	RETURN
; end of _BeepAndBlink

_LED_On:

;main.c,54 :: 		void LED_On(void)
;main.c,56 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;main.c,57 :: 		}
	RETURN
; end of _LED_On

_LED_Off:

;main.c,58 :: 		void LED_Off(void)
;main.c,60 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;main.c,61 :: 		}
	RETURN
; end of _LED_Off

_LED_Blink:

;main.c,62 :: 		void LED_Blink(char count)
;main.c,64 :: 		while (count > 0) {
L_LED_Blink9:
	MOVF       FARG_LED_Blink_count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_LED_Blink10
;main.c,65 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;main.c,66 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_LED_Blink11:
	DECFSZ     R13+0, 1
	GOTO       L_LED_Blink11
	DECFSZ     R12+0, 1
	GOTO       L_LED_Blink11
	DECFSZ     R11+0, 1
	GOTO       L_LED_Blink11
	NOP
;main.c,67 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;main.c,68 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_LED_Blink12:
	DECFSZ     R13+0, 1
	GOTO       L_LED_Blink12
	DECFSZ     R12+0, 1
	GOTO       L_LED_Blink12
	DECFSZ     R11+0, 1
	GOTO       L_LED_Blink12
	NOP
;main.c,69 :: 		count--;
	DECF       FARG_LED_Blink_count+0, 1
;main.c,70 :: 		}
	GOTO       L_LED_Blink9
L_LED_Blink10:
;main.c,71 :: 		}
	RETURN
; end of _LED_Blink

_KeyPadPulse:

;main.c,73 :: 		void KeyPadPulse(void)
;main.c,75 :: 		PORTC.B7 = 1;
	BSF        PORTC+0, 7
;main.c,76 :: 		Delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_KeyPadPulse13:
	DECFSZ     R13+0, 1
	GOTO       L_KeyPadPulse13
	DECFSZ     R12+0, 1
	GOTO       L_KeyPadPulse13
	NOP
	NOP
;main.c,77 :: 		PORTC.B7 = 0;
	BCF        PORTC+0, 7
;main.c,78 :: 		Delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_KeyPadPulse14:
	DECFSZ     R13+0, 1
	GOTO       L_KeyPadPulse14
	DECFSZ     R12+0, 1
	GOTO       L_KeyPadPulse14
	NOP
	NOP
;main.c,79 :: 		}
	RETURN
; end of _KeyPadPulse

_KeyPadCountTo:

;main.c,81 :: 		void KeyPadCountTo(char countToVar)
;main.c,83 :: 		if (CurrentKeyPadCount < countToVar)  // Needed count is higher than current count counted to
	MOVF       FARG_KeyPadCountTo_countToVar+0, 0
	SUBWF      _CurrentKeyPadCount+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_KeyPadCountTo15
;main.c,85 :: 		while (CurrentKeyPadCount < countToVar)
L_KeyPadCountTo16:
	MOVF       FARG_KeyPadCountTo_countToVar+0, 0
	SUBWF      _CurrentKeyPadCount+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_KeyPadCountTo17
;main.c,87 :: 		KeyPadPulse();
	CALL       _KeyPadPulse+0
;main.c,88 :: 		CurrentKeyPadCount++;
	INCF       _CurrentKeyPadCount+0, 1
;main.c,89 :: 		}
	GOTO       L_KeyPadCountTo16
L_KeyPadCountTo17:
;main.c,90 :: 		return;
	RETURN
;main.c,91 :: 		} else if (CurrentKeyPadCount > countToVar) {  // Needed count is lower than current count counted to, therefor we have to roll over
L_KeyPadCountTo15:
	MOVF       _CurrentKeyPadCount+0, 0
	SUBWF      FARG_KeyPadCountTo_countToVar+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_KeyPadCountTo19
;main.c,92 :: 		while (CurrentKeyPadCount < 9)  // Count to max of BCD Chip
L_KeyPadCountTo20:
	MOVLW      9
	SUBWF      _CurrentKeyPadCount+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_KeyPadCountTo21
;main.c,94 :: 		KeyPadPulse();
	CALL       _KeyPadPulse+0
;main.c,95 :: 		CurrentKeyPadCount++;
	INCF       _CurrentKeyPadCount+0, 1
;main.c,96 :: 		}
	GOTO       L_KeyPadCountTo20
L_KeyPadCountTo21:
;main.c,98 :: 		KeyPadPulse();
	CALL       _KeyPadPulse+0
;main.c,99 :: 		CurrentKeyPadCount = 0;
	CLRF       _CurrentKeyPadCount+0
;main.c,102 :: 		while (CurrentKeyPadCount < countToVar)
L_KeyPadCountTo22:
	MOVF       FARG_KeyPadCountTo_countToVar+0, 0
	SUBWF      _CurrentKeyPadCount+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_KeyPadCountTo23
;main.c,104 :: 		KeyPadPulse();
	CALL       _KeyPadPulse+0
;main.c,105 :: 		CurrentKeyPadCount++;
	INCF       _CurrentKeyPadCount+0, 1
;main.c,106 :: 		}
	GOTO       L_KeyPadCountTo22
L_KeyPadCountTo23:
;main.c,107 :: 		return;
	RETURN
;main.c,108 :: 		}
L_KeyPadCountTo19:
;main.c,109 :: 		}
	RETURN
; end of _KeyPadCountTo

_GetKeyPad:

;main.c,111 :: 		char GetKeyPad(void)
;main.c,113 :: 		KeyPadCountTo(1);
	MOVLW      1
	MOVWF      FARG_KeyPadCountTo_countToVar+0
	CALL       _KeyPadCountTo+0
;main.c,114 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_GetKeyPad24:
	DECFSZ     R13+0, 1
	GOTO       L_GetKeyPad24
	DECFSZ     R12+0, 1
	GOTO       L_GetKeyPad24
	NOP
;main.c,115 :: 		if (PORTC.B3) return '1';
	BTFSS      PORTC+0, 3
	GOTO       L_GetKeyPad25
	MOVLW      49
	MOVWF      R0+0
	RETURN
L_GetKeyPad25:
;main.c,116 :: 		if (PORTC.B5) return '2';
	BTFSS      PORTC+0, 5
	GOTO       L_GetKeyPad26
	MOVLW      50
	MOVWF      R0+0
	RETURN
L_GetKeyPad26:
;main.c,117 :: 		if (PORTC.B1) return '3';
	BTFSS      PORTC+0, 1
	GOTO       L_GetKeyPad27
	MOVLW      51
	MOVWF      R0+0
	RETURN
L_GetKeyPad27:
;main.c,119 :: 		KeyPadCountTo(2);
	MOVLW      2
	MOVWF      FARG_KeyPadCountTo_countToVar+0
	CALL       _KeyPadCountTo+0
;main.c,120 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_GetKeyPad28:
	DECFSZ     R13+0, 1
	GOTO       L_GetKeyPad28
	DECFSZ     R12+0, 1
	GOTO       L_GetKeyPad28
	NOP
;main.c,121 :: 		if (PORTC.B3) return '4';
	BTFSS      PORTC+0, 3
	GOTO       L_GetKeyPad29
	MOVLW      52
	MOVWF      R0+0
	RETURN
L_GetKeyPad29:
;main.c,122 :: 		if (PORTC.B5) return '5';
	BTFSS      PORTC+0, 5
	GOTO       L_GetKeyPad30
	MOVLW      53
	MOVWF      R0+0
	RETURN
L_GetKeyPad30:
;main.c,123 :: 		if (PORTC.B1) return '6';
	BTFSS      PORTC+0, 1
	GOTO       L_GetKeyPad31
	MOVLW      54
	MOVWF      R0+0
	RETURN
L_GetKeyPad31:
;main.c,125 :: 		KeyPadCountTo(4);
	MOVLW      4
	MOVWF      FARG_KeyPadCountTo_countToVar+0
	CALL       _KeyPadCountTo+0
;main.c,126 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_GetKeyPad32:
	DECFSZ     R13+0, 1
	GOTO       L_GetKeyPad32
	DECFSZ     R12+0, 1
	GOTO       L_GetKeyPad32
	NOP
;main.c,127 :: 		if (PORTC.B3) return '7';
	BTFSS      PORTC+0, 3
	GOTO       L_GetKeyPad33
	MOVLW      55
	MOVWF      R0+0
	RETURN
L_GetKeyPad33:
;main.c,128 :: 		if (PORTC.B5) return '8';
	BTFSS      PORTC+0, 5
	GOTO       L_GetKeyPad34
	MOVLW      56
	MOVWF      R0+0
	RETURN
L_GetKeyPad34:
;main.c,129 :: 		if (PORTC.B1) return '9';
	BTFSS      PORTC+0, 1
	GOTO       L_GetKeyPad35
	MOVLW      57
	MOVWF      R0+0
	RETURN
L_GetKeyPad35:
;main.c,131 :: 		KeyPadCountTo(8);
	MOVLW      8
	MOVWF      FARG_KeyPadCountTo_countToVar+0
	CALL       _KeyPadCountTo+0
;main.c,132 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_GetKeyPad36:
	DECFSZ     R13+0, 1
	GOTO       L_GetKeyPad36
	DECFSZ     R12+0, 1
	GOTO       L_GetKeyPad36
	NOP
;main.c,133 :: 		if (PORTC.B3) return '*';
	BTFSS      PORTC+0, 3
	GOTO       L_GetKeyPad37
	MOVLW      42
	MOVWF      R0+0
	RETURN
L_GetKeyPad37:
;main.c,134 :: 		if (PORTC.B5) return '0';
	BTFSS      PORTC+0, 5
	GOTO       L_GetKeyPad38
	MOVLW      48
	MOVWF      R0+0
	RETURN
L_GetKeyPad38:
;main.c,135 :: 		if (PORTC.B1) return '#';
	BTFSS      PORTC+0, 1
	GOTO       L_GetKeyPad39
	MOVLW      35
	MOVWF      R0+0
	RETURN
L_GetKeyPad39:
;main.c,137 :: 		return 0;
	CLRF       R0+0
;main.c,138 :: 		}
	RETURN
; end of _GetKeyPad

_CancelAlarmOnClick:

;main.c,140 :: 		void CancelAlarmOnClick(void)
;main.c,143 :: 		if (WaterAlarmFlag != 0) {
	MOVF       _WaterAlarmFlag+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_CancelAlarmOnClick40
;main.c,144 :: 		if (GetKeyPad() == '#') {
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_CancelAlarmOnClick41
;main.c,145 :: 		WaterAlarmFlag = 0; // Clear the Alarm Flag, so the LED isn't turned on after GSM transmission has finished
	CLRF       _WaterAlarmFlag+0
;main.c,146 :: 		Buzzer_Off(); // Disable Alarm
	CALL       _Buzzer_Off+0
;main.c,147 :: 		}
L_CancelAlarmOnClick41:
;main.c,148 :: 		}
L_CancelAlarmOnClick40:
;main.c,149 :: 		}
	RETURN
; end of _CancelAlarmOnClick

_main:

;main.c,151 :: 		void main(void)
;main.c,155 :: 		OSCCON = 0b01110101;
	MOVLW      117
	MOVWF      OSCCON+0
;main.c,156 :: 		TRISA = 0b00000100;
	MOVLW      4
	MOVWF      TRISA+0
;main.c,157 :: 		PORTA = 0;
	CLRF       PORTA+0
;main.c,158 :: 		ANSEL = 0b00000000;
	CLRF       ANSEL+0
;main.c,159 :: 		ANSELH = 0b00000000;
	CLRF       ANSELH+0
;main.c,162 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,163 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;main.c,164 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,165 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
	NOP
;main.c,167 :: 		TRISC = 0b00101010;
	MOVLW      42
	MOVWF      TRISC+0
;main.c,168 :: 		PORTC = 0;
	CLRF       PORTC+0
;main.c,170 :: 		CM1CON0 = 0;
	CLRF       CM1CON0+0
;main.c,172 :: 		OPTION_REG = 0b10000000;
	MOVLW      128
	MOVWF      OPTION_REG+0
;main.c,173 :: 		Delay_ms(1500); // Wait for powersupply to counter to stabalize
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;main.c,175 :: 		ReadNumberFromEEProm();
	CALL       _ReadNumberFromEEProm+0
;main.c,187 :: 		GSM_PowerOn();
	CALL       _GSM_PowerOn+0
;main.c,188 :: 		GSM_Initialize(1);
	MOVLW      1
	MOVWF      FARG_GSM_Initialize_firstInit+0
	CALL       _GSM_Initialize+0
;main.c,189 :: 		GSM_PowerOff();
	CALL       _GSM_PowerOff+0
;main.c,192 :: 		Buzzer_On();
	CALL       _Buzzer_On+0
;main.c,193 :: 		LED_On();
	CALL       _LED_On+0
;main.c,194 :: 		Delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	DECFSZ     R11+0, 1
	GOTO       L_main44
	NOP
;main.c,195 :: 		Buzzer_Off();
	CALL       _Buzzer_Off+0
;main.c,196 :: 		LED_Off();
	CALL       _LED_Off+0
;main.c,203 :: 		INTCON = 0b10010000; // Enable interrupt
	MOVLW      144
	MOVWF      INTCON+0
;main.c,206 :: 		while (1) {                     // Endless loop
L_main45:
;main.c,207 :: 		if (WaterAlarmFlag != 0)
	MOVF       _WaterAlarmFlag+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
;main.c,209 :: 		Buzzer_On(); // Buzzer on
	CALL       _Buzzer_On+0
;main.c,210 :: 		if (CheckNumber()) // Send alarm SMS to the user, if the saved number is valid
	CALL       _CheckNumber+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main48
;main.c,211 :: 		SendSMS(WaterAlarmSMS);
	MOVLW      _WaterAlarmSMS+0
	MOVWF      FARG_SendSMS_message+0
	MOVLW      hi_addr(_WaterAlarmSMS+0)
	MOVWF      FARG_SendSMS_message+1
	CALL       _SendSMS+0
L_main48:
;main.c,214 :: 		if (WaterAlarmFlag != 0) {
	MOVF       _WaterAlarmFlag+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main49
;main.c,215 :: 		LED_On(); // Turn on LED
	CALL       _LED_On+0
;main.c,216 :: 		WaterAlarmFlag = 0;
	CLRF       _WaterAlarmFlag+0
;main.c,217 :: 		}
L_main49:
;main.c,218 :: 		}
L_main47:
;main.c,221 :: 		PressedKey = GetKeyPad();
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	MOVWF      main_PressedKey_L0+0
;main.c,222 :: 		if (PressedKey != 0) {
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main50
;main.c,223 :: 		Buzzer_Beep(1);
	MOVLW      1
	MOVWF      FARG_Buzzer_Beep_count+0
	CALL       _Buzzer_Beep+0
;main.c,224 :: 		while (GetKeyPad() != 0); // Wait for release
L_main51:
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	GOTO       L_main51
L_main52:
;main.c,225 :: 		}
L_main50:
;main.c,232 :: 		if (PressedKey == '*')
	MOVF       main_PressedKey_L0+0, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main53
;main.c,239 :: 		PressedKey = 0;
	CLRF       main_PressedKey_L0+0
;main.c,240 :: 		while (PressedKey == 0) {
L_main54:
	MOVF       main_PressedKey_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main55
;main.c,241 :: 		PressedKey = GetKeyPad();
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	MOVWF      main_PressedKey_L0+0
;main.c,242 :: 		}
	GOTO       L_main54
L_main55:
;main.c,243 :: 		Buzzer_Beep(1);
	MOVLW      1
	MOVWF      FARG_Buzzer_Beep_count+0
	CALL       _Buzzer_Beep+0
;main.c,244 :: 		while (GetKeyPad() != 0); // Wait for release
L_main56:
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	GOTO       L_main56
L_main57:
;main.c,246 :: 		if (PressedKey == '#') {
	MOVF       main_PressedKey_L0+0, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main58
;main.c,247 :: 		Buzzer_Beep(1);
	MOVLW      1
	MOVWF      FARG_Buzzer_Beep_count+0
	CALL       _Buzzer_Beep+0
;main.c,248 :: 		while (GetKeyPad() != 0); // Wait for release
L_main59:
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	GOTO       L_main59
L_main60:
;main.c,250 :: 		INTCON.GIE = 0; // Disable global interrupt
	BCF        INTCON+0, 7
;main.c,251 :: 		BeepAndBlink(2);
	MOVLW      2
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
;main.c,257 :: 		SetNewNumber();
	CALL       _SetNewNumber+0
;main.c,260 :: 		if (CheckNumber()) {
	CALL       _CheckNumber+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main61
;main.c,261 :: 		SaveNumberToEEProm(); // Save the number in the internal EEProm
	CALL       _SaveNumberToEEProm+0
;main.c,263 :: 		Buzzer_On();
	CALL       _Buzzer_On+0
;main.c,264 :: 		LED_On();
	CALL       _LED_On+0
;main.c,265 :: 		Delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main62:
	DECFSZ     R13+0, 1
	GOTO       L_main62
	DECFSZ     R12+0, 1
	GOTO       L_main62
	DECFSZ     R11+0, 1
	GOTO       L_main62
	NOP
;main.c,266 :: 		Buzzer_Off();
	CALL       _Buzzer_Off+0
;main.c,267 :: 		LED_Off();
	CALL       _LED_Off+0
;main.c,270 :: 		SendSMS(UserSMS);
	MOVLW      _UserSMS+0
	MOVWF      FARG_SendSMS_message+0
	MOVLW      hi_addr(_UserSMS+0)
	MOVWF      FARG_SendSMS_message+1
	CALL       _SendSMS+0
;main.c,271 :: 		} else {
	GOTO       L_main63
L_main61:
;main.c,272 :: 		ReadNumberFromEEProm(); // Because the number in the RAM is incorrect, read the last saved number into RAM
	CALL       _ReadNumberFromEEProm+0
;main.c,274 :: 		Buzzer_On();
	CALL       _Buzzer_On+0
;main.c,275 :: 		LED_On();
	CALL       _LED_On+0
;main.c,276 :: 		Delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main64:
	DECFSZ     R13+0, 1
	GOTO       L_main64
	DECFSZ     R12+0, 1
	GOTO       L_main64
	DECFSZ     R11+0, 1
	GOTO       L_main64
	NOP
;main.c,277 :: 		Buzzer_Off();
	CALL       _Buzzer_Off+0
;main.c,278 :: 		LED_Off();
	CALL       _LED_Off+0
;main.c,279 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	DECFSZ     R11+0, 1
	GOTO       L_main65
;main.c,280 :: 		Buzzer_On();
	CALL       _Buzzer_On+0
;main.c,281 :: 		LED_On();
	CALL       _LED_On+0
;main.c,282 :: 		Delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main66:
	DECFSZ     R13+0, 1
	GOTO       L_main66
	DECFSZ     R12+0, 1
	GOTO       L_main66
	DECFSZ     R11+0, 1
	GOTO       L_main66
	NOP
;main.c,283 :: 		Buzzer_Off();
	CALL       _Buzzer_Off+0
;main.c,284 :: 		LED_Off();
	CALL       _LED_Off+0
;main.c,285 :: 		}
L_main63:
;main.c,287 :: 		WaterAlarmFlag = 0;
	CLRF       _WaterAlarmFlag+0
;main.c,288 :: 		INTCON.GIE = 1; // Enable global interrupt
	BSF        INTCON+0, 7
;main.c,289 :: 		}
L_main58:
;main.c,290 :: 		}
L_main53:
;main.c,291 :: 		if (PressedKey == '#')
	MOVF       main_PressedKey_L0+0, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main67
;main.c,293 :: 		LED_Off(); // Turn off LED
	CALL       _LED_Off+0
;main.c,294 :: 		Buzzer_Off(); // Buzzer off
	CALL       _Buzzer_Off+0
;main.c,295 :: 		}
L_main67:
;main.c,297 :: 		}
	GOTO       L_main45
;main.c,298 :: 		}
	GOTO       $+0
; end of _main
