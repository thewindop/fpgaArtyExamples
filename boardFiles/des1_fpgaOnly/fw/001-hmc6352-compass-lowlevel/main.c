/******************************************************************************
*
* Copyright (C) 2002 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
* This file is a modified version of the Xilinx example
* xiic_low_level_tempsensor_example.c
*
*****************************************************************************/
/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xiic_l.h"

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define IIC_BASE_ADDRESS	XPAR_IIC_0_BASEADDR

/************************** Function Prototypes ******************************/

int LowLevelTempSensorExample(u32 IicBaseAddress,
				u8 TempSensorAddress,
				u8 *sendBuffer,
				u8 *TemperaturePtr);

int main(void)
{
	// Declare buffers
	u8 i2cResultBuffer[10];
	u8 sendBuffer[10];

	/*
	 * Load this with the A command to perform a read. To get the heading we need to send the commmand then read 2 bytes
	 *
	 * Bytes on the line
	 *   slave address write
	 *   command A = 0x41
	 *   slave address read
	 *   read MSB byte
	 *   read LSB byte
	 *
	 * https://www.sparkfun.com/datasheets/Components/HMC6352.pdf
	 * Buy in UK, https://proto-pic.co.uk/compass-module-hmc6352/
	 *
	 * */
	sendBuffer[0] = 0x41;

	/*
	 * Run the example, specify the Base Address that is generated in
	 * xparameters.h
	 */
	while (1) {
	LowLevelTempSensorExample(IIC_BASE_ADDRESS,
					0x21,
					sendBuffer, i2cResultBuffer);
	xil_printf("We got angle = %d\n\r", ((i2cResultBuffer[0]<<8) + i2cResultBuffer[1]));
}
	return 0;
}

/*****************************************************************************/
/**
*
* The function reads the temperature of the IIC temperature sensor on the
* IIC bus using the low-level driver.
*
* @param	IicBaseAddress is the base address of the device.
* @param	TempSensorAddress is the address of the Temperature Sensor device
*		on the IIC bus.
* @param	TemperaturePtr is the databyte read from the temperature sensor.
*
* @return	The number of bytes read from the temperature sensor, normally one
*		byte if successful.
*
* @note		None.
*
****************************************************************************/
int LowLevelTempSensorExample(u32 IicBaseAddress,
				u8  TempSensorAddress,
				u8 *sendBuffer,
				u8 *TemperaturePtr)
{
	int ByteCount;

	ByteCount = XIic_Send(IicBaseAddress, TempSensorAddress,
			    sendBuffer, 1, XIIC_STOP);
	ByteCount = XIic_Recv(IicBaseAddress, TempSensorAddress,
				TemperaturePtr, 2, XIIC_STOP);

	return ByteCount;
}
