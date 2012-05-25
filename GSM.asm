
_WaitForRecieveCharAndBlink:

;GSM.c,15 :: 		void WaitForRecieveCharAndBlink(char delimiterChar)
;GSM.c,17 :: 		char recieveChar = 0;
	CLRF       WaitForRecieveCharAndBlink_recieveChar_L0+0
;GSM.c,18 :: 		while (1)
L_WaitForRecieveCharAndBlink0:
;GSM.c,20 :: 		LED_Blink(1);
	MOVLW      1
	MOVWF      FARG_LED_Blink_count+0
	CALL       _LED_Blink+0
;GSM.c,21 :: 		if (UART1_Data_Ready() > 0) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_WaitForRecieveCharAndBlink2
;GSM.c,22 :: 		recieveChar = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      WaitForRecieveCharAndBlink_recieveChar_L0+0
;GSM.c,24 :: 		}
L_WaitForRecieveCharAndBlink2:
;GSM.c,25 :: 		if (recieveChar == delimiterChar)
	MOVF       WaitForRecieveCharAndBlink_recieveChar_L0+0, 0
	XORWF      FARG_WaitForRecieveCharAndBlink_delimiterChar+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_WaitForRecieveCharAndBlink3
;GSM.c,27 :: 		LED_Off();
	CALL       _LED_Off+0
;GSM.c,28 :: 		break;
	GOTO       L_WaitForRecieveCharAndBlink1
;GSM.c,29 :: 		}
L_WaitForRecieveCharAndBlink3:
;GSM.c,30 :: 		}
	GOTO       L_WaitForRecieveCharAndBlink0
L_WaitForRecieveCharAndBlink1:
;GSM.c,31 :: 		}
	RETURN
; end of _WaitForRecieveCharAndBlink

_WaitForRecieveChar:

;GSM.c,33 :: 		void WaitForRecieveChar(char delimiterChar)
;GSM.c,35 :: 		char recieveChar = 0;
	CLRF       WaitForRecieveChar_recieveChar_L0+0
;GSM.c,36 :: 		while (1)
L_WaitForRecieveChar4:
;GSM.c,38 :: 		if (UART1_Data_Ready() > 0) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_WaitForRecieveChar6
;GSM.c,39 :: 		recieveChar = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      WaitForRecieveChar_recieveChar_L0+0
;GSM.c,41 :: 		}
L_WaitForRecieveChar6:
;GSM.c,42 :: 		if (recieveChar == delimiterChar) break;
	MOVF       WaitForRecieveChar_recieveChar_L0+0, 0
	XORWF      FARG_WaitForRecieveChar_delimiterChar+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_WaitForRecieveChar7
	GOTO       L_WaitForRecieveChar5
L_WaitForRecieveChar7:
;GSM.c,43 :: 		}
	GOTO       L_WaitForRecieveChar4
L_WaitForRecieveChar5:
;GSM.c,44 :: 		}
	RETURN
; end of _WaitForRecieveChar

_WaitForRecieveMessage:

;GSM.c,46 :: 		void WaitForRecieveMessage(const char message[])
;GSM.c,48 :: 		char pos = 0;
	CLRF       WaitForRecieveMessage_pos_L0+0
;GSM.c,49 :: 		while (message[pos] != 0)
L_WaitForRecieveMessage8:
	MOVF       WaitForRecieveMessage_pos_L0+0, 0
	ADDWF      FARG_WaitForRecieveMessage_message+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_WaitForRecieveMessage9
;GSM.c,51 :: 		WaitForRecieveChar(message[pos]);
	MOVF       WaitForRecieveMessage_pos_L0+0, 0
	ADDWF      FARG_WaitForRecieveMessage_message+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,52 :: 		pos++;
	INCF       WaitForRecieveMessage_pos_L0+0, 1
;GSM.c,53 :: 		}
	GOTO       L_WaitForRecieveMessage8
L_WaitForRecieveMessage9:
;GSM.c,54 :: 		}
	RETURN
; end of _WaitForRecieveMessage

_UART1_Write_Text_Constant:

;GSM.c,56 :: 		void UART1_Write_Text_Constant(const char *txt)
;GSM.c,58 :: 		while (*txt!=0)
L_UART1_Write_Text_Constant10:
	MOVF       FARG_UART1_Write_Text_Constant_txt+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_UART1_Write_Text_Constant_txt+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_UART1_Write_Text_Constant11
