< envPaths
errlogInit(20000)

dbLoadDatabase("$(TOP)/dbd/mar345App.dbd")
mar345App_registerRecordDeviceDriver(pdbbase) 

epicsEnvSet("PREFIX", "13MAR345_1:")
epicsEnvSet("PORT",   "MAR")
epicsEnvSet("QSIZE",  "20")
epicsEnvSet("XSIZE",  "3450")
epicsEnvSet("YSIZE",  "3450")
epicsEnvSet("NCHANS", "2048")

###
# Create the asyn port to talk to the MAR on port 5001
drvAsynIPPortConfigure("marServer","gse-marip2.cars.aps.anl.gov:5001")
# Set the input and output terminators.
asynOctetSetInputEos("marServer", 0, "\n")
asynOctetSetOutputEos("marServer", 0, "\n")
asynSetTraceIOMask("marServer",0,2)
#asynSetTraceMask("marServer",0,255)

mar345Config("$(PORT)", "marServer", 0, 0)
asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",0,255)
dbLoadRecords("$(ADCORE)/db/ADBase.template","P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(ADCORE)/db/NDFile.template","P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(ADMAR345)/db/mar345.template","P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1,MARSERVER_PORT=marServer")

# Create a standard arrays plugin
NDStdArraysConfigure("Image1", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/db/NDPluginBase.template","P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,TYPE=Int16,FTVL=SHORT,NELEMENTS=12000000")

# Load all other plugins using commonPlugins.cmd
< $(ADCORE)/iocBoot/commonPlugins.cmd
set_requestfile_path("$(ADMAR345)/mar345App/Db")

#asynSetTraceMask("$(PORT)",0,3)
#asynSetTraceIOMask("$(PORT)",0,4)

iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=$(PREFIX)")
