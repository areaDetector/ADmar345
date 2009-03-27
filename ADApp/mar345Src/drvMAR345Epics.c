/* drvMAR345Epics.c
 *
 * This is the EPICS dependent code for the MAR-345 driver.
 * By making this separate file for the EPICS dependent code the driver itself
 * only needs libCom from EPICS for OS-independence.
 *
 * Author: Mark Rivers
 *         University of Chicago
 *
 * Created:  March 15, 2009
 *
 */
 
#include <iocsh.h>
#include <drvSup.h>
#include <epicsExport.h>

#include "drvMAR345.h"


/* Code for iocsh registration */

/* mar345Config */
static const iocshArg mar345ConfigArg0 = {"Port name", iocshArgString};
static const iocshArg mar345ConfigArg1 = {"server port name", iocshArgString};
static const iocshArg mar345ConfigArg2 = {"maxBuffers", iocshArgInt};
static const iocshArg mar345ConfigArg3 = {"maxMemory", iocshArgInt};
static const iocshArg mar345ConfigArg4 = {"priority", iocshArgInt};
static const iocshArg mar345ConfigArg5 = {"stackSize", iocshArgInt};
static const iocshArg * const mar345ConfigArgs[] =  {&mar345ConfigArg0,
                                                     &mar345ConfigArg1,
                                                     &mar345ConfigArg2,
                                                     &mar345ConfigArg3,
                                                     &mar345ConfigArg4,
                                                     &mar345ConfigArg5};
static const iocshFuncDef configMAR345 = {"mar345Config", 6, mar345ConfigArgs};
static void configMAR345CallFunc(const iocshArgBuf *args)
{
    mar345Config(args[0].sval, args[1].sval, args[2].ival,
                 args[3].ival, args[4].ival, args[5].ival);
}


static void mar345Register(void)
{

    iocshRegister(&configMAR345, configMAR345CallFunc);
}

epicsExportRegistrar(mar345Register);