;GSM.c,60 :: 		UART1_Write(*txt);
	MOVF       FARG_UART1_Write_Text_Constant_txt+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_UART1_Write_Text_Constant_txt+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,61 :: 		txt++;
	INCF       FARG_UART1_Write_Text_Constant_txt+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_UART1_Write_Text_Constant_txt+1, 1
;GSM.c,62 :: 		}
	GOTO       L_UART1_Write_Text_Constant10
L_UART1_Write_Text_Constant11:
;GSM.c,63 :: 		}
	RETURN
; end of _UART1_Write_Text_Constant

_EmptySerialBuffer:

;GSM.c,65 :: 		void EmptySerialBuffer(void)
;GSM.c,68 :: 		while (UART1_Data_Ready() == 1) {
L_EmptySerialBuffer12:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_EmptySerialBuffer13
;GSM.c,69 :: 		recieveChar = UART1_Read();
	CALL       _UART1_Read+0
;GSM.c,70 :: 		}
	GOTO       L_EmptySerialBuffer12
L_EmptySerialBuffer13:
;GSM.c,71 :: 		}
	RETURN
; end of _EmptySerialBuffer

_GSM_PowerOn:

;GSM.c,73 :: 		void GSM_PowerOn(void)
;GSM.c,75 :: 		PORTB.B6 = 0;
	BCF        PORTB+0, 6
;GSM.c,76 :: 		Delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_GSM_PowerOn14:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_PowerOn14
	DECFSZ     R12+0, 1
	GOTO       L_GSM_PowerOn14
	DECFSZ     R11+0, 1
	GOTO       L_GSM_PowerOn14
	NOP
	NOP
;GSM.c,77 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;GSM.c,78 :: 		Delay_ms(2000);                 // Wait for GSM Module to power up
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_GSM_PowerOn15:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_PowerOn15
	DECFSZ     R12+0, 1
	GOTO       L_GSM_PowerOn15
	DECFSZ     R11+0, 1
	GOTO       L_GSM_PowerOn15
	NOP
;GSM.c,79 :: 		}
	RETURN
; end of _GSM_PowerOn

_GSM_PowerOff:

;GSM.c,80 :: 		void GSM_PowerOff(void)
;GSM.c,82 :: 		PORTB.B6 = 0;
	BCF        PORTB+0, 6
;GSM.c,83 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_GSM_PowerOff16:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_PowerOff16
	DECFSZ     R12+0, 1
	GOTO       L_GSM_PowerOff16
	DECFSZ     R11+0, 1
	GOTO       L_GSM_PowerOff16
	NOP
	NOP
;GSM.c,84 :: 		PORTB.B6 = 1;
	BSF        PORTB+0, 6
;GSM.c,85 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_GSM_PowerOff17:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_PowerOff17
	DECFSZ     R12+0, 1
	GOTO       L_GSM_PowerOff17
	DECFSZ     R11+0, 1
	GOTO       L_GSM_PowerOff17
	NOP
;GSM.c,86 :: 		}
	RETURN
; end of _GSM_PowerOff

_GSM_Initialize:

;GSM.c,88 :: 		void GSM_Initialize(const char firstInit)
;GSM.c,90 :: 		UART1_Write_Text_Constant("AT");
	MOVLW      ?lstr_1_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_1_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,91 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,92 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_GSM_Initialize18:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_Initialize18
	DECFSZ     R12+0, 1
	GOTO       L_GSM_Initialize18
	DECFSZ     R11+0, 1
	GOTO       L_GSM_Initialize18
	NOP
	NOP
;GSM.c,93 :: 		UART1_Write_Text_Constant("AT");
	MOVLW      ?lstr_2_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_2_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,94 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,95 :: 		WaitForRecieveChar(0x0A);
	MOVLW      10
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,96 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,97 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,98 :: 		if (firstInit == 1) BeepAndBlink(1);
	MOVF       FARG_GSM_Initialize_firstInit+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GSM_Initialize19
	MOVLW      1
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
L_GSM_Initialize19:
;GSM.c,100 :: 		UART1_Write_Text_Constant("AT+CPIN=");
	MOVLW      ?lstr_3_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_3_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,102 :: 		i = 0;
	CLRF       _i+0
