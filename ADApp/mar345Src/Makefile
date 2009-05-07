TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#USR_CFLAGS += 
#USR_CXXFLAGS +=

# We only build on Linux and Solaris.  If your architecture has
# libtiff, libjpeg, and libz you can add it here.
LIBRARY_IOC_Linux = mar345
LIBRARY_IOC_solaris = mar345
PROD_IOC_Linux += mar345App
PROD_IOC_solaris += mar345App

LIB_SRCS += mar345.cpp
LIB_SRCS += mar3xx_pck.c
LIB_LIBS += NDPlugin ADBase netCDF
LIB_LIBS += calc busy sscan autosave mca
LIB_LIBS += asyn
LIB_LIBS += $(EPICS_BASE_IOC_LIBS)
LIB_SYS_LIBS += tiff jpeg z

#==================================

# <name>.dbd will be created from <name>Include.dbd
DBD += mar345App.dbd
DBD += mar345Support.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
mar345App_SRCS_DEFAULT += mar345App_registerRecordDeviceDriver.cpp mar345AppMain.cpp
mar345App_SRCS_vxWorks += mar345App_registerRecordDeviceDriver.cpp

# Add locally compiled object code
mar345App_LIBS += mar345
mar345App_LIBS += NDPlugin ADBase netCDF
mar345App_LIBS += calc busy sscan autosave mca
mar345App_LIBS += asyn
mar345App_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

