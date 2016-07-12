Wiring
===
HUB75 pins
---

| 1 | 2 |
| --- | --- |
| R1 |  G1 |
| B1 | GND |
| R2 | G2 |
| B2 | GND |
| A | B |
| C | D |
| CLK | STB |
| OE | GND |


STM32F4Discovery pins

- pin STM32 Boot0 and ESP GPIO15 to first DIP 3,3V/GND
- pin VBAT to Battery + (CR2032 or CR1220)
- pin NRST to ESP GPIO2 to reset STM from ESP
- pin PA9 to 5V pin to power the STM32 from user USB port

GPIO A
0 - Latch / Button Blue
1 - RowClock
2 - RowData
3 - OE
4 - ESP SPI CS (GPIO15)
5 - CLK
6 - display custom logo when low (not used on STM32F4 Shield)
7 - DATA
8 - USB_OTG_SOF (not used)
9 - USB_OTG_VBUS
10 - USB_OTG_ID
11 - USB_OTG_DM
12 - USB_OTG_DP
13 - SWDIO
14 - SWCLK
15 - JTDI

GPIO B
3 - ESP SPI SCK (GPIO14)
4 - ESP SPI MISO (GPIO12)
5 - ESP SPI MOSI (GPIO13)
6 - USART1 TX to Max232
7 - USART1 RX to Max232
8 - ESP WIFI GPIO0
9 - ESP WIFI RESET
10 - USART3 TX WIFI
11 - USART3 RX WIFI
12 - SD CS
13 - SD SCK
14 - SD - DO
15 - SD - DI

GPIO C
6 - RGB OE
14 - RTC OSC (Go-DMD) 32,768 kHz 2 x 6,8pF
15 - RTC OSC (Go-DMD)

GPIO D
0 - R1
1 - G1
2 - B1
3 - R2
4 - G2
5 - B2
6 - RGB Clock

12 - LED GREEN
13 - LED ORANGE
14 - LED RED
15 - LED BLUE

GPIO E
2 - RGB Row A
3 - RGB Row B
4 - RGB Row C
5 - RGB Row D
6 - RGB Latch
7 - Sensor 1 (Go-DMD)
8 - Sensor 2 (Go-DMD)
9 - Sensor 3 (Go-DMD)
10 - Button 1
11 - Button 2
12 - Second DIP (not used on STM32F4 Shield)
13 - RGB Row E or GND with Jumper for 1/32 scan