;GSM.c,103 :: 		while (SIMPin[i] != 0)
L_GSM_Initialize20:
	MOVF       _i+0, 0
	ADDLW      _SIMPin+0
	MOVWF      R0+0
	MOVLW      hi_addr(_SIMPin+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_GSM_Initialize21
;GSM.c,105 :: 		UART1_Write(SIMPin[i]);
	MOVF       _i+0, 0
	ADDLW      _SIMPin+0
	MOVWF      R0+0
	MOVLW      hi_addr(_SIMPin+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,106 :: 		i++;
	INCF       _i+0, 1
;GSM.c,107 :: 		}
	GOTO       L_GSM_Initialize20
L_GSM_Initialize21:
;GSM.c,108 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,109 :: 		WaitForRecieveChar(0x0A);
	MOVLW      10
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,110 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,111 :: 		if (firstInit == 1) BeepAndBlink(1);
	MOVF       FARG_GSM_Initialize_firstInit+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GSM_Initialize22
	MOVLW      1
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
L_GSM_Initialize22:
;GSM.c,113 :: 		WaitForRecieveMessage("Call Ready");
	MOVLW      ?lstr4_GSM+0
	MOVWF      FARG_WaitForRecieveMessage_message+0
	CALL       _WaitForRecieveMessage+0
;GSM.c,114 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,115 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,116 :: 		if (firstInit == 1) BeepAndBlink(1);
	MOVF       FARG_GSM_Initialize_firstInit+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GSM_Initialize23
	MOVLW      1
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
L_GSM_Initialize23:
;GSM.c,118 :: 		UART1_Write_Text_Constant("AT+CREG?");
	MOVLW      ?lstr_5_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_5_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,119 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,120 :: 		WaitForRecieveChar(0x0D);
	MOVLW      13
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,121 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,122 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,123 :: 		if (firstInit == 1) BeepAndBlink(1);
	MOVF       FARG_GSM_Initialize_firstInit+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GSM_Initialize24
	MOVLW      1
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
L_GSM_Initialize24:
;GSM.c,126 :: 		Delay_ms(10000); // Wait for the GSM module to connect to the GSM network (Response +CREG: 0,1)
	MOVLW      102
	MOVWF      R11+0
	MOVLW      118
	MOVWF      R12+0
	MOVLW      193
	MOVWF      R13+0
L_GSM_Initialize25:
	DECFSZ     R13+0, 1
	GOTO       L_GSM_Initialize25
	DECFSZ     R12+0, 1
	GOTO       L_GSM_Initialize25
	DECFSZ     R11+0, 1
	GOTO       L_GSM_Initialize25
;GSM.c,127 :: 		UART1_Write_Text_Constant("AT+CREG?");
	MOVLW      ?lstr_6_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_6_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,128 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,129 :: 		WaitForRecieveChar(0x0D);
	MOVLW      13
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,130 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,131 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,132 :: 		if (firstInit == 1) BeepAndBlink(1);
	MOVF       FARG_GSM_Initialize_firstInit+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GSM_Initialize26
	MOVLW      1
	MOVWF      FARG_BeepAndBlink_count+0
	CALL       _BeepAndBlink+0
L_GSM_Initialize26:
;GSM.c,135 :: 		}
	RETURN
; end of _GSM_Initialize

_SendSMS:

;GSM.c,137 :: 		void SendSMS(const char message[])   // Send SMS to danish number
;GSM.c,139 :: 		GSM_PowerOn();
	CALL       _GSM_PowerOn+0
;GSM.c,140 :: 		LED_On(); // Turn on LED
	CALL       _LED_On+0
;GSM.c,141 :: 		GSM_Initialize(0);
	CLRF       FARG_GSM_Initialize_firstInit+0
	CALL       _GSM_Initialize+0
;GSM.c,142 :: 		UART1_Write_Text_Constant("AT+CMGF=1");
	MOVLW      ?lstr_7_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_7_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,143 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,144 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_SendSMS27:
	DECFSZ     R13+0, 1
	GOTO       L_SendSMS27
	DECFSZ     R12+0, 1
	GOTO       L_SendSMS27
	NOP
;GSM.c,145 :: 		WaitForRecieveChar(0x0D);
	MOVLW      13
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,146 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,147 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,149 :: 		UART1_Write_Text_Constant("AT+CSCS=");
	MOVLW      ?lstr_8_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_8_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,150 :: 		UART1_Write(34); // "
	MOVLW      34
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,151 :: 		UART1_Write_Text_Constant("GSM");
	MOVLW      ?lstr_9_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_9_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,152 :: 		UART1_Write(34); // "
	MOVLW      34
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,153 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,154 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_SendSMS28:
	DECFSZ     R13+0, 1
	GOTO       L_SendSMS28
	DECFSZ     R12+0, 1
	GOTO       L_SendSMS28
	NOP
