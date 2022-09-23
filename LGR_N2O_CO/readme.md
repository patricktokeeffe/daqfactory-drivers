# Los Gatos Research N<sub>2</sub>O/CO Analyzer (benchtop DLT-100)

Protocol for reading data streamed by serial (RS-232) from a Los Gatos Research
[N2O/CO DLT-100 series analyzer](http://losgatosresearch.com/analyzers/overview.php?prodid=20).

![Los Gatos Research N2O/CO in DLT-100 form factor](clipart.png)

## Serial Port Configuration

> *Note: a null modem adapter or null modem cable is required.*

Recommended configuration for analyzer:

- Baud rate: `115200`
- Parity: `None`
- Stop Bits: `1`
- Delimiter: `Comma` (required)
- Rate = N: `1`

Corresponding serial port setup in DAQFactory:

- Baud rate: `115200`
- Byte size: `8`
- Parity: `None`
- Stop bits: `1`
- Timeout: `1000` msec
- Flow Control: `None`

## Sequence

A basic looped sequence for listening to incoming data and parsing messages into
data channels is demonstrated in example files linked below. For compatibility
with DAQFactory Express, the example sequence only stores 8 data channels.

If a serial data message is received but appears to be invalid (i.e. `Fit_Flag`
value is not "`3`") then an error message is displayed in the alert window.
All other errors are silently ignored.

- [Example sequence-based .CTL document](LGR_N2O_CO_sequence.ctl)
- [Contents of DAQ sequence](sequence.txt)
- [Importable channel definitions](channels.txt)

> *N.B. the sequence is part of the DAQFactory control document and any changes
> made remain exclusive to that control document. There are advantages and
> disadvantages to this approach.*

### DAQFactory Device Setup

* Quick > Device Configuration > New Serial (RS232/RS485) / Ethernet (TCP/IP) device
* Device Name: `LGR_N2O_CO` [*failure to use this device name will result in errors*]
* Serial Port > New Serial (RS232/422/485)
   * Connection Name: `LGR_N2O_CO`
   * Serial port # (COM): `1` [update to match your computer]
   * Baud: `115200`
   * Byte size: `8`
   * Parity: `None`
   * Stop bits: `1`
   * Timeout: `1000` msec
   * Flow control type: `None`
* Protocol
   * `NULL protocol`
* Channels [*channel names must match exactly or errors will occur*]
   * LGR_CO
   * LGR_CO_dry
   * LGR_N2O
   * LGR_N2O_dry
   * LGR_H2O
   * LGR_amb_T
   * LGR_cell_T
   * LGR_cell_P

### Sequence Data Variables

The following variables are parsed and stored by the example sequence. Expanding
the sequence to parse additional data from the serial message is relatively
straightforward.

| Channel Name | Description | Units |
|:-------------|:------------|:-----:|
| LGR_CO      | Carbon monoxide mixing ratio | ppb |
| LGR_CO_dry  | Carbon monoxide (dry) mixing ratio | ppb |
| LGR_N2O     | Nitrous oxide mixing ratio | ppb |
| LGR_N2O_dry | Nitrous oxide (dry) mixing ratio | ppb |
| LGR_H2O     | Water vapor | ppm |
| LGR_amb_T   | Ambient temperature | Celsius |
| LGR_cell_T  | Sampling cell temperature | Celsius |
| LGR_cell_P  | Sampling cell pressure | Torr |

## Protocol File

The user device protocol file ([`pLGR_N2O_CO.ddp`](pLGR_N2O_CO.ddp)) exposes
all available data variables. Instead of dealing with sequences and channel
names, the individual variables are exposed as device I/O Types. Users can
choose which variables to record and apply their own channel naming convention.

> *N.B. the protocol file is not stored with DAQFactory control documents and
> must be installed on each machine where the document will be opened. There
> are advantages and disadvantages to this approach.*

### I/O Types

Users can select from the following device `I/O Types` in DAQFactory. The `D#`
must be `0`. Both `Chn #` and `Timing` columns are ignored. Data acquisition rate
is controlled by the serial output rate of the analyzer.

- N2O (ppb)
- N2O (dry ppb)
- CO (ppb)
- CO (dry ppb)
- H2O (ppm)
- Cell Pressure (Torr)
- Cell Pemperature (Celsius)
- Ambient Temperature (Celsius)
- LTC0 (v)
- AIN5
- DetOff
- *Standard error (SE) values for each of the above*
- Fit flag
- Status

The additional `Status` I/O type contains device-related alerts and messages
from DAQFactory (not from the analyzer). When using the sequence-based approach
described above, these messages are displayed in the alert window instead.

### Example Document

An example control document is available [here](LGR_N2O_CO_protocol.ctl) for
testing and development purposes. It contains only 8 channels and page elements
that are suitable for opening with DAQFactory Express. Be sure to update the
device COM port value to match your system.

## Notes

1. Units for N<sub>2</sub>O & CO values are converted to parts per billion (ppb); this is
   a significant difference from data in files retrieved directly from the analyzer,
   which use parts per million (ppm).
2. Ignore the serial port documentation in the user manual - it contains errors.

Example serial port data record:

![Screenshot of example serial data record](data.png "Example serial data record")

Sample data from internal data file indicating position and units:

````
                     Time,       [CO]_ppm,    [CO]_ppm_se,      [N2O]_ppm,   [N2O]_ppm_se,      [H2O]_ppm,   [H2O]_ppm_se,   [CO_dry]_ppm,[CO_dry]_ppm_se,  [N2O_dry]_ppm,[N2O_dry]_ppm_se,      GasP_torr,   GasP_torr_se,         GasT_C,      GasT_C_se,         AmbT_C,      AmbT_C_se,         LTC0_v,      LTC0_v_se,           AIN5,        AIN5_se,         DetOff,      DetOff_se,       Fit_Flag
    07/31/20 12:05:32.661,    1.35674e-01,    0.00000e+00,    2.95422e-01,    0.00000e+00,    1.17530e+04,    0.00000e+00,    1.37288e-01,    0.00000e+00,    2.98936e-01,    0.00000e+00,    8.02193e+01,    0.00000e+00,    3.69579e+01,    0.00000e+00,    3.52880e+01,    0.00000e+00,   -1.22077e+03,    0.00000e+00,    6.53717e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:33.654,    1.35043e-01,    0.00000e+00,    2.92720e-01,    0.00000e+00,    1.15715e+04,    0.00000e+00,    1.36624e-01,    0.00000e+00,    2.96147e-01,    0.00000e+00,    8.02354e+01,    0.00000e+00,    3.69448e+01,    0.00000e+00,    3.54070e+01,    0.00000e+00,   -1.22077e+03,    0.00000e+00,    6.54770e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:34.645,    1.35083e-01,    0.00000e+00,    2.92398e-01,    0.00000e+00,    1.15099e+04,    0.00000e+00,    1.36656e-01,    0.00000e+00,    2.95802e-01,    0.00000e+00,    8.02555e+01,    0.00000e+00,    3.69351e+01,    0.00000e+00,    3.55126e+01,    0.00000e+00,   -1.22077e+03,    0.00000e+00,    6.55816e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:35.637,    1.35197e-01,    0.00000e+00,    2.92490e-01,    0.00000e+00,    1.14939e+04,    0.00000e+00,    1.36769e-01,    0.00000e+00,    2.95891e-01,    0.00000e+00,    8.02483e+01,    0.00000e+00,    3.69399e+01,    0.00000e+00,    3.54808e+01,    0.00000e+00,   -1.22078e+03,    0.00000e+00,    6.55329e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:36.627,    1.35121e-01,    0.00000e+00,    2.92368e-01,    0.00000e+00,    1.15006e+04,    0.00000e+00,    1.36693e-01,    0.00000e+00,    2.95769e-01,    0.00000e+00,    8.02462e+01,    0.00000e+00,    3.69389e+01,    0.00000e+00,    3.55006e+01,    0.00000e+00,   -1.22078e+03,    0.00000e+00,    6.55705e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:37.619,    1.35063e-01,    0.00000e+00,    2.92283e-01,    0.00000e+00,    1.15009e+04,    0.00000e+00,    1.36635e-01,    0.00000e+00,    2.95684e-01,    0.00000e+00,    8.02530e+01,    0.00000e+00,    3.69384e+01,    0.00000e+00,    3.55046e+01,    0.00000e+00,   -1.22078e+03,    0.00000e+00,    6.55650e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:38.608,    1.35092e-01,    0.00000e+00,    2.92328e-01,    0.00000e+00,    1.15176e+04,    0.00000e+00,    1.36666e-01,    0.00000e+00,    2.95734e-01,    0.00000e+00,    8.02544e+01,    0.00000e+00,    3.69386e+01,    0.00000e+00,    3.55093e+01,    0.00000e+00,   -1.22078e+03,    0.00000e+00,    6.55660e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
    07/31/20 12:05:39.604,    1.35177e-01,    0.00000e+00,    2.92461e-01,    0.00000e+00,    1.15070e+04,    0.00000e+00,    1.36751e-01,    0.00000e+00,    2.95866e-01,    0.00000e+00,    8.02364e+01,    0.00000e+00,    3.69461e+01,    0.00000e+00,    3.54253e+01,    0.00000e+00,   -1.22078e+03,    0.00000e+00,    6.54884e-01,    0.00000e+00,   -1.00000e+01,    0.00000e+00,              3
````
