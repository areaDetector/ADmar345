TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

LIBRARY_IOC_Linux += mar345
LIBRARY_IOC_Darwin += mar345

LIB_SRCS += mar345.cpp
LIB_SRCS += mar3xx_pck.c

PROD_IOC_Linux += mar345App
PROD_IOC_Darwin += mar345App

#==================================

# <name>.dbd will be created from <name>Include.dbd
DBD += mar345App.dbd
DBD += mar345Support.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
PROD_SRCS += mar345App_registerRecordDeviceDriver.cpp mar345AppMain.cpp

# Add locally compiled object code
PROD_LIBS += mar345

include $(TOP)/ADApp/commonDriverMakefile

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