;GSM.c,155 :: 		WaitForRecieveChar(0x0D);
	MOVLW      13
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,156 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,157 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,160 :: 		UART1_Write_Text_Constant("AT+CMGS=");
	MOVLW      ?lstr_10_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_10_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,161 :: 		UART1_Write(34); // "
	MOVLW      34
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,162 :: 		UART1_Write_Text_Constant("45"); // Country code (Denmark)
	MOVLW      ?lstr_11_GSM+0
	MOVWF      FARG_UART1_Write_Text_Constant_txt+0
	MOVLW      hi_addr(?lstr_11_GSM+0)
	MOVWF      FARG_UART1_Write_Text_Constant_txt+1
	CALL       _UART1_Write_Text_Constant+0
;GSM.c,163 :: 		UART1_Write_Text(MobileNumber);
	MOVLW      _MobileNumber+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;GSM.c,164 :: 		UART1_Write(34); // "
	MOVLW      34
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,165 :: 		UART1_Write(13); //Carriage return (new line)
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,166 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SendSMS29:
	DECFSZ     R13+0, 1
	GOTO       L_SendSMS29
	DECFSZ     R12+0, 1
	GOTO       L_SendSMS29
	DECFSZ     R11+0, 1
	GOTO       L_SendSMS29
	NOP
	NOP
;GSM.c,167 :: 		WaitForRecieveChar(0x0A);
	MOVLW      10
	MOVWF      FARG_WaitForRecieveChar_delimiterChar+0
	CALL       _WaitForRecieveChar+0
;GSM.c,170 :: 		i = 0;
	CLRF       _i+0
;GSM.c,171 :: 		while (message[i] != 0)
L_SendSMS30:
	MOVF       _i+0, 0
	ADDWF      FARG_SendSMS_message+0, 0
	MOVWF      R0+0
	MOVF       FARG_SendSMS_message+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SendSMS31
;GSM.c,173 :: 		UART1_Write(message[i]);
	MOVF       _i+0, 0
	ADDWF      FARG_SendSMS_message+0, 0
	MOVWF      R0+0
	MOVF       FARG_SendSMS_message+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,174 :: 		i++;
	INCF       _i+0, 1
;GSM.c,175 :: 		}
	GOTO       L_SendSMS30
L_SendSMS31:
;GSM.c,176 :: 		UART1_Write(26); // Substitution (CTRL+Z)
	MOVLW      26
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;GSM.c,177 :: 		WaitForRecieveCharAndBlink(0x0A);
	MOVLW      10
	MOVWF      FARG_WaitForRecieveCharAndBlink_delimiterChar+0
	CALL       _WaitForRecieveCharAndBlink+0
;GSM.c,178 :: 		EmptySerialBuffer();
	CALL       _EmptySerialBuffer+0
;GSM.c,179 :: 		CancelAlarmOnClick(); // Check if # is held - if true, disable the alarm and buzzer
	CALL       _CancelAlarmOnClick+0
;GSM.c,181 :: 		Delay_ms(1000); // Give time to send the message
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_SendSMS32:
	DECFSZ     R13+0, 1
	GOTO       L_SendSMS32
	DECFSZ     R12+0, 1
	GOTO       L_SendSMS32
	DECFSZ     R11+0, 1
	GOTO       L_SendSMS32
	NOP
	NOP
;GSM.c,182 :: 		GSM_PowerOff();
	CALL       _GSM_PowerOff+0
;GSM.c,183 :: 		}
	RETURN
; end of _SendSMS

_SetNewNumber:

;GSM.c,185 :: 		void SetNewNumber(void)
;GSM.c,189 :: 		for(i = 0; i < 8; i++)
	CLRF       SetNewNumber_i_L0+0
L_SetNewNumber33:
	MOVLW      8
	SUBWF      SetNewNumber_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SetNewNumber34
