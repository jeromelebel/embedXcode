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


# chipKIT specifics
# ----------------------------------
#
APPLICATION_PATH := /Applications/Mpide.app/Contents/Resources/Java

APP_TOOLS_PATH   := $(APPLICATION_PATH)/hardware/pic32/compiler/pic32-tools/bin
CORE_LIB_PATH    := $(APPLICATION_PATH)/hardware/pic32/cores/pic32
APP_LIB_PATH     := $(APPLICATION_PATH)/hardware/pic32/libraries
BOARDS_TXT       := $(APPLICATION_PATH)/hardware/pic32/boards.txt


CC      = $(APP_TOOLS_PATH)/pic32-gcc
CXX     = $(APP_TOOLS_PATH)/pic32-g++
AR      = $(APP_TOOLS_PATH)/pic32-ar
OBJDUMP = $(APP_TOOLS_PATH)/pic32-objdump
OBJCOPY = $(APP_TOOLS_PATH)/pic32-objcopy
SIZE    = $(APP_TOOLS_PATH)/pic32-size
NM      = $(APP_TOOLS_PATH)/pic32-nm


BOARD    = $(call PARSE_BOARD,$(BOARD_TAG),board)
LDSCRIPT = $(call PARSE_BOARD,$(BOARD_TAG),ldscript)
VARIANT  = $(call PARSE_BOARD,$(BOARD_TAG),build.variant)

MCU_FLAG_NAME  = mprocessor
EXTRA_LDFLAGS  = -T$(CORE_LIB_PATH)/$(LDSCRIPT)
EXTRA_CPPFLAGS = -O2 -mno-smart-io -DARDUINO=23 -D$(BOARD)  \
		-I$(APPLICATION_PATH)/hardware/pic32/variants/$(VARIANT)

