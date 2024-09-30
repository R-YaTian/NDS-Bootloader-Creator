######################################
# target
######################################
TARGET = ndsblc

# Add extension for clean in Windows
UNAME = $(shell uname -s)

ifneq (,$(findstring MINGW,$(UNAME))$(findstring CYGWIN,$(UNAME)))
	TARGET_EXT = .exe
endif

######################################
# building variables
######################################
# optimization
OPT = -Os

######################################
# source
######################################
# C sources
C_SOURCES =  $(wildcard src/*.c)

#######################################
# CFLAGS
#######################################
# C includes
C_INCLUDES = \
-Iinc

# compile gcc flags
CFLAGS = $(C_INCLUDES) $(OPT) -Wall

#######################################
# LDFLAGS
#######################################
LDFLAGS =

ifeq ($(MAC_ARM),1)
	CFLAGS += -target arm64-apple-macos11
	TARGET = arm_app
endif
ifeq ($(MAC_X86),1)
	CFLAGS += -target x86_64-apple-macos10.12
	TARGET = x86_app
endif

# default action: build all
all: $(TARGET)

#######################################
# build the application
#######################################
# list of objects
OBJECTS = src/crc16.o src/main.o src/create-bootloader.o

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -o $@

#######################################
# clean up
#######################################
clean:
	@rm -rf $(OBJECTS) $(TARGET) $(TARGET_EXT)
