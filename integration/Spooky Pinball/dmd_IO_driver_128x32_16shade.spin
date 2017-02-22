VAR

  long parameterX                                       'to pass memory location to ASM 


PUB Launch(display_memory, DMD_cog) | g

  parameterX := display_memory                         'Make sure memory location is long-aligned
  coginit(DMD_cog, @Loader, @parameterX)                'Start cog 7 and pass the screen memory location into it.   



DAT     org                                             'New version that uses all internal COG RAM

Loader
        rdlong memstart, par                            'Get location of the beginning of screen memory

        mov enableML, #1
        rol enableML, #21
        mov rdataML, #1
        rol rdataML, #20
        mov rclockML, #1
        rol rclockML, #19
        mov clatchML, #1
        rol clatchML, #18
        mov cclockML, #1
        rol cclockML, #17
        mov cdataML, #1
        rol cdataML, #16

        mov zilch, #0                                   'Set this to a Zero
        
        or dira, cdataML                                'Set all ouput pins to OUT direction (=1)
        or dira, cclockML
        or dira, clatchML
        or dira, rclockML
        or dira, rdataML
        or dira, enableML

        mov outa, rclockML                              'Set row strobe to DISABLE (active low)
        or outa, enableML                               'Set DMD disable to ENABLE (active high) (omit this to control from SPIN)

StartPWM
        mov wait, #0
        mov pwmcount, #1                                'Reset PWM counter

DoFrame
        mov pointer, memstart                           'Set pointer to start of frames          
        mov row, #32                                    'Reset row counter

DoRow
        mov column, #64                                 'Number of bytes per row (128 pixels wide, 2 pixels per byte = 64 bytes per row)

DoColumns
        rdbyte datatemp, pointer                        'Load Datatemp with the current byte of screen data
        mov colormask, datatemp                         'Make a copy of Datatemp
        shr colormask, #4

        and colormask, pwmcount                         'If current PWM count (0-2) is less than the color value (1-3), display that color
        cmp colormask, pwmcount wc       
        muxnc outa, cdataML                              'Assert serial output bit
        cmp zilch, #0 wz                                'Latch the data onto the registers
        muxz outa, cclockML                            'Pulse dot clock
        nop
        muxnz outa, cclockML

        mov colormask, datatemp                         'Make a copy of Datatemp
        and colormask, #15                             'AND it with the top 4 bits

        and colormask, pwmcount                         'If current PWM count (0-2) is less than the color value (1-3), display that color
        cmp colormask, pwmcount wc       
        muxnc outa, cdataML                              'Assert serial output bit
        cmp zilch, #0 wz                                'Latch the data onto the registers
        muxz outa, cclockML                             'Pulse dot clock
        nop
        muxnz outa, cclockML

        add pointer, #1                                 'Increment memory pointer (4 bytes per chunk since it's long-aligned)
        djnz column, #DoColumns                         'Keep going until out of columns
 
RowEnd
        cmp zilch, #0 wz                                'Latch the data into the registers
        muxnz outa, enableML
        muxz outa, clatchML
        nop
        muxnz outa, clatchML
        muxz outa, enableML

'Bit0
        cmp pwmcount, #1 wz                            'Delay for Bit 0
        if_nz jmp #Bit1                                
        cmp zilch, #0 wz 
        muxz outa, rclockML                            'Advance the row clock
        nop
        muxnz outa, rclockML 
        jmp #Skip	                               'no additional delay = 60us

Bit1        
        cmp pwmcount, #2 wz                            'Delay for Bit 1
        if_nz jmp #Bit2                                '256 = additional 30us = 90us
        mov delay, #2                                  
        shl delay, #7
        jmp #PWM

Bit2
        cmp pwmcount, #4 wz                            'Delay for Bit 2
        if_nz jmp #Bit3                                '768 = additional 90us = 150us
        mov delay, #6                                  
        shl delay, #7
        jmp #PWM

Bit3                                                   'Delay for Bit 3
        mov delay, #17                                 '2176 = additional 255us = 315us
        shl delay, #7

PWM
        nop
        nop
        djnz delay, #PWM                               'Display higher bits longer

Skip
        shl pwmcount, #1

        sub pointer, #64

        cmp pwmCount, #16 wc                            'Did it hit 16 yet?
        if_c jmp #DoRow                                 'If not, do next color level

        add pointer, #64

        mov pwmcount, #1

        sub row, #1
        
        cmp row, #0 wz                                 'Check if we're on the first row of the display (counter starts at 32, decrementing)
        muxz outa, rdataML                              'If on row 0, z = 1, else z = 0
        
        mov delay, #32
Wait
        nop
        djnz delay, #Wait                               'Delay data start for sync

        tjnz row, #DoRow                                'Repeat until we've done all 32 rows

FrameEnd

        jmp #StartPWM      


'Set pin #'s                 Prop Pin #         DMD SIGNAL:   DMD PIN #:        Remember to also tie the DMD and Propeller's ground signals together!

enableML      res       1                            'DMD Enable   (pin 1)    
rdataML       res       1                           'Row Data     (pin 3)  
rclockML      res       1                           'Row Clock    (pin 5) 
clatchML      res       1                          'Column Latch (pin 7)  
cclockML      res       1                           'Dot Clock   (pin 9)  
cdataML       res       1                           'Serial Data (pin 11)                  

'Variables

WaitCount     res       1    
row           res       1                       'Which row we are on (0-31)
column        res       1                       'Which column we are on (0-7)
datatemp      res       1                       'Used for temp data storage and bitwise operations
memstart      res       1                       'Start of screen memory
pointer       res       1                       'Current location in screen memory
pwmcount      res       1                       'Which cycle of PWM we are on
colormask     res       1                       'Used to chop up Datatemp into grayscale levels
doublecount   res       1                       'Counter to run "Frame 3" of the PWM twice to make it more distinct
toDoPixels    res       1                       'Counts how many bits need to be shifted out of current long data position

zilch         res       1                       'The number 0. All of my salesmen are ZEROS!!!

delay          long      100
rate          long      100                       'Delay between rows for persistance