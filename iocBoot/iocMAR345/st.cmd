< envPaths
errlogInit(20000)

dbLoadDatabase("$(AREA_DETECTOR)/dbd/mar345App.dbd")
mar345App_registerRecordDeviceDriver(pdbbase) 

###
# Create the asyn port to talk to the MAR on port 5001
drvAsynIPPortConfigure("marServer","gse-marip2.cars.aps.anl.gov:5001")
# Set the input and output terminators.
asynOctetSetInputEos("marServer", 0, "\n")
asynOctetSetOutputEos("marServer", 0, "\n")
asynSetTraceIOMask("marServer",0,2)
#asynSetTraceMask("marServer",0,255)

mar345Config("MAR", "marServer", 20, 200000000)
asynSetTraceIOMask("MAR",0,2)
#asynSetTraceMask("MAR",0,255)
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/ADBase.template",  "P=13MAR345_1:,R=cam1:,PORT=MAR,ADDR=0,TIMEOUT=1")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDFile.template","P=13MAR345_1:,R=cam1:,PORT=MAR,ADDR=0,TIMEOUT=1")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/mar345.template","P=13MAR345_1:,R=cam1:,PORT=MAR,ADDR=0,TIMEOUT=1,MARSERVER_PORT=marServer")

# Create a standard arrays plugin
NDStdArraysConfigure("MARImage", 5, 0, "MAR", 0, -1)
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDPluginBase.template","P=13MAR345_1:,R=image1:,PORT=MARImage,ADDR=0,TIMEOUT=1,NDARRAY_PORT=MAR,NDARRAY_ADDR=0")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDStdArrays.template", "P=13MAR345_1:,R=image1:,PORT=MARImage,ADDR=0,TIMEOUT=1,SIZE=16,FTVL=SHORT,NELEMENTS=12000000")

# Create an ROI plugin
NDROIConfigure("MARROI", 5, 0, "MAR", 0, 4, 20, -1)
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDPluginBase.template","P=13MAR345_1:,R=ROI1:,  PORT=MARROI,ADDR=0,TIMEOUT=1,NDARRAY_PORT=MAR,NDARRAY_ADDR=0")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDROI.template",       "P=13MAR345_1:,R=ROI1:,  PORT=MARROI,ADDR=0,TIMEOUT=1")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDROIN.template",      "P=13MAR345_1:,R=ROI1:0:,PORT=MARROI,ADDR=0,TIMEOUT=1,HIST_SIZE=256")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDROIN.template",      "P=13MAR345_1:,R=ROI1:1:,PORT=MARROI,ADDR=1,TIMEOUT=1,HIST_SIZE=256")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDROIN.template",      "P=13MAR345_1:,R=ROI1:2:,PORT=MARROI,ADDR=2,TIMEOUT=1,HIST_SIZE=256")
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDROIN.template",      "P=13MAR345_1:,R=ROI1:3:,PORT=MARROI,ADDR=3,TIMEOUT=1,HIST_SIZE=256")

#asynSetTraceMask("MARROI",0,3)
#asynSetTraceIOMask("MARROI",0,4)

# Load scan records
dbLoadRecords("$(SSCAN)/sscanApp/Db/scan.db", "P=13MAR345_1:,MAXPTS1=2000,MAXPTS2=200,MAXPTS3=20,MAXPTS4=10,MAXPTSH=10")

set_requestfile_path("./")
set_savefile_path("./autosave")
set_requestfile_path("$(AREA_DETECTOR)/ADApp/Db")
set_requestfile_path("$(SSCAN)/sscanApp/Db")
set_pass0_restoreFile("auto_settings.sav")
set_pass1_restoreFile("auto_settings.sav")
save_restoreSet_status_prefix("13MAR345_1:")
dbLoadRecords("$(AUTOSAVE)/asApp/Db/save_restoreStatus.db", "P=13MAR345_1:")

iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=13MAR345_1:,D=cam1:")
