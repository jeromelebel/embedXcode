#
# embedXcode
# ----------------------------------
# Embedded Computing on Xcode 4.3
#
# © Rei VILO, 2010-2012
# CC = BY NC SA
#


# Libraries
# ----------------------------------
# Declare application Arduino/chipKIT and users libraries used 
# Short-listing libraries sppeds-up building
# Otherwise, all will be considered (default)
#
#APP_LIBS_LIST = Wire Wire/utility EEPROM Ethernet Ethernet/utility \
	SPI Firmata LiquidCrystal Matrix Sprite SD SD/utility Servo SoftwareSerial Stepper 

APP_LIBS_LIST = Wire Wire/utility

USER_LIBS_LIST = I2C_20x4 I2C_Clock I2C_Stepper \
	I2C_Thermometer I2C_Pressure I2C_Humidity I2C_Climate \
	I2C_Accelerometer I2C_Magnetometer I2C_Compass I2C_Gyroscope I2C_IMU \
	I2C_Potentiometer I2C_Height_IOs \
	I2C_RGBC_Reader I2C_RGB_LED \
	NewSoftSerial I2C_Serial Serial_LCD \
	MatrixMath MsTimer2 Serial_GPS pic32_RTC \
	DWIFIcK DWIFIcK/Utility DWIFIcK/Utility/TCPIP\ Stack

USER_LIBS_LIST = NewSoftSerial I2C_Serial DWIFIcK DWIFIcK/Utility


MAKEFILE_PATH = $(CURDIR)/Makefiles

include $(MAKEFILE_PATH)/Step1.mk