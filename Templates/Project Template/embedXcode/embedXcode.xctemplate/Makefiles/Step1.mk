#
# embedXcode
# ----------------------------------
# Embedded Computing on Xcode 4.2
#
# © Rei VILO, 2010-2012
# CC = BY NC SA
#

# References and contribution
# ----------------------------------
# See About folder
# 


# Board selection
# ----------------------------------
# Board specifics defined in .xconfig file
# BOARD_TAG and AVRDUDE_PORT 
#
ifneq ($(MAKECMDGOALS),boards)
ifneq ($(MAKECMDGOALS),clean)
ifndef BOARD_TAG
    $(error BOARD_TAG not defined)
endif
endif
endif

ifndef BOARD_PORT
    BOARD_PORT = /dev/tty.usb*
endif

NO_CORE_MAIN_FUNCTION = 1


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
	MatrixMath MsTimer2 Serial_GPS pic32_RTC

USER_LIBS_LIST = NewSoftSerial I2C_Serial


# Paths
# ----------------------------------
# Sketchbook/Libraries path
# wildcard required for ~ management
#
USER_LIB_PATH = $(wildcard $(SKETCHBOOK_DIR)/Libraries)


# Arduino.app Mpide.app path
#
ARDUINO_APP = /Applications/Arduino.app
MPIDE_APP   = /Applications/Mpide.app

ifeq ($(wildcard $(ARDUINO_APP)),)
ifeq ($(wildcard $(MPIDE_APP)),)
    $(error Error: no application found)
endif
endif

ARDUINO_PATH = $(ARDUINO_APP)/Contents/Resources/Java
MPIDE_PATH   = $(MPIDE_APP)/Contents/Resources/Java

# Builds directory
#
OBJDIR  = Builds


# Clean if new BOARD_TAG
# ----------------------------------
#
OLD_TAG := $(wildcard $(OBJDIR)/*-TAG)
NEW_TAG := $(OBJDIR)/$(BOARD_TAG)-TAG

$(info *** $(OLD_TAG))

ifneq ($(OLD_TAG),$(NEW_TAG))
    CHANGE_FLAG := 1
else
	CHANGE_FLAG := 0
endif


# Identification and switch
# ----------------------------------
# Look if BOARD_TAG is listed as a Arduino/Arduino board
# Look if BOARD_TAG is listed as a Mpide/PIC32 board
#
ifneq ($(MAKECMDGOALS),boards)
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(shell grep $(BOARD_TAG).name $(ARDUINO_PATH)/hardware/arduino/boards.txt),)
    $(info info Arduino)
    include $(MAKEFILE_PATH)/Arduino.mk	
else ifneq ($(shell grep $(BOARD_TAG).name $(MPIDE_PATH)/hardware/pic32/boards.txt),)
    $(info info Mpide)     
    include $(MAKEFILE_PATH)/Mpide.mk
else
    $(error $(BOARD_TAG) is unknown)
endif
endif
endif


# Miscellaneous
# ----------------------------------
# Variables
#
NO_CORE_MAIN_FUNCTION = 1 
TARGET = embeddedcomputing


# List of sub-paths to be excluded
#
EXCLUDE_NAMES = Example example Examples examples Archive archive Archives archives Documentation documentation Reference reference
EXCLUDE_LIST  = $(addprefix %,$(EXCLUDE_NAMES))

# Function PARSE_BOARD data retrieval from boards.txt
# result = $(call READ_BOARD_TXT,'boardname','parameter')
#
PARSE_BOARD = $(shell grep $(1).$(2) $(BOARDS_TXT) | cut -d = -f 2 )


include $(MAKEFILE_PATH)/Step2.mk
