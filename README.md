# Serial Device Drivers for DAQFactory

A small collection of example sequences and portable driver files for data
acquisition and control using [DAQFactory](http://www.azeotech.com/).

| Description                                                       | Manufacturer             | Model   | Protocol Name |
|:------------------------------------------------------------------|:-------------------------|:--------|:--------------|
| Trace gas analyzer (N<sub>2</sub>O/CO/H<sub>2</sub>O)             | Los Gatos Research (LGR) | DLT-100 series N<sub>2</sub>O/CO | [`LGR_N2O_CO`](LGR_N2O_CO/) |
| Trace gas analyzer (CO<sub>2</sub>/CH<sub>4</sub>/H<sub>2</sub>O) | Los Gatos Research (LGR) | Ultraportable Greenhouse Gas Analyzer (UGGA) | [`LGR_UGGA`](LGR_UGGA/) |

## Installation

Example sequences can be used without installing any additional files. In your
DAQFactory control document:

1. Create a new DAQFactory device (setup details must match those given in example)
2. Import channels from provided file, or manually create them (channel names must match those given in example)
3. Copy-paste the sequence(s) into your control document import the channel
4. If specified in the example instructions, enable sequence auto-start

Portable driver files must be installed before launching DAQFactory. To install
them:

1. Run the script `install.bat` with administrator permissions (right-click &rarr; *Run as Administrator*)
2. Choose `Yes` to allow the batch file to run
3. When prompted, type `y` to confirm overwriting any existing installed protocol files
4. Files will be copied into `C:\DAQFactory\` (default install location). Review
   output to verify copying was completed successfully.
5. Press any key to exit or wait for the timeout

## License

Released under the terms of the [MIT License](LICENSE).

## Disclaimers

This work is not affiliated with or endorsed by any manufacturer or company
mentioned here. 


----

> *Older protocols listed below need some attention...*

## Installation

1. Copy `src/*.ddp` files into the DAQFactory program folder (typ `C:\DAQFactory\`).
2. Restart DAQFActory


## Available Drivers

### ATI sonic anemometer

For SATI-* series ultrasonic anemometers by Applied Technologies Inc (ATI).
Developed using type K and Sx models but probably usable or at least adaptable
to other types. 


### Campbell Scientific sonic anemometer

For the older CSAT3 ultrasonic anemometer made by Campbell Scientific.


### Hamamatsu photomultiplier tube (PMT)

For model HC-135 photomultplier tube (PMT) manufactured by Hamamatsu Corp. This
is the analytical component of the Hills Scientific Fast Isoprene Sensor (FIS).


### LICOR open-path CO2 analyzer

For model LI-7500 open-path infrared CO2/H2O analyzer (IRGA).


### TSI condensation particle counter

Developed for Model 3775 Condensation Particle Counter (CPC) by TSI.


### Vaisala WXT510 weather station

For the WXT510 compact total weather station by Vaisala.



