/* drvMAR345.h
 *
 * This is a driver for a MAR 345 detector.
 *
 * Author: Mark Rivers
 *         University of Chicago
 *
 * Created:  March 15, 2009
 *
 */

#ifndef DRV_MAR345_H
#define DRV_MAR345_H

#ifdef __cplusplus
extern "C" {
#endif

int mar345Config(const char *portName, const char *mar345Port,
                 int maxBuffers, size_t maxMemory,
                 int priority, int stackSize);

#ifdef __cplusplus
}
#endif
#endif