;GSM.c,195 :: 		do
L_SetNewNumber36:
;GSM.c,197 :: 		PressedKey = GetKeyPad();
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	MOVWF      SetNewNumber_PressedKey_L0+0
;GSM.c,198 :: 		} while (PressedKey == 0); // Wait for press
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SetNewNumber36
;GSM.c,199 :: 		MobileNumber[i] = PressedKey;
	MOVF       SetNewNumber_i_L0+0, 0
	ADDLW      _MobileNumber+0
	MOVWF      FSR
	MOVF       SetNewNumber_PressedKey_L0+0, 0
	MOVWF      INDF+0
;GSM.c,200 :: 		Buzzer_Beep(1);
	MOVLW      1
	MOVWF      FARG_Buzzer_Beep_count+0
	CALL       _Buzzer_Beep+0
;GSM.c,210 :: 		while(GetKeyPad() != 0); // Wait for release
L_SetNewNumber39:
	CALL       _GetKeyPad+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SetNewNumber40
	GOTO       L_SetNewNumber39
L_SetNewNumber40:
;GSM.c,189 :: 		for(i = 0; i < 8; i++)
	INCF       SetNewNumber_i_L0+0, 1
;GSM.c,211 :: 		}
	GOTO       L_SetNewNumber33
L_SetNewNumber34:
;GSM.c,212 :: 		MobileNumber[8] = 0;
	CLRF       _MobileNumber+8
;GSM.c,217 :: 		}
	RETURN
; end of _SetNewNumber

_SaveNumberToEEProm:

;GSM.c,219 :: 		void SaveNumberToEEProm(void)
;GSM.c,221 :: 		EEPROM_Write(0x00, MobileNumber[0]);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,222 :: 		EEPROM_Write(0x01, MobileNumber[1]);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+1, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,223 :: 		EEPROM_Write(0x02, MobileNumber[2]);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+2, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,224 :: 		EEPROM_Write(0x03, MobileNumber[3]);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,225 :: 		EEPROM_Write(0x04, MobileNumber[4]);
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+4, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,226 :: 		EEPROM_Write(0x05, MobileNumber[5]);
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+5, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,227 :: 		EEPROM_Write(0x06, MobileNumber[6]);
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+6, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,228 :: 		EEPROM_Write(0x07, MobileNumber[7]);
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _MobileNumber+7, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;GSM.c,229 :: 		}
	RETURN
; end of _SaveNumberToEEProm

_ReadNumberFromEEProm:

;GSM.c,231 :: 		void ReadNumberFromEEProm(void)
;GSM.c,233 :: 		MobileNumber[0] = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+0
;GSM.c,234 :: 		MobileNumber[1] = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+1
;GSM.c,235 :: 		MobileNumber[2] = EEPROM_Read(0x02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+2
;GSM.c,236 :: 		MobileNumber[3] = EEPROM_Read(0x03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+3
;GSM.c,237 :: 		MobileNumber[4] = EEPROM_Read(0x04);
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+4
;GSM.c,238 :: 		MobileNumber[5] = EEPROM_Read(0x05);
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+5
;GSM.c,239 :: 		MobileNumber[6] = EEPROM_Read(0x06);
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+6
;GSM.c,240 :: 		MobileNumber[7] = EEPROM_Read(0x07);
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _MobileNumber+7
;GSM.c,241 :: 		MobileNumber[8] = 0;
	CLRF       _MobileNumber+8
;GSM.c,242 :: 		}
	RETURN
; end of _ReadNumberFromEEProm

_CheckNumber:

;GSM.c,245 :: 		char CheckNumber(void)
;GSM.c,247 :: 		for(i = 0; i < 8; i++)
	CLRF       _i+0
L_CheckNumber41:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_CheckNumber42
;GSM.c,249 :: 		if (MobileNumber[i] < '0' || MobileNumber[i] > '9')
	MOVF       _i+0, 0
	ADDLW      _MobileNumber+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      48
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__CheckNumber47
	MOVF       _i+0, 0
	ADDLW      _MobileNumber+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L__CheckNumber47
	GOTO       L_CheckNumber46
L__CheckNumber47:
;GSM.c,250 :: 		return 0; // Return that the saved number is WRONG
	CLRF       R0+0
	RETURN
L_CheckNumber46:
;GSM.c,247 :: 		for(i = 0; i < 8; i++)
	INCF       _i+0, 1
;GSM.c,251 :: 		}
	GOTO       L_CheckNumber41
L_CheckNumber42:
;GSM.c,252 :: 		return 1; // Return that the saved number is OK
	MOVLW      1
	MOVWF      R0+0
;GSM.c,253 :: 		}
	RETURN
; end of _CheckNumber
