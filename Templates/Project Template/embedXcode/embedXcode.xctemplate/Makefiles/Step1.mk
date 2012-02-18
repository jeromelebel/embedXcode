#
# embedXcode
# ----------------------------------
# Embedded Computing on Xcode 4.3
#
# © Rei VILO, 2010-2012
# CC = BY NC SA
#

# References and contribution
# ----------------------------------
# See About folder
# 


# Sketch unicity test and extension
# ----------------------------------
#
ifeq ($(words $(wildcard *.pde) $(wildcard *.ino)), 0)
    $(error No pde or ino sketch)
endif

ifneq ($(words $(wildcard *.pde) $(wildcard *.ino)), 1)
    $(error More than 1 pde or ino sketch)
endif


ifneq ($(wildcard *.pde),)
    SKETCH_EXTENSION := pde
else ifneq ($(wildcard *.ino),)
    SKETCH_EXTENSION := ino
else 
    $(error Extension error)
endif


# Early info
#
$(info  ---- info ----)
$(info Project)
$(info .    target		$(MAKECMDGOALS))
$(info .    name		$(PROJECT_NAME))
$(info .    tag 		$(BOARD_TAG))
$(info .    extension	$(SKETCH_EXTENSION))


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
OLD_TAG := $(strip $(wildcard $(OBJDIR)/*-TAG))
NEW_TAG := $(strip $(OBJDIR)/$(BOARD_TAG)-TAG)

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
    $(info .    platform	Arduino)
    include $(MAKEFILE_PATH)/Arduino.mk	
else ifneq ($(shell grep $(BOARD_TAG).name $(MPIDE_PATH)/hardware/pic32/boards.txt),)
    $(info .    platform	Mpide)     
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
