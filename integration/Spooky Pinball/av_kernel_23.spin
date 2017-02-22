{
PINHECK SYSTEM - Parallax Propeller Audio / DMD System Driver
2009-2015 Benjamin J Heckendorn
www.benheck.com
}
CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 6_500_000     
  '_xinfreq = 5_000_000

AVversion         =              23                      'October 2015                  

'------------------------------------Propeller Cog Usage---------------------------------------Langauge---------
                                '(0) Setup / Interpreter                                        (SPIN)
                                '1 FREE COG
                                '2 FREE COG
sd0_Cog         = 3             'SD File System for SFX                                         (ML)
audioDACCog     = 4             'Machine language DAC Audio Player                              (ML)
Graphic_Cog     = 5             'Runs video, score display, etc                                 (SPIN)
Raster_Cog      = 6             'DMD shift register PWM driver                                  (ML) 
Comm_Cog        = 7             'Get commands from PIC32                                        (ML)  


eepromBus       =               $A0                     'Where the Propeller's EEPROM is on the I2C bus
eepromBase      =               $8000                   'Where free EEPROM starts (32k)

ACK      = 0                        ' I2C Acknowledge
NAK      = 1                        ' I2C No Acknowledge
Xmit     = 0                        ' I2C Direction Transmit
Recv     = 1                        ' I2C Direction Receive
BootPin  = 28                       ' I2C Boot EEPROM SCL Pin
EEPROM   = $A0                      ' I2C EEPROM Device Address

atnSpin = 24
clkSpin = 25
datSpin = 26

commBuffSize = 512                                      'Size of the command buffer (32 commands)
status_LED  =  27                                       'Where the blinky LED is. Very important!

volumeMultiplier = 10                                   'How much to reduce audio volume for each additional track playing concurrently

'Video Attribute Bits:

loopVideo       =               %1000_0000              'Should video start over after it ends?
preventRestart  =               %0100_0000              'If video called is already playing, don't restart it (just let it keep playing)
noEntryFlush    =               %0010_0000              'Do not flush graphics on video start (for instance, to have a number appear on an enqueued video)
noExitFlush     =               %0001_0000              'Do not flush graphics on video end
allowSmall      =               %0000_0001              'Can show small numbers on the video? 
allowLarge      =               %0000_0010              'Can show large numbers on the video?
allowBar        =               %0000_0100              'Can show a Progress Bar?
manualStep      =               %0000_1000              'Video loads first frame, but requires manual advancement

'graphicAtt Attribute Bits:

returnPixels    =               %0010_0000              'Before drawing this character, place the existing left and rightmost pixels in the Outbuffer data return buffer
numberStay   =                  %0001_0000              'If we see this bit on a Numbers command, we make the incoming number a Timers number
totalNumbersAllowed = 12                                'Total number of numbers allowed (includes Timer) Setting as 8 means 7 normal numbers (0 - 6) + the timer (7)

'Graphic Command Bits:

clearScreen     =               %1000_0000              'Allows the PIC32 to take command of screen drawing routines
loadScreen      =               %0100_0000



VAR     'Display buffer data, SD card read buffer data, audio buffers
 
  long audioBuffer[1280]                                '1K buffer per stereo channel
  byte bufferD[4096]                                    'Lower 2K is frame buffer, upper 2K is what is put on display 
  byte dataBlock0[512]                                  'For reading sectors off SD card
  byte font[2048]
  
  byte numberLarge[1280]                                'RAM that holds the large numerals for fast access
  byte numberMedium[704]                                'RAM that holds the medium numerals for fast access 
  byte numberSmall[120]                                 'RAM that holds the small numerals for fast access 

  long CogstackV[128]                                   'Stack for launching a video cog. Keep it high!     



VAR

   'Command Receive Buffer Variables

  byte outBuffer[16]                                  '16 bytes we can shift back out the PIC32 during a command transition   
  byte command[commBuffSize]                          '32 (16 byte long) commands that are coming in from the PIC32
  word Pointer                                        'What command line SPIN is currently looking at
    
  long eepromAddress                                  'Address of where we are reading on the EEPROM
  long eepromData                                     'Data to be written to, or read from, the EEPROM

  byte dataReadyFlag                                  'When data is ready on the outBuffer to be sent back to PIC32
  

VAR                             'SD Card Variables for DMD use

  long card1DirectorySector     'Root directory of SD card (holds folders and the TXT file listing of entries)  
  long folderSector1[26]         'Starting sector # for each folder's directory _DA - _DZ on SD card 1 (DMD)
  long currentDirectorySector1  'Which sector of the directory we're currently searching
  long DMDStartingSector        'Starting sector of the current file  
  long DMDCurrentSector         'Current read sector of a DMD file
  byte DMDSearch                'Flag (1 or 0) to indicate if we're looking for a DMD video. Allows us to preserve DMDToFind[x] variables for Video Looping
  byte DMDToFind[5]             'Includes file name and allowNumbers and progressBar parameters
  word DMDtotalFrames
  word DMDcurrentFrame
  byte DMDcyclesPerFrame
  long DMDframeTimer            'Uses the system timer to determine when to load a new frame
  long targetAddress            'Where the SD card loop should store the DMD sector it's loading
  byte requestSector            'Flag for the DMD loop to request a frame from the SD card


VAR

  long folderSector0[26]                                'Starting sector # for each folder's directory _FA - _FZ on SD card 0 (Audio)
  long currentDirectorySector0[4]                       'Which sector of the directory we're currently searching (could possibly be searching for all 4 channels at once)
  long card0DirectorySector
  word sfxToFind[4]                                     'Which file we're looking for. We already know the folder, so we only need the 2nd and 3rd characters
  
  byte leftCurrentV[4]
  byte rightCurrentV[4]
  byte leftDefaultV[4]
  byte rightDefaultV[4]
  
  byte sfxPriority[4]                                 'Priority level of sound currently playing on that channel
  byte nextPriority[4]                                  'If we find and load the file, set its priority to this
  long sfxSamples[4]                                    'How many samples to play                 
  long sfxSector[4]                                     'Which sector the SFX is currently playing from
  byte sfxStereoSFX[4]                                  'Stereo FX override for that channel?
  byte sort[4]
  byte order[4]

  byte musicRepeat                                      '1 = Music repeats when file's done 0 = Music ends when file's done  
  byte musicOneShot                                     'Flag if we should resume previous playing music or not
  byte currentMusic[2]                                  '0,1 what IS playing, 2,3 what WAS playing
  word fadeSpeed                
  word fadeTimer
  byte musicVolumeTarget                                'The target volume of a fade command

  long lastMusicSamples                                 'How many samples were left when a file interrupted us 
  long lastMusicSector                                  'What music sector we were on when a file interrupted us    



VAR                   'DMD & Game Indicator Variables

  long PlayerScore[8]                                   'The 4 player's scores. We use 1-4 for players. Position 0, 5, 6 and 7 can be used to store jackpots, values, etc.
  byte CurrentPlayer                                    'Which player is up
  byte NumberPlayers                                    'How many player game it is (1-4)
  byte Ball                                             'Which ball we are one
  byte credits                                          'How many credits we have. MSB is Freeplay (1) or Not (0)
  byte creditDot                                        'Set flag if PIC32 reports that game has an issue
  long highScores[6]                                    'Stores the top 6 scores
  byte topPlayers[24]                                   'Stores 6 sets of 3 letter initials

  byte nextVid[12]                                       'The next video that plays once current one finishes
  byte nextSound[10]                                     'The next sound to play
  byte syncNext                                         'Flag that says the enqueued video and sound should start together

  byte VidPriority                                      'The priority of the running mode. New mode must be equal or greater to be shown. Score mode is always ZERO. 
  byte videoAtt                                         'Attributes of currently playing video
  byte videoStep                                        'Flag to advance video
 
  byte drawingFrame                                     'Flag that a frame is being drawn


  byte lastScoresFlag                                   'If the last game's scores should be shown in Attract Mode
  byte attractMode                                      'Which part of Attract Mode we're in
  byte mode                                             'What mode the display is in
                                                        '1 = Score Display. Set to 255 within a routine to force Score Display.
                                                        '2 = Progress Display

  byte replayFlag                                       'Flag for system to play REPLAY sound once everything else has finished
  byte futzNumbers                                      'futzNumbers                                                      
  byte doubleZero                                       'Universal flag. If 1, numbers displayed as double zeros (scores) else, single zero (anything else)                        

  long numberFXtimer                                    'Overall timer for number FX (right now we just have "blink" - lame!
  long frameTimer
  
  'You can add up to ([totalNumbersAllowed] numbers on a video. Certain numbers can stay active during a score display as well

  byte graphicType[totalNumbersAllowed]                 'What type of graphic this is
                                                        '00 - No graphics
                                                        '01 - Numbers Command
                                                        '02 - Sprite Command
                                                        
  byte graphicAtt[totalNumbersAllowed]                  'Flag to place numbers on still frames or video  
                                                        '0 = None (off)
                                                        '1 = Large number, XY position
                                                        '2 = Small number, XY position
                                                        '3 = (2) small numbers, upper left and right corners
                                                        '4 = (2) small numbers, lower left and right corners
                                                        '5 = (4) small numbers, all four corners
                                                        '6 = (1) small number, allow double zeros (such as a score)
                                                        '7 = Show a large number after current video finishes
                                                        '8 = Show all 4 fours scores on right side of screen for Match animation
  byte graphicX[totalNumbersAllowed]                    'Position of the number
  byte graphicY[totalNumbersAllowed]                    'Position of the number  
  long graphicValue[totalNumbersAllowed]                'A number to place on stills or video for countdown timers, score bonus, etc. Clear flag when it's done.
  byte graphicPriMatch[totalNumbersAllowed]             'Set a priority for the number. If current video is playing, and does not match this number, number will not display

  byte timerNumberActive                                'If permanent # is found, alert the Score Display so it can accomodate
  long numberFlash                                      'What number value to flash
  word numberFlashTimer                                 'How long to flash it before reverting to Mode 255

  byte numberString[14]                                 'Converts numbers into strings
  long EOBnum[6]                                        'Used to display End of Ball bonus amounts
  byte scoreVideo[4]                                    'What video to run to build a Customized Score, including its Attribute Byte   
  byte switchDisplay[10]                                'For viewing the switch matrix + cab switches

  
'Variables for Initial Entry Display

  byte cursorPos                                        'Where the cursor is 0 1 or 2
  byte startChar                                        'The first character on the screen
  byte entryChar[3]                                     'The characters we've entered on the display
  byte playerInitial                                    'Which Player # we are entering initials for
  byte playerPlace                                      'Which place the player entering their name got


  long CogstackS[50]                                   'Stack for launching a video cog. Keep it high!     

  word avWatchDoge
  word intWatchDoge
  

OBJ

  sd0           :               "SD_Engine_0"                             'SD Card Reader 0 (AUDIO)
  dmd           :               "dmd_IO_driver_128x32_16shade"            'DMD driver
  audio         :               "roy_DAC_4"                               'NEW DAC engine for Audio

  serial        :               "FullDuplexSerial"    

PUB AVKernel | g

{-------------- Start ML I/O communication routine ------------------------}  

  eepromData := @outBuffer                                                      'Pass buffer address to ML so it can fill it (use a random LONG to pass the value to save RAM!)
  coginit(Comm_Cog, @IOSetup, @eepromData)                                      'Start command processor, ready to rock!
  'Pointer := 0                                                                  'Set command pointer to start and wait for command                                        

{------------------------ Start DMD ---------------------------------------}  

  dmd.Launch(@bufferD[0] + 2048, Raster_Cog)
  Mode := 10                                                                    'Don't do anything until we get the all-clear from SD cards, and the PIC32 sends a command to change mode
 
{------------- Start Audio SD Card & DAC Drivers --------------------------}  

  sd0.sdStart(0, 1, 2, 3, -1, -1, sd0_Cog, @dataBlock0)
  'sd0.sdStart(4, 5, 6, 7, -1, -1, sd0_Cog, @dataBlock0)    
  sd0.mountPartition
  card0DirectorySector := sd0.GetRootDirectory   

  Blink(2, 50)

  audio.DACEngineStart(@audioBuffer, 14, 15, 22050, audioDACCog)

  setVolume(0, 80, 80)
  setVolume(1, 80, 80)
  setVolume(2, 80, 80)
  setVolume(3, 35, 35)


{----------------- Begin Main Loop ---------------------------------------}  

  I2Cinitialize

  BuildFolderList0                                      'Get the starting sectors for the directory entries on SD card 0 for audio
  BuildFolderList1
  LoadNumbers                                           'Load bitmap fonts from SD card into RAM

  if PlayerScore[1]                                     'Did BuildFolderList1 find a newer HEX file in the DMD folder? (uses PlayerScore[1] as a temp)

    flashEEPROM                                         'Flash the EEPROM!

  showVersions                                          'Splash screen of version #'s

  coginit(Graphic_Cog, DMDLoop, @CogStackV)             'We're done with manual file loading, so start DMD command loop (video, scores, etc)
  
  'Setting mode to anything other than 10 will get the party started!
  
  'Mode := 0
  attractMode := 1
  musicRepeat := 1
  
  serial.Start(31, 30, %0000, 57_600)                    'requires 1 cog for operation 

  cognew(WatchDoge, @CogstackS)             'We're done with manual file loading, so start DMD command loop (video, scores, etc)
   
  repeat

    intWatchDoge := 0
  
    if command[pointer + 15]                                                                            'A command has filled a line of the buffer with Op Code at end?
      Interpret
      LineDone

    if DMDsearch                                                                                        'Searching for a DMD file?
    
      FindDMDEntry                                                                                      'Keep searching directory for it. Don't do ANYTHING else!

    if requestSector                                                                                    'DMD wants a sector?

      DMDCurrentSector := sd0.readSector(DMDCurrentSector, targetAddress, requestSector)                'Copy frame from SD card to buffer memory

      requestSector := 0                               

    repeat g from 0 to 3                                                                                'Cycle through the 4 audio SFX channels
  
      if sfxToFind[g]                                                                                   'Doing a search on that channel?
        FindSFXEntry(g)  

      if sfxSamples[g] > 0
       
        if (audioBuffer[(g << 8) + 127] == 0)                                                           'First half just about empty?

          sfxSector[g] := sd0.readSector(sfxSector[g], @audioBuffer[g << 8], 1)                         'Fill it!
          sfxSamples[g] -= 128
          if sfxSamples[g] < 1000
            finishSFX(g, 1)
       
        if (audioBuffer[(g << 8) + 255] == 0)                                                           'Second half just about empty?
     
          sfxSector[g] := sd0.readSector(sfxSector[g], @audioBuffer[(g << 8) + 128], 1)                   'Fill it!
          sfxSamples[g] -= 128
          if sfxSamples[g] < 1000
            finishSFX(g, 1)

    if fadeSpeed                                                                'Music fade enabled? 

      fadeTimer -= 1                                                            'Decrement timer     

      if fadeTimer < 1                                                          'Timer done?
      
        fadeTimer := fadeSpeed                                                  'Reset timer

        if leftCurrentV[3] > musicVolumeTarget                                      'Move towards target
          leftCurrentV[3] -= 1
          rightCurrentV[3] -= 1

        if leftCurrentV[3] < musicVolumeTarget
          leftCurrentV[3] += 1
          rightCurrentV[3] += 1

        audio.Volume(3, leftCurrentV[3], rightCurrentV[3])                      'Set current volume
        
        if leftCurrentV[3] == musicVolumeTarget                                 'Did we reach the target?
          fadeSpeed := 0                                                        'Stop fade routine
          if musicVolumeTarget == 0                                             'Was it a fade out?
             musicOneShot := 0
             finishSFX(3, 0)                                                    'Terminate music player


PUB WatchDoge | g

  Pause(2000)                                           'Wait a bit

  repeat

    serial.Str(STRING("WD0:"))
    serial.Dec(avWatchDoge)
    serial.Tx(9)

    serial.Str(STRING("WD1:"))
    serial.Dec(intWatchDoge)
    serial.Tx(9)
  
    serial.Str(STRING("AT:"))
    serial.Dec(AttractMode)
    serial.Tx(9)
    
    serial.Str(STRING("GR:"))
    serial.Dec(Mode)
    serial.Tx(9)
        
    serial.Str(STRING("D:"))
    serial.Dec(DMDCurrentSector)
    serial.Tx(9)
    
    serial.Str(STRING("A0:"))
    serial.Dec(sfxSector[0])
    serial.Tx(9)
    
    serial.Str(STRING("A1:"))
    serial.Dec(sfxSector[1])
    serial.Tx(9)
    
    serial.Str(STRING("A2:"))
    serial.Dec(sfxSector[2])
    serial.Tx(9)
    
    serial.Str(STRING("A3:"))
    serial.Dec(sfxSector[3])
    
    serial.Str(STRING("/"))
    serial.Dec(fadeSpeed) 
               
    serial.Tx($0D)

    avWatchDoge += 1

    if avWatchDoge == 25

      coginit(Graphic_Cog, DMDLoop, @CogStackV)          'We're done with manual file loading, so start DMD command loop (video, scores, etc)   
   
    intWatchDoge += 1

    if intWatchDoge == 25

      reboot
  
    Pause(50)                                           '20 updates a second


      

PUB Interpret | g, xPos, yPos

 'Look at the opcode, and do what it says!
 
  case command[pointer + 15]

    $01 : 'Play an SFX file?

      if command[pointer + 0] == 3                                                                                              'Channel 3 Music file? Special conditions apply

        if currentMusic[0] == (command[pointer + 2] & %0111_1111) and currentMusic[1] == command[pointer + 3]                   'Don't restart a music file that's already playing (or is paused via one-shot)
          return

        if command[pointer + 2] & %1000_0000                                                                                    'One Shot bit enabled?

          if sfxSamples[3]                                                                                                      'Only set one-shot if music actually playing (probably is, but you never know)
             lastMusicSamples := sfxSamples[3]                                                                                  'Store how many samples were left when a file interrupted us 
             lastMusicSector := sfxSector[3]                                                                                    'Store what music sector we were on when a file interrupted us
             musicOneShot := 1                                                                                                  'Set flag
             
        else                                                                                                                    'If we got music command, and bit NOT set, kill the flag

          musicOneShot := 0                                                                                                     'So if new music, it will override one-shot and play. Paused music won't resume

      playSFX(command[pointer + 0], command[pointer + 1], command[pointer + 2] & %0111_1111, command[pointer + 3], command[pointer + 4])     'Run the sound!

    $02 : 'Play a video file?   

      EOBnum[5] := 0                                                                                                            'Allows us to skip drain animation and not wreck Match animation
   
      if command[pointer] == 0 and (Mode == 3 or Mode == 5)                                                                     'Send a "0" as the first character in a video command to STOP VIDEO or Priority Command
 
        stopVideo
        return

      if command[pointer] == 255                                                                                                'Video Priority manual override? (usually to 0)
        VidPriority := command[pointer + 5]                                                                                     'Set new priority, and return
        return
        
      if command[pointer + 5] => VidPriority                                                                                    'Make sure video has priority control before we let it change anything 

        if videoAtt & preventRestart                                                                                           'Prevent this video from restarting?

          if command[pointer + 0] == DMDToFind[0] and command[pointer + 1] == DMDToFind[1] and command[pointer + 2] == DMDToFind[2] 

             return                                                                                                                'Abort                   

        if numberFlash
          numberFlash := 0

        if (videoAtt & noExitFlush) and (nextVid[3] & noEntryFlush)         'Current video has noExitFlush, and a queued video has noEntryFlush? Must be a number waiting!
   
          command[pointer + 3] |= %0011_0000                                'Make sure this video popping in doesn't flush at either end!
       
        playVideo(command[pointer + 0], command[pointer + 1], command[pointer + 2], command[pointer + 3], command[pointer + 4], command[pointer + 5], 3)
    
    $03 : 'Update a player's score? (typically used for adding)
           
      PlayerScore[command[pointer + 0]] := (command[pointer + 4] << 24) + (command[pointer + 3] << 16) + (command[pointer + 2] << 8) + command[pointer + 1]

    $04 : 'Show a graphic onscreen

      'serial.Str(STRING("Graphic Command!"))
    
      if command[pointer + 1] == 255                                                                                            'Command to kill graphics?

        GraphicFlush(0, 7)                                                                                                      'Kill ALL ze numbers!

        return                                                                                                                  'Don't do the other stuff

      if command[pointer + 1] == 254                                                                                            'Command to kill score graphics?

        GraphicFlush(8, 11)                                                                                                     'Kill ALL ze numbers!

        return                                                                                                                  'Don't do anything else

      if command[pointer + 2] == 0                                                                                              'Command to kill graphics? (LEGACY COMPATIBLE)

        GraphicFlush(0, 7)


      case command[pointer + 0]                                                                                                 'What to do based off Graphic Type

        1 : 'A number graphic? command[pointer + 2] is which graphic # have been chosen. Wisely. 

          if command[pointer + 2] == numberStay                                                                                  'Manual termination of a Timer Number? (send just the bit no number type)
            graphicType[command[pointer + 1]]  := 0
            return 
           
          if command[pointer + 1] > totalNumbersAllowed - 1                                                                         'Invalid graphic #?
           
            return

          graphicPriMatch[command[pointer + 1]] := command[pointer + 9]         'Late feature add. Assigns a priority - if number priority matches video priority then it is drawn. 0 = Don't Care.
           
          graphicType[command[pointer + 1]] := 1                                                                                    'Set this graphic type as Number      
          graphicAtt[command[pointer + 1]]  := command[pointer + 2]
          graphicX[command[pointer + 1]]  := command[pointer + 3]
          graphicY[command[pointer + 1]]  := command[pointer + 4]
          graphicValue[command[pointer + 1]] := (command[pointer + 8] << 24) + (command[pointer + 7] << 16) + (command[pointer + 6] << 8) + command[pointer + 5]

        2 : 'A Progress graphic bar?

          graphicType[command[pointer + 1]] := 2                                                                                    'Set this graphic type as Number      
          graphicAtt[command[pointer + 1]]  := command[pointer + 2]
          graphicX[command[pointer + 1]]  := command[pointer + 3]
          graphicY[command[pointer + 1]]  := command[pointer + 4]
          graphicValue[command[pointer + 1]] := (command[pointer + 8] << 24) + (command[pointer + 7] << 16) + (command[pointer + 6] << 8) + command[pointer + 5]

        3 : 'A Character Sprite?

          graphicType[command[pointer + 1]] := 3                                                                                    'Set this graphic type as Number      
          graphicAtt[command[pointer + 1]]  := command[pointer + 2]
          graphicX[command[pointer + 1]]  := command[pointer + 3]
          graphicY[command[pointer + 1]]  := command[pointer + 4]
          graphicValue[command[pointer + 1]] := (command[pointer + 8] << 24) + (command[pointer + 7] << 16) + (command[pointer + 6] << 8) + command[pointer + 5]

    $05 : 'Control a video file?

      case command[pointer + 0]                                                                                                 'What to do based off Graphic Type

        6 : 'Step forwaard one frame?

          videoStep := 1                                                        'Set flag to advance 1
 

    $06 : 'Enqueue a video to play after current one finishes

      g := 0                                                                    'Pointer of where we'll put this enqueued video
    
      if nextVid[5]                                                             'Already a video enqueued?
        g := 6                                                                  'Set pointer to the Second Enqueued video spot.

      if command[pointer] == 0 and command[pointer + 5] == 0                    'If this is actually a KILL Q command (all zeros, like my salesmen)
        syncNext := 0
        byteFill(@nextVid[0], 0, 12)                                            'Wipe out both video queues
        byteFill(@nextSound[0], 0, 5)
        return   

      byteMove(@nextVid[g], @command[pointer], 6)                               'Copy it over to Next Video


      if command[pointer + 10]                                                  'More than 6 bytes, meaning it's a VideoQ + AudioQ command?

        byteMove(@nextSound[0], @command[pointer + 6], 5)                       'Copy the sound filename     
        syncNext := 1                                                           'Set flag that we need to sync the next Video and Audio together

    $07 : 'Make a large number flash after video ends

      numberFlash := (command[pointer + 3] << 24) + (command[pointer + 2] << 16) + (command[pointer + 1] << 8) + (command[pointer + 0])
      numberFlashTimer := command[pointer + 4]

      if numberFlashTimer == 0                          'Old setting?
        numberFlashTimer := 40                          'This is a good default amount (slightly over 2 seconds)

    $08 : 'Play a SFX file after current one finishes?

      byteMove(@nextSound[0], @command[pointer], 5)
 
    $0B : 'Set one of the numbers that should be auto-inserted during End of Ball

      EOBnum[command[pointer + 0]] := (command[pointer + 4] << 24) + (command[pointer + 3] << 16) + (command[pointer + 2] << 8) + (command[pointer + 1])       'Load the bonus amount into variable position 
      EOBnum[5] := 255                                                              'Flag that tells video to insert these numbers by frame automatically.
 
    $0C : 'Set current player #, ball #, total players, free play

      CurrentPlayer := command[pointer + 0]
      Ball := command[pointer + 1]
      NumberPlayers := command[pointer + 2]
      credits := command[pointer + 3]

      lastScoresFlag := command[pointer + 5]
      creditDot := command[pointer + 6] 
   
      if command[pointer + 4] == 255                    'Set replay flag?
        replayFlag := 1
        return                                          'Abort so Attract Mode doesn't start
      
      if command[pointer + 4] > 0
                                       
        attractMode := command[pointer + 4]
        
        clearQueue
        replayFlag := 0
        frameTimer := 0                                 'Immediate jump to whatever is next
        
      else
      
        attractMode := 0
        frameTimer := 0

      return

    $0D : 'Play a single sound effect with stereo override?

      sfxStereoSFX[command[pointer + 0]] := 1                                                           'Set stereo FX flag

      setVolumeCurrent(command[pointer + 0], command[pointer + 5], command[pointer + 6])
       
      playSFX(command[pointer + 0], command[pointer + 1], command[pointer + 2], command[pointer + 3], command[pointer + 4])

    $0E : 'Get high scores from main CPU so they can be displayed during attract mode

      highScores[command[pointer + 0]] := (command[pointer + 4] << 24) + (command[pointer + 3] << 16) + (command[pointer + 2] << 8) + (command[pointer + 1])                    'Get the score
      topPlayers[(command[pointer + 0] * 3) + 0] := command[pointer + 5]        'Get the initials in ASCII (we use @ as a blank)
      topPlayers[(command[pointer + 0] * 3) + 1] := command[pointer + 6]       
      topPlayers[(command[pointer + 0] * 3) + 2] := command[pointer + 7] 

    $0F : 'Enter Initials Screen

      'if command[pointer + 0] > 0 and command[pointer + 0] < 10                                               'Setting initials?
            
      playerInitial := command[pointer + 0]                                                    'Which player we're entering for
      cursorPos := command[pointer + 1]                                                        'Which position the cursor is at
      startChar := command[pointer + 2]                                                        'Which character is on the cursor
      entryChar[0] := command[pointer + 3]                                                     'The 3 characters you've entered
      entryChar[1] := command[pointer + 4]
      entryChar[2] := command[pointer + 5]
      playerPlace := command[pointer + 6]

    $10 : 'Volume control command for SFX and Music. Contains sub command for fading music in and out

      if command[pointer + 0] == "f"                                            'Change SFX volume? (f)
        setVolume(command[pointer + 1], command[pointer + 2], command[pointer + 3])                        'Store new default values 

      if command[pointer + 0] == "r"                                            'Set Repeat or End?
        if command[pointer + 1]                                                 'If a 1 was sent, that means Repeat Music (the default)
          musicRepeat := 1
        else
          musicRepeat := 0

      if command[pointer + 0] == "z"                                            'Fade out music?

        if sfxSamples[3] == 0                                                   'Music not playing? Abort.
          return

        if command[pointer + 1] == 0                                            'Just up and kill the music?
          finishSFX(3, 0)
          return

        fadeSpeed := command[pointer + 1] << 8                                  'Enable fadeSpeed, which also acts as the active flag for fading. We do a +1 so you can enter a 0 for instant-fade!
        musicVolumeTarget := command[pointer + 2]                               'What we're fading to 

        if musicVolumeTarget > 100
          musicVolumeTarget := 100

        if fadeSpeed > 2550                                                     '10 seconds * 255 cycles. No fade needs to be longer than 10 seconds!
          fadeSpeed := 2550
        
        fadeTimer := fadeSpeed                                                  'Rougly "fadeSpeed" seconds for the fadeout   
 
    $11 : 'Enable/disable custom score display?

      byteMove(@scoreVideo[0], @command[pointer], 4)                            'Copy the video name and attribute byte. We use scoreVideo[0] as an enable flag 
 
    $12 : 'Put a string of text on the screen?

      g := 1

      xPos := (command[pointer + 0] >> 4) << 3                                         'First BCD is X
      yPos := (command[pointer + 0] & %00001111) << 3                                  'Second BCD is Y
      
      repeat while command[pointer + g] > 0 and command[pointer + g] < 255       'Will terminate either with a 0 (string terminator) or 255 (end of command line)

        LoadAlpha(command[pointer + g++], xPos, yPos, 8)
        xPos += 8

        if xPos > 127
          xPos := 0
          yPos += 8
          if yPos > 31
             quit

    $13 : 'A graphics command?

      Mode := command[pointer + 0]
      frameTimer := 0
      
      repeat while drawingFrame                                               'Don't abort yet if system is drawing a frame 
      
      if command[pointer + 1] == clearScreen

        Clear

      if command[pointer + 1] == loadScreen

        Load       

    $14 : 'Load a sprite into memory, manually?

      '3 character filename, plus flag if a LOAD command should execute afterwards

      repeat while drawingFrame                                               'Don't abort yet if system is drawing a frame 

      loadSprite(command[pointer + 0], command[pointer + 1], command[pointer + 2], command[pointer + 3])

 
    $15 : 'Get switch matrix, draw it onscreen

      byteMove(@switchDisplay[0], @command[pointer], 10)                      'Copy switches into memory 

      drawSwitches

    $20 : 'Write a long to EEPROM?

      'The PIC32 can access longs 0 - 8191. We take the address from the PIC32, multiply by 4, and add the base address past the BOOT EEPROM

      byteFill(@outBuffer[0], 0, 16)                                       'Clear the buffer    
       
      eepromAddress := (command[pointer + 3] << 24) + (command[pointer + 2] << 16) + (command[pointer + 1] << 8) + command[pointer + 0]
      'eepromAddress := (eepromAddress << 2) + eepromBase
      eepromData := (command[pointer + 7] << 24) + (command[pointer + 6] << 16) + (command[pointer + 5] << 8) + command[pointer + 4] 

      writeLong($A0, eepromAddress, eepromData)

      outBuffer[15] := $42
      

    $21 : 'Read a long from EEPROM?

      eepromAddress := (command[pointer + 3] << 24) + (command[pointer + 2] << 16) + (command[pointer + 1] << 8) + command[pointer + 0]                 'Get 0-8191
      'eepromAddress := (eepromAddress << 2) + eepromBase                                                                                                'Convert
      eepromData := readLong($A0, eepromAddress)     

      byteFill(@outBuffer[0], 0, 16)                                       'Clear the buffer    
 
      outBuffer[0] := eepromData                                            'First 4 bytes are the requested long
      outBuffer[1] := eepromData >> 8
      outBuffer[2] := eepromData >> 16
      outBuffer[3] := eepromData >> 24
      outBuffer[14] := command[pointer + 14] + %1000_0000                   'Send the checksum back with the MSB set
      outBuffer[15] := $AD                                                  'Return Frame end data 


    $22 : 'Flush return data buffer?

      byteFill(@outBuffer[0], 0, 16)                                       'Clear the buffer    





PUB LineDone
   
  bytefill(@command[0] + pointer, 0, 16)                                        'Erase this line of the buffer
   
  pointer += 16                                                                 'Increment pointer
  if pointer == commBuffSize                                                    'Reached the top?
    pointer := 0                                                                'Reset


PUB DMDLoop | g                                             'This runs in its own cog. Controls what goes on the DMD display, streams video, does text
  
  repeat

    avWatchDoge := 0                                    'Set to 0 to say we're still alive. Are you still there?

    if DMDsearch == 0                                        'Not searching for a DMD file?

      numberFXtimer -= 1
       
      if numberFXtimer < 0
        numberFXtimer := 50
       
      case Mode                                           'Figure out what we should be doing
       
        0 :                                               'Nothing going on? Then draw the default score or goto Attract Mode
       
          if attractMode
          
            AttractSettings
            
          else
              
            Score
       
        3 :                                                 'A video is playing?
       
          if videoAtt & manualStep
            Mode := videoStepStream                         'Load frames by request
       
          else
            Mode := videoStream                             'Load more frames 
       
        4 :
        
          showHighScore(attractMode - 3)
       
        5 :
        
          showLastScores
       
        8 :                                               'Custom score display, with video?
       
          videoStream
        
        9 :                                               'Flash a value after video finishes, and before resuming score?
        
          showNumberFlash
        
        255 :                                             'A video just ended itself?
           
            if attractMode                                  'Advance attract mode
            
              attractMode += 1
              
              if attractMode == 9 or attractMode > 16    'Loop attract mode
                attractMode := 1     
       
              Mode := 0                                   'Set to 0 so Attract Mode will do something                    
       
            if nextVid[5]                                                                                          'A video is waiting?
         
              if syncNext == 0                                                                              'Not a A/V sync, just a video?
              
                 playVideo(nextVid[0], nextVid[1], nextVid[2], nextVid[3], nextVid[4], nextVid[5], 3)          'Run it like normal
       
                 byteFill(@nextVid[0], 0, 6)                                                              'Erase the enqueued video  
                 
                 if nextVid[11]                                                                           'BUT if there's another video in the secondary queue...
       
                    byteMove(@nextVid[0], @nextVid[6], 6)                                                 'Copy the second enqueued video into the next enqueued video spot
                    byteFill(@nextVid[6], 0, 6)                                                           'and clear out the secondary queue
       
              else                                                                                        'Play audio and video together? syncNext = 1
              
                 if sfxSamples[nextSound[0]] == 0                                                            'The SFX channel the queue wants to use is clear?
                    playVideo(nextVid[0], nextVid[1], nextVid[2], nextVid[3], nextVid[4], nextVid[5], 3)         'Run video
                    playSFX(nextSound[0], nextSound[1], nextSound[2], nextSound[3], nextSound[4])           'Run audio                   
                    syncNext := 0                                                                           'Clear flags
                    
                    byteFill(@nextVid[0], 0, 6)                                                              'Erase the enqueued video  
                 
                    if nextVid[11]                                                                           'BUT if there's another video in the secondary queue...
                 
                       byteMove(@nextVid[0], @nextVid[6], 6)                                                 'Copy the second enqueued video into the next enqueued video spot
                       byteFill(@nextVid[6], 0, 6)                                                           'and clear out the secondary queue
                    
                    byteFill(@nextSound[0], 0, 5)                                                           'Erase the SFX queue                
         
                 else                                                                                       'A sound is still playing?
                 
                    syncNext := 10                                                                          'Set flag that when channel finishes, the A/V sync will be started
                    Mode := 0                                                                               'Allow DMD to show default score display until then    
       
            else
       
               if numberFlash                             'Flash a value after video ends?
               
                  Mode := 9
                  
               else

                  if replayFlag
                     replayFlag := 0                    'Clear flag
                     if attractMode == 0                'Only show Replay if a game is active
                        playVideo("SRP", 0, 0, 255, 3)     'Run video
                        playSFX(0, "AXZ", 255)             'Run audio
                      
                  else   

               
                                if scoreVideo[0]                          'Run a video + numbers to show a customized score?
                 
                                   playVideo(scoreVideo[0], scoreVideo[1], scoreVideo[2], scoreVideo[3] | loopVideo, 0, 0, 8)  'Run Score Custom Video with attribute bits set but priority 0 (anything can override)
                                 
                                else
                                 
                                   Mode := 0                               'Display scores or attract mode          
       
    

PUB FindDMDEntry | startingSector, offset               'This runs during the kernel to find the specified DMD file

  startingSector := 0

  bufferClear

  sd0.readSector(currentDirectorySector0[3], @dataBlock0, 1)                                            'Read in a sector of the directory. Contains 16 filenames

  repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block

    if dataBlock0[0] == 0                                                                               'Empty entry?
      'serial.Str(STRING("ERROR: FILE NOT FOUND"))
      'serial.Tx(13)
      DMDsearch := 0                                                                                     'Stop our search for this DMD

    if dataBlock0[offset + 1] == DMDToFind[1] and dataBlock0[offset + 2] == DMDToFind[2] 
      DMDtotalFrames := blockToLong0(offset + 28) >> 9                                                  'Get the number of sectors (File size / 512)
      DMDtotalFrames -= 1                                                                               'Remove dummy sector from count...
      DMDtotalFrames >>= 2                                                                               '2 bit = 2 sectors per frame. 4 bit = 4 sectors per frame
      startingSector := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector + 1

      'serial.Str(STRING("... done!"))
      'serial.Tx(13)
           
      quit                                                                                              'Loop complete. Don't even bother finishing to scan this sector

  if startingSector == 0                                                                                'Didn't find it in the 16 entries?  
    currentDirectorySector0[3] += 1                                                                     'Advance to next directory sector
    return                                                                                              'Return that we haven't found it yet
  
  videoAtt := DMDToFind[3]                                                                               'Set new attributes
 
  VidPriority := DMDToFind[4]                                                                           'This is our new priority   

  DMDStartingSector := startingSector                                                                   'If video loops, we can immediately start it again (no file search)
  DMDCurrentSector := startingSector
 
  DMDcurrentFrame := 1                                                                                  'Need this for the End of Ball numbers display

  Mode := DMDsearch             '3                                                                                             'Set Video Mode active 
  
  DMDsearch := 0                                                                                        'Clear flag since we've found the file. We do this last so score doesn't overwrite it

  DMDframeTimer := cnt                                                                                  'FRAME RATE DEPENDENT!!!!  
  
  return 1



PUB clearQueue                                                                  'Flush the video queue

  byteFill(@nextVid[0], 0, 12) 



PUB playSFX(whichChannel, char0, char1, char2, incomingPriority) | g, temp, sortFlag     'Play a sound, if a channel is available
  
  if char0 < 65 or char0 > 90                                                   'Only A-Z are allowed. Else we'll look at sector memory that hasn't been defined
    return 0                                                                    '...RETURN 0, sound can't be played

  if incomingPriority < sfxPriority[whichChannel]
    return

  nextPriority[whichChannel] := incomingPriority                                'Once we find the file, set its priority

  sfxToFind[whichChannel] := (char1 << 8) | char2                               'What file we're looking for (only need 2nd and 3rd characters, so fits in a word)
      
  currentDirectorySector0[whichChannel] := folderSector0[char0 - 65]            'Start our search at beginning of the directory of the first letter (such as _FA, _FB)
      
  return 1



PUB FindSFXEntry(whichChannel) | startingSector, offset, g

  startingSector := 0                                                                                   'Set this to 0. If we find something, it's a flag to continue and load the file

  sd0.readSector(currentDirectorySector0[whichChannel], @dataBlock0, 1)                                 'Read in a sector of the directory

  if dataBlock0[0] == 0                                                                                 'Empty sector?
    sfxToFind[whichChannel] := 0                                                                        'Stop our search
    return 255                                                                                          'Return MERCY FILE NOT FOUND code
    
  repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block

    if dataBlock0[offset + 1] == (sfxToFind[whichChannel] >> 8) and dataBlock0[offset + 2] == (sfxToFind[whichChannel] & %1111_1111)                'Check 2nd and 3rd characters (first character assumed to match folder name) 
      startingSector := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector 
      quit                                                                                              'Found it, bail!
    
  if startingSector == 0                                                                                'Didn't find it?  
    currentDirectorySector0[whichChannel] += 1                                                          'Check the next directory sector
    return 0                                                                                            'Return that we haven't found it yet
 
  sfxPriority[whichChannel] := nextPriority[whichChannel]                                             'Set the new priority for this channel

  if whichChannel == 3 and musicOneShot == 0                                                            'Music channel, and not a one-shot music clip?

    currentMusic[0] := sfxToFind[whichChannel] >> 8                                                     'Set as current, so we can prevent it from restarting if called again
    currentMusic[1] := sfxToFind[whichChannel] & %1111_1111

  sfxToFind[whichChannel] := 0                                                                          'Found it, set this to 0 so it stops looking
  
  sfxClear(whichChannel)                                                                              'Clear the SFX buffer    
  audio.stopPlayer(whichChannel)                                                                        'Stop the player
  
  sd0.readSector(startingSector, @dataBlock0, 1)                                                        'Load the first sector into memory

  offset := 15                                                                                          'Where to start looking for the DATA indicator 
  sfxSector[whichChannel] := 0

  repeat while sfxSector[whichChannel] == 0                                                             'Find the # of samples and where audio data starts

    offset += 1
  
    if dataBlock0[offset] == "d" and dataBlock0[offset + 1] == "a"                                        'A lowercase 'd' followed by an 'a'?
    
      'Set the starting sector of the file
      sfxSector[whichChannel] := startingSector
       
      'Fill the DAC buffer 
      sfxSector[whichChannel] := sd0.readSector(sfxSector[whichChannel], @audioBuffer[whichChannel << 8], 1)                         'Fill Buffer 0
      sfxSector[whichChannel] := sd0.readSector(sfxSector[whichChannel], @audioBuffer[(whichChannel << 8) + 128], 1)                 'Fill Buffer 1

      'Calculate # of samples           
      sfxSamples[whichChannel] := dataBlock0[offset + 7] << 24 + dataBlock0[offset + 6] << 16 + dataBlock0[offset + 5] << 8 + dataBlock0[offset + 4]       
      sfxSamples[whichChannel] >>= 2

      'Erase the metadata from start of buffer
      longFill(@audioBuffer[whichChannel << 8], 0, (offset + 7) >> 2)

      'Get how many channels are playing (not counting this one that's about to)  
      offset := audio.getActiveChannels * volumeMultiplier
                                                                 
      'Make this new track quieter based off that      
      if sfxStereoSFX[whichChannel]                                             'If stereo SFX set, don't manually set volume here

        sfxStereoSFX[whichChannel] := 0
        
      else

        if whichChannel < 3                                                     'Also don't auto-correct volume for music either
      
          setVolumeCurrent(whichChannel, leftDefaultV - offset, rightDefaultV - offset)                            
      
      'Start the player, skipping the beginning of the buffer which is WAV format data
      audio.startPlayer(whichChannel, sfxSamples[whichChannel])

  return 1
  


PUB finishSFX(whichChannel, allowRepeat)                                                                             'Stuff to check when a SFX clip ends

  audio.stopPlayer(whichChannel)                                                                        'Stop the DAC player
  sfxSamples[whichChannel] := 0
  sfxPriority[whichChannel] := 0
  sfxClear(whichChannel)

  audio.Volume(whichChannel, leftDefaultV[whichChannel], rightDefaultV[whichChannel])                   'Set channel to default audio levels

  leftCurrentV[whichChannel] := leftDefaultV[whichChannel]                                              'Set current volume levels back to default
  rightCurrentV[whichChannel] := rightDefaultV[whichChannel]

  if nextSound[4] and nextSound[0] == whichChannel                                                       'SFX in queue, and it's same channel as SFX that just finished?

    if syncNext == 10                                                                                   'Waiting for SFX to finish so we can do an A/V sync?

      playVideo(nextVid[0], nextVid[1], nextVid[2], nextVid[3], nextVid[4], nextVid[5], 3)                 'Run video
      playSFX(nextSound[0], nextSound[1], nextSound[2], nextSound[3], nextSound[4])                     'Run audio                   
      syncNext := 0                                                                                     'Clear flags
                  
      byteFill(@nextVid[0], 0, 6)                                                                       'Erase the enqueued video  
      byteFill(@nextSound[0], 0, 5)                                                                   'Erase the SFX queue  
                    
      if nextVid[11]                                                                                    'BUT if there's another video in the secondary queue...
               
        byteMove(@nextVid[0], @nextVid[6], 6)                                                           'Copy the second enqueued video into the next enqueued video spot
        byteFill(@nextVid[6], 0, 6)                                                                     'and clear out the secondary queue
 
    else                                                                                                'No sync? Then just play the SFX

      if syncNext == 0                                                                                  'We aren't waiting for the DMD to finish?
    
        playSFX(nextSound[0], nextSound[1], nextSound[2], nextSound[3], nextSound[4])                   'Play that SFX

        byteFill(@nextSound[0], 0, 5)                                                                   'Erase the SFX queue
  
  if whichChannel == 3                                                                                  'Music that just ended (or was ended via Fade Stop Music)

    fadeSpeed := 0                                                                                      'If a fade timer was active, disable it

    if musicOneShot == 1                                                                                'Resume music that was playing before one shot clip?
     
      musicOneShot := 0                                                                                 'Turn off flag
      musicResume                                                                                       'Resume old music

      return                                                                                            'Return out so next function won't execute

    if musicRepeat and allowRepeat                                                                      'Repeat music?
       
      playSFX(3, "Z", currentMusic[0], currentMusic[1], 255)                                            'Start the same music over again
       


PUB sfxClear(whichChannel)

  longFill(@audioBuffer[whichChannel << 8], 0, 256)                          'Erase that buffer


  
PUB musicResume

  setVolumeCurrent(3, 0, 0)                                                     'Set music volume to 0

  fadeSpeed := 50                                                             'Set fast fade-in
  fadeTimer := fadeSpeed

  musicVolumeTarget := leftDefaultV[3]                                          'Default volume we're going to fade up to  

  sfxSamples[3] := lastMusicSamples                                             'Where we left off in the previous file
  sfxSector[3] :=  lastMusicSector

  'currentMusic[0] := currentMusic[2]                                            'Set these back to the previous music
  'currentMusic[1] := currentMusic[3]  

  'currentMusic[2] := 0                                                          'Clear these
  'currentMusic[3] := 0
  
  sfxSector[3] := sd0.readSector(sfxSector[3], @audioBuffer[3 << 8], 1)                         'Fill it!
  sfxSector[3] := sd0.readSector(sfxSector[3], @audioBuffer[(3 << 8) + 128], 1)                   'Fill it!
            
  audio.startPlayer(3, sfxSamples[3])



PUB setVolume(whichChannel, leftVol, rightVol)

  leftDefaultV[whichChannel] := leftVol
  rightDefaultV[whichChannel] := rightVol    

  leftCurrentV[whichChannel] := leftVol 
  rightCurrentV[whichChannel] := rightVol 
  
  audio.Volume(whichChannel, leftVol, rightVol)
  

PUB setVolumeCurrent(whichChannel, leftVol, rightVol)

  leftCurrentV[whichChannel] := leftVol 
  rightCurrentV[whichChannel] := rightVol 
  
  audio.Volume(whichChannel, leftVol, rightVol)



PUB blockToWord0(index) ' 4 Stack Longs

  bytemove(@result, @dataBlock0[(index & $1_FF)], 2)
 

PUB blockToLong0(index) ' 4 Stack Longs

  bytemove(@result, @dataBlock0[(index & $1_FF)], 4)


PUB Load

  'SmallNum(audio.getActiveChannels, 0, 27)

  byteMove(@bufferD + 2048, @bufferD, 2048)                       'Copy lower half of buffer into top half


PUB Clear

  byteFill(@bufferD, 0, 2048)


PUB bufferClear

  byteFill(@dataBlock0, 0, 512)
  


PUB Blink(b_times, b_speed)

dira[status_LED]~~

repeat b_times

  OUTA[status_LED]~~
  Pause(b_speed)
  OUTA[status_LED]~
  Pause(b_speed)       

  

PUB Pause(time)

'Pause execution for TIME milliseconds

waitcnt((time * 104_000) + cnt)



PUB Plot(xPos, yPos, plotColor) | buffPos, evenOdd, temp

  buffpos := (xpos >> 1) + (ypos << 6) 

  if xPos & 1                                                                   'Odd?

    bufferD[buffPos] := (bufferD[buffPos] & %11110000) | plotColor              'Mask off left side

  else                                                                          'Even?
   
    bufferD[buffPos] := (bufferD[buffPos] & %00001111) | (plotColor << 4)       'Mask off left side



PUB Graphics | totalNumbers, g                                                  'See if anything should be overlaid on the video or score display

  timerNumberActive := 0                                                        'Assume it isn't unless we find a number that says it is

  if EOBnum[5] == 255                                                           'Flag to auto-load end of ball bonus numbers?
    EOBnumberAdd

  if Mode == 8                                                                  'Need to build a display using the 4 persistent Score Display Numbers?

    totalNumbers := 11                                               'From 0-11

  else

    totalNumbers := 7

  repeat g from 0 to totalNumbers                                                         'Display any/all active numbers, including Timer Number

    if graphicPriMatch[g] == 0 or graphicPriMatch[g] == VidPriority             'If 0 (what almost everything will have) or equal to priority
                                                                                'Pops will use 249 and actually set this value, meaning those numbers will only work on pops. I hope.
      case graphicType[g]
       
        1 : 'Numbers command?
       
          Numbers(g)
       
        2 : 'Progress bar?
       
          if videoAtt & allowBar                                                    'Can show a progress bar?
           
            drawProgressBar(g)
       
        3 : 'Character Sprite?
       
          drawSprite(g)  

    
  if playerInitial and VidPriority == 0                                         'Entering a high score? Show the letters

    ScoreEntryDisplay
    
  if attractMode and graphicType[0] == 0                                        'Prevents FREE PLAY/CREDITS from appearing on Match screen

      showCredits(88, 26)


PUB drawSprite(which) | g, buffPos, numPos, startingRow, startingByte, whichCharacter  

  whichCharacter := graphicValue[which] & %1111_1111

  if whichCharacter > 95
    whichCharacter -= 32

  if whichCharacter < 32
    return 0

  buffpos := (graphicX[which] >> 1) + (graphicY[which] << 6) 

  numPos := 0

  whichCharacter -= 32                                                          'Lobb off first 32 bytes of ASCII

  startingRow := whichCharacter >> 4                                            'Find startingRow (0 - 3)

  startingByte := (startingRow << 9) + ((whichCharacter - (startingRow * 16)) << 2)

  g := 0
  
  byteFill(@outBuffer[0], 0, 16)                                       'Clear the buffer
       
  repeat graphicValue[which] >> 24

    if (graphicAtt[which] & returnPixels) and (g < 8)                           'Flag to return the pixels that the character draws over?

      outBuffer[g] := bufferD[buffPos + 1]                                      'Copy center left pixel pair
      outBuffer[g + 8] := bufferD[buffPos + 2]                                  'Copy center right pixel pair
      g += 1                                                                    'Advance counter

    byteMove(@bufferD[buffPos], @font[startingByte + numPos], 4)                'Each alphabet character is 2 bytes long
    buffPos += 64
    numPos += 64
    
    if buffPos > 2048                                                           'Avoid scrolling off bottom of screen
      quit    




PUB drawProgressBar(which) | gg, pattern, fillValue, shiftAmount


  gg := (graphicY[which] * 64) + graphicX[which] >> 1                                                             'Left to right byte offset 

  pattern := graphicAtt[which]

  pattern |= pattern << 4  

  repeat (graphicValue[which] & %1111_1111)                                                                         'LSB is the height of the bar
  
    byteFill(@bufferD + gg, pattern, (graphicValue[which] >> 24) >> 1)                                   'MSB is the length
    
    gg += 64

    if gg => 2047                                                                                     'Go past top of screen memory?
      quit                                                                                            'We're done here! Milkshake Drank!



PUB Numbers(g) | subCommand, FXcommand, gg, numberTemp

    numberTemp := graphicValue[g]                                                 'What number to display

    case graphicAtt[g] >> 5                                                     'Analyze the top 3 bits to find Attributes 
     
      %001 : 'Blink the number?
     
        if DMDCurrentFrame & %00000001                                            'Flash on odd video frame numbers
          return                                                                  'Return, don't draw numbers this frame

      %010 : 'Display a Player's score as the current number?

        numberTemp := PlayerScore[graphicValue[g]]                               'Set the NumberTemp to that player's score

    if videoAtt & allowLarge                                                    'If we are allowing large numbers, check for those...
    
      case graphicAtt[g] & %00001111                                            'Lower 4 bits is the type of number
       
        1 : 'Large number?
       
          LargeNum(numberTemp, graphicX[g], graphicY[g])

    if videoAtt & allowSmall                                                    'If we are allowing small numbers, check for those... 

      case graphicAtt[g] & %00001111                                            'A lot of ways to use small numbers. Check for them all

        2 : 'Small number?   

          SmallNum(numberTemp, graphicX[g], graphicY[g])

          timerNumberActive := 1

        3 : 'Small numbers, upper left and right corners?   

          if numberTemp > 99                                 'Limit the number size
            numberTemp := 99

          SmallNum(numberTemp, 0, 0)

          if numberTemp < 10                               'Right hand number 
            SmallNum(numberTemp, 124, 0)
          else
            SmallNum(numberTemp, 120, 0)

          timerNumberActive := 1       

        4 : 'Small numbers, lower left and right corners?   

          if numberTemp > 99                                 'Limit the number size
            numberTemp := 99

          SmallNum(numberTemp, 0, 27)                      'Left side number, always at X = 0

          if numberTemp < 10                               'Right hand X number depends on # of digits 
            SmallNum(numberTemp, 124, 27)
          else
            SmallNum(numberTemp, 120, 27)

          timerNumberActive := 1     

        5 : 'Small numbers, all four corners?   

          if numberTemp > 99                                 'Limit the number size
            numberTemp := 99
            
          SmallNum(numberTemp, 0, 0)  
          SmallNum(numberTemp, 0, 27)
         
          if numberTemp < 10                               'Right hand number 
            SmallNum(numberTemp, 124, 0)
            SmallNum(numberTemp, 124, 27)
          else
            SmallNum(numberTemp, 120, 0)
            SmallNum(numberTemp, 120, 27)

          timerNumberActive := 1     

        6 : 'Small number, with Double Zeros for a score?   
          
          doubleZero := 1           
          SmallNum(numberTemp, graphicX[g], graphicY[g])
          doubleZero := 0   

        8 : 'Show all 4 player numbers on right side for Match?
          
          doubleZero := 1
         
          repeat gg from 1 to NumberPlayers  
         
            SmallNum(PlayerScore[gg], graphicX[g], ((gg - 1) * 7) + 1)
          
          doubleZero := 0
         
          if DMDCurrentFrame & %00000001                             'Flash the last 2 characters of each score (every other frame)
         
            numberTemp := 60

            repeat 32
              byteFill(@bufferD + numberTemp, 0, 4)
              numberTemp += 64

        9 : 'Draw Ball # on display? 

          showMessage(0, graphicX[g], graphicY[g], 1, 6)
          SmallNum(Ball, graphicX[g] + 30, graphicY[g])

 


PUB showNumberFlash

  Clear

  if numberFlashTimer & %0000_0010
    LargeNum(numberFlash, 255, 6)

  Load

  Pause(50)
  
  numberFlashTimer -= 1

  if numberFlashTimer == 0                                   'Done?

    numberFlash := 0                                    'Clear Numberflash, revert to default mode
    mode := 255



PUB EOBnumberAdd                                        'Add frame-accurate numbers to the End of Ball video

  graphicType[0] := 1
  graphicAtt[0] := 1
  graphicX[0] := 255
  graphicY[0] := 12

  if DMDcurrentFrame > 0 and DMDcurrentFrame < 14       'Was 1
    graphicValue[0] := EOBnum[0] 

  if DMDcurrentFrame > 13 and DMDcurrentFrame < 27      'Was 14                                     
      graphicValue[0] := EOBnum[1]

  if DMDcurrentFrame > 26 and DMDcurrentFrame < 40      'Was 27                                     
      graphicValue[0] := EOBnum[2]

  if DMDcurrentFrame > 39 and DMDcurrentFrame < 52      'Was 40                                     
      graphicValue[0] := EOBnum[3]

  if DMDcurrentFrame > 51 and DMDcurrentFrame < 78      'Was 52                                     '121
      graphicValue[0] := EOBnum[4]

  if DMDcurrentFrame > 77                               'Was 78
    EOBnum[5] := 0                                      'Disable numbers
    graphicType[0] := 0                                 'Disable the number




PUB GraphicFlush(startFlush, endFlush) | g                                                                                     'Clears out all numbers (except timer numbers)

  repeat g from startFlush to endFlush

    if (graphicAtt[g] & numberStay) == 0

      graphicType[g] := 0
      graphicAtt[g] := 0   
      graphicX[g] := 0
      graphicY[g] := 0
      graphicValue[g] := 0
      graphicPriMatch[g] := 0


PUB AttractSettings

  if attractMode == 1
        
    'playVideo("AZZ", 0, 0, 0, 3)                         'Run the title video
    playVideo("AT0", 0, 0, 0, 3)                         'Run the title video

    Mode := 100

    return

  if attractMode == 2

    if credits                                          'If we have credits, or freeplay bit of credits is set...
    
      playVideo("AT1", 0, 0, 0, 3)                         'Run the title video
        
    else
    
      playVideo("AT2", 0, 0, 0, 3)                         'Run the title video      


    Mode := 100

    return

  if attractMode == 8
        
    if lastScoresFlag                             'Only show last game's scores if there was a last game
      Mode := 5
      frameTimer := 150

    else  
      Mode := 255                                'Set flag to jump to the next Attract Mode
                             
    return

  if attractMode == 16                            'Jump to long stay scores?
        
    if lastScoresFlag                             'Only show last game's scores if there was a last game
      Mode := 5
      frameTimer := 2000

    else
      Mode := 255                                'Set flag to jump to the next Attract Mode
                             
    return

  'Else, show high scores 1-5

  Mode := 4

  frameTimer := 100
  


PUB showHighScore(whichScore)

  if whichScore < 0 or whichScore > 4

    Mode := 255 
    return

  drawingFrame := 1

  Clear
 
  LoadAlpha("#", 38, 0, 8)                                                          'Place a "#"
  LoadAlpha(whichScore + 49, 46, 0, 8)                                             'Place the Number
  LoadAlpha(topPlayers[(whichScore * 3) + 0], 62, 0, 8)                            'Place the initials 
  LoadAlpha(topPlayers[(whichScore * 3) + 1], 70, 0, 8)                            'Place the initials
  LoadAlpha(topPlayers[(whichScore * 3) + 2], 78, 0, 8)                            'Place the initials    

  MediumNum(highScores[whichScore], 255, 9)                                     'Print a large number in center of screen

  showCredits(88, 26)
  
  Load

  drawingFrame := 0  
  
  frameTimer -= 1

  if frameTimer < 1
    Mode := 255

  

PUB showLastScores

  drawingFrame := 1  
  
  Clear

  Score                                                                'Show the last game's scores

  Load

  drawingFrame := 0  

  frameTimer -= 1

  if frameTimer < 1
    Mode := 255



PUB ScoreEntryDisplay | currentChar, xPos

  LoadAlpha("#", 8, 15, 8)                                                 'Put what place the player got onscreen  
  LoadAlpha(playerPlace + 48, 16, 15, 8)                                                 'Put what place the player got onscreen

  SmallNum(PlayerScore[playerInitial], 28, 14)                                   'Put that player's score onscreen
  
  entryChar[cursorPos] := startChar                                             'Set the active character
  
  repeat xPos from 0 to 2

    LoadAlpha(entryChar[xPos], (xPos * 8) + 96, 10, 8)

  currentChar := startChar - (12 + cursorPos)                                   'Figure out where to start

  if currentChar < 64
    currentChar := 92 - (64 - currentChar)                                             'Flip it around

  repeat xPos from 0 to 127 step 8                                                      'Put the alpha scroll on the display

    LoadAlpha(currentChar, xPos, 23, 8)                                        'Load the character on the display (offsetting #12345)
    currentChar += 1                                                            'Increment character
    if currentChar > 91                                                         'Did we go past the edge?
      currentChar := 64                                                          'Reset it!
 
  'Load

  'drawingFrame := 0
  
  


PUB Score | numDigits, columnSize, pCount, sX, sY, g

  Clear                                                 'Clear bufferD

  videoAtt := allowSmall                                'Only numbers allowed in Score display are small ones (like in the corners)
  
  futzNumbers := 1                                      'Set flag that it's OK to add weird shit to the Current Player Score

  Graphics                                               'Do this first to get status of current numbers

  g := 0                                                'Flag to show up to 4 normal scores UNLESS...
  
  if attractMode                                        'Don't show # of balls in attract mode
    showCredits(88, 26)    

  else
       
    if timerNumberActive                                  'Timer numbers in the corners?
      g := 1                                              'Flag to draw single score
      showBall(44, 26)                              'Show just the Ball # in the center
    else
      g := 0
      showBall(0, 26)                               'Show current Ball # and Credits normally
      showCredits(88, 26)

  doubleZero := 1 
  
  if numberPlayers == 1                                 'Single player game?
    g := 1                                              'One big score in the center

  repeat pCount from 1 to NumberPlayers
    if PlayerScore[pCount] > 999_999_999 and attractMode == 0                'If any player has a 10 digit score, only show 1 score at a time
      g := 1                                            'In attract mode we show 4 small scores, so they'll fit no problem
  
  if g                                                  'For large scores, single player or during a countdown, show current player score only
 
    MediumNum(PlayerScore[CurrentPlayer], 255, 6)
    
  else  
    
    repeat pCount from 1 to NumberPlayers                                       'Put all player scores in corners (like Baby)   
   
      sX := 0
      sY := 1
     
      if CurrentPlayer <> pCount                                                'Show a small score for non-active players
   
        if pCount == 2 or pCount == 4                                           'Player 2 or player 4 scores that need to be on the Right?
          sX := 128                                                             'Set score to right justify
        if pCount == 3 or pCount == 4                                           'Player 3 or Player 4 scores that need to be on the Bottom?
          sY := 20                                                              'Set vertical position to bottom
   
        SmallNum(PlayerScore[pCount], sX, sY)                                   'Display the number
   
      else                                                                      'Show LARGE number for active player
   
        if pCount == 2 or pCount == 4                                           'Player 2 or player 4 scores that need to be on the Right?
          sX := 128                                                             'Set score to right justify
        if pCount == 3 or pCount == 4                                           'Player 3 or Player 4 scores that need to be on the Bottom?
          sY := 8

        if attractMode == 0                                                     'If not in attract mode, show a large number
          MediumNum(PlayerScore[pCount], sX, sY) 

        else                                                                    'Else, small number
          if sY == 8                                                            'Make sure vertical position is correct
             sY := 20
             
          SmallNum(PlayerScore[pCount], sX, sY)
        
   
  doubleZero := 0 
   
  Load                                                                          'Load bufferD onto display
   
  futzNumbers := 0                                                              'Clear flag that it's OK to add weird shit to the Current Player Score


PUB LoadAlpha(whichCharacter, xPos, yPos, height) | buffPos, numPos, startingRow, startingByte

  if whichCharacter > 95
    whichCharacter -= 32

  if whichCharacter < 32
    return 0

  buffpos := (xpos >> 1) + (ypos << 6) 

  numPos := 0

  whichCharacter -= 32                                                          'Lobb off first 32 bytes of ASCII

  startingRow := whichCharacter >> 4                                            'Find startingRow (0 - 3)

  startingByte := (startingRow << 9) + ((whichCharacter - (startingRow * 16)) << 2)
  
  repeat height

    byteMove(@bufferD[buffPos], @font[startingByte + numPos], 4)                'Each alphabet character is 2 bytes long
    buffPos += 64
    numPos += 64
    
    if buffPos > 2048                                                           'Avoid scrolling off bottom of screen
      quit    



PUB text(strPointer, xPos, yPos)

  repeat while byte[strPointer]

    LoadAlpha(byte[strPointer++], xPos, yPos, 8)

    xPos += 8

    if xPos > 127
      xPos := 0
      yPos += 8


PUB drawSwitches | xPos, yPos, whichSwitch, checkBit

  xPos := 29
  yPos := 1

  repeat whichSwitch from 0 to 7

    checkBit := %00000001
    
    repeat 8
  
      if switchDisplay[whichSwitch] & checkBit
       
        Plot(xPos, yPos, 15)
        Plot(xPos + 1, yPos, 15)
        Plot(xPos, yPos + 1, 15)
        Plot(xPos + 1, yPos + 1, 15)

      checkBit <<= 1

      yPos += 4


    xPos -= 4
    yPos := 1

  xPos := 37
  
  repeat whichSwitch from 8 to 9

    checkBit := %00000001
    
    repeat 8
  
      if switchDisplay[whichSwitch] & checkBit
       
        Plot(xPos, yPos, 15)
        Plot(xPos + 1, yPos, 15)
        Plot(xPos, yPos + 1, 15)
        Plot(xPos + 1, yPos + 1, 15)

      checkBit <<= 1

      yPos += 4


    xPos -= 4
    yPos := 1



PUB LargeNum(whatNumber, xPos, yPos) | x, info, numerals, commas, numDigits

  info := Num2String(whatNumber)                      'Convert the number to a string, get # of numerals and commas

  numerals := info & %00001111                          'LSB's hold number of numerals
  commas := (info & %1111000) >> 4                      'MSB's hold number of commas

  x := 0                                                'Set stating point in local RAM to retreive graphics

  numDigits := numerals + commas

  if xPos > 127
  
    if xPos == 255                                        'Flag to auto-center the number?
      xPos := (64 - ((numerals * 6) + commas * 2)) >> 1   'Center onscreen. Number of bytes wide - (width size of number in bytes) / 2
     
    if xPos == 128                                        'Justify right?
      xPos := 64 - ((numerals * 6) + commas * 2)

  else

    xPos /= 2  
    
  repeat numDigits

    xpos += LoadNumeralNew(byte[@numberString][x++] - 48, 1, xpos, yPos)
    


PUB MediumNum(whatNumber, xPos, yPos) | x, info, numerals, commas, numDigits

  info := Num2String(whatNumber)                      'Convert the number to a string, get # of numerals and commas

  numerals := info & %00001111                          'LSB's hold number of numerals
  commas := (info & %1111000) >> 4                      'MSB's hold number of commas

  x := 0                                                'Set stating point in local RAM to retreive graphics

  numDigits := numerals + commas

  if xPos > 127
  
    if xPos == 255                                        'Flag to auto-center the number?
      xPos := (64 - ((numerals * 4) + commas * 2)) >> 1   'Center onscreen. Number of bytes wide - (width size of number in bytes) / 2
     
    if xPos == 128                                        'Justify right?
      xPos := 64 - ((numerals * 4) + commas * 2)

  else

    xPos /= 2  
    
  repeat numDigits

    xpos += LoadNumeralNew(byte[@numberString][x++] - 48, 2, xpos, yPos)



PUB SmallNum(whatNumber, xPos, yPos) | x, info, numerals, commas, numDigits

  info := Num2String(whatNumber)                      'Convert the number to a string, get # of numerals and commas

  numerals := info & %00001111                          'LSB's hold number of numerals
  commas := (info & %1111000) >> 4                      'MSB's hold number of commas

  x := 0                                                'Set stating point in local RAM to retreive graphics

  numDigits := numerals + commas

  if xPos > 127
  
    if xPos == 255                                        'Flag to auto-center the number?
      xPos := (64 - ((numerals * 2) + commas * 2)) >> 1   'Center onscreen. Number of bytes wide - (width size of number in bytes) / 2
     
    if xPos == 128                                        'Justify right?
      xPos := 64 - ((numerals * 2) + commas * 2)

  else

    xPos /= 2  
    
  repeat numDigits

    xpos += LoadNumeralNEW(byte[@numberString][x++] - 48, 0, xpos, yPos)

 


PUB Num2String(scorex) | div, z_pad, idx, size, column, actualCommas 

  div := 1_000_000_000                                  ' initialize divisor
  z_pad~                                                ' clear zero-pad flag
  bytefill(@numberString, 0, 14)                        ' clear string to zeros
  idx~
  size := 0                                             ' reset index
  actualCommas := 0                                     'How many commas we put in
  column := 10                                          'Used for finding commas

  if scorex == 0 and doubleZero == 1                   'Number is a zero, and Double Zeros enabled? 
    numberString[0] := 48                               'Double zeros
    numberString[1] := 48
    return 2                                            'Return that we have 2 zeros and no commas   
  
  repeat 10                                             'Max 9,999,999,999
  
    if (scorex => div)                                  ' printable character?
      numberString[idx++] := (scorex / div + "0")       ' yes, print ASCII digit
      scorex //= div                                    ' update value
      z_pad~~
      size += 1

      if column == 10 or column == 7 or column == 4     'Should we add a comma?
        numberString[idx++] := ":"                      'Add a column
        actualCommas += 1
      
    elseif z_pad or (div == 1)                          ' printing or last column?
      numberString[idx++] := "0"
      size += 1
      if column == 10 or column == 7 or column == 4     'Should we add a comma?
        numberString[idx++] := ":"                      'Add a column
        actualCommas += 1

    column -= 1                                         'Column decrements no matter what, so we can find commas  
    div /= 10
  
  return size | (actualCommas << 4)                     'Combine size and # of commas into 1 returned value



PUB LoadNumeralNEW(whichNumeral, numSize, xpos, ypos) | y, buffpos, numPos, multi, reps

  'Loads a numeral graphic from main memory into the Image bufferD

  multi := 2                                            'Default bytes to advance per character  
  
  buffpos := xpos + (ypos << 6)                         'Find starting byte (xPos + (yPos * 64)

  if whichNumeral == 10                                 'If there's room to lower the comma, then do it
    if numSize == 2 and ypos < 16 
      buffpos += 64
    if numSize == 1 and ypos < 12 
      buffpos += 64
         
  if numSize == 0                                       'Small numerals
    y := 5
    
  if numSize == 1                                       'Large
    y := 20
    
  if numSize == 2                                       'Medium
    y := 16    
   
  if (ypos + y) > 64                                      'Is part of the sprite going to scroll off the bottom of the screen?
    y := 64 - ypos                                        'Limit the number of lines we'll load

  numPos := 0

  reps := 0
  
  case numSize

    0 :                                                                         'A small, 2 byte wide number?

      multi := 2                                                                'Default bytes to advance per character. Small characters comma is same width as numeral
    
      repeat y
       
        byteMove(@bufferD[buffPos], @numberSmall[(whichNumeral * 2) + numPos], multi)        'Each small character file is 7 bytes long, including the 2 X Y size header bytes

        buffPos += 64                                                           'Increase bufferD one 64
        numPos += 24           
     
      return 2                                                                  'Return how many columns on screen to move to the right
     
    
    1 :                                                                         'A large, 6 byte wide number?

      if whichNumeral <> 10                                                       'If it's not a comma, normal width, else 1
        multi := 6                                                                'Default bytes to advance per character  
       
      repeat y
       
        byteMove(@bufferD[buffPos], @numberLarge[(whichNumeral * 6) + numPos], multi) 'Each large character file is 62 bytes long, including the 2 X Y size header bytes
       
        buffPos += 64                                                             'Increase bufferD one 64
        numPos += 64
       
      return 1 * multi                                                            'Return how many columns to move across the screen
       

    2 :                                                                         'A medium, 4 byte wide number
     
      if whichNumeral <> 10                                                       'If it's not a comma, normal width, else 1
        multi := 4                                                                'Default bytes to advance per character  
     
      repeat y

        if reps == numberFXtimer and futzNumbers and whichNumeral <> 10 and attractMode == 0
         
          byteFill(@bufferD[buffPos - 64], 0, multi)
          byteMove(@bufferD[buffPos], @numberMedium[(whichNumeral * 4) + numPos], multi)
          bufferD[buffPos] <-= 4
          bufferD[buffPos + 1] <-= 4 
                
        else
         
          'byteMove(@bufferD[buffPos], @NumM[(whichNumeral * 34) + yy], 1 * multi) 'Each large character file is 62 bytes long, including the 2 X Y size header bytes
     
          byteMove(@bufferD[buffPos], @numberMedium[(whichNumeral * 4) + numPos], multi) 'Each large character file is 62 bytes long, including the 2 X Y size header bytes
       
        buffPos += 64                                                             'Increase bufferD one 64
        numPos += 44
        reps += 1
      
      return 1 * multi                                                            'Return how many columns to move across the screen
     
     



PUB showBall(xpos, ypos)


  if ball                                               'To hide Ball #, set Ball to 0
     
    showMessage(0, xPos, yPos, 0, 7)
     
    SmallNum(Ball, xPos + 30, yPos + 1)



PUB showCredits(xPos, yPos)                                         'Put either "Free Play" or "Credits: X" on lower right side of display


  if credits & %1000_0000                                                       'Freeplay bit set?

    showMessage(2, xPos, yPos, 0, 7)                                               'Remove xPos offset that reserves space for the # of credits

    plot(xPos + 38, 31, creditDot << 3)  
    
  else

    showMessage(1, xPos, yPos, 0, 7) 

    SmallNum(credits & %0111_1111, xPos + 32, yPos + 1)                         'Show number of credits, masking off Freeplay bit

    plot(xPos + 29, 31, creditDot << 3)

  

PUB showMessage(whichMessage, xPos, yPos, start, end) | buffpos                 'Load a bitmap message from RAM


  whichMessage *= 140                                                           'Find start of each message
  whichMessage += (20 * start)
   
  buffpos := (xpos / 2) + (ypos << 6)                                           'Where it goes onscreen (xPos / 2 + yPos * 64)
  
  repeat end - start
    byteMove(@bufferD + buffpos, @message + whichMessage, 20)                   'Read in one line of the image (20 bytes)   
    whichMessage += 20
    buffpos += 64                                                               'Go down one scaneline



PUB playVideo(char0, char1, char2, vidAtt, showProgress, newPriority, targetMode)        'This is called by the main cog.

  if newPriority < VidPriority                          'New video lower priority than what's already playing?
    return 0                                            'Abort

  if char0 < 65 or char0 > 90                           'Only A-Z are allowed
    return 0                                            '...RETURN 0, sound can't be played

  'serial.Str(STRING("PLAY: "))

  'serial.Bin(nextVid[3], 8)
  'serial.Tx(32)
  'serial.Bin(videoAtt, 8)
  'serial.Tx(32) 
  
  'serial.Tx(char0)                            
  'serial.Tx(char1)
  'serial.Tx(char2)
  'serial.Tx(32)
  'serial.Bin(vidAtt, 8)
  'serial.Tx(32)
  'serial.Tx(13)
  
  if (vidAtt & noEntryFlush) == 0                       'Don't flush graphics on entry to video?

    GraphicFlush(0, 7)

  DMDToFind[0] := char0                                 'This is the file/droid we're looking for
  DMDToFind[1] := char1
  DMDToFind[2] := char2
  DMDToFind[3] := vidAtt                                'We store these so they'll only be activated once DMD file is found
  DMDToFind[4] := newPriority                           'If the video is found, this will be its new priority                  
      
  currentDirectorySector0[3] := folderSector1[char0 - 65]  'Start our search at beginning of the directory of the first letter (such as _DA, _DB...)
  
  DMDsearch := targetMode                               'Set flag that we're looking for a DMD on the SD card. It's also the mode the game should switch to once DMD loads

  return 1                                              'Return 1, which means we're looking for the video clip!



PUB stopVideo

  'ALSO NEEDS TO KILL VIDEO QUEUE, ONCE WE GET THAT BACK IN

  byteFill(@nextVid[0], 0, 12)                          'Erase both video queues
  byteFill(@nextSound[0], 0, 5)
  syncNext := 0 
  
  if (videoAtt & noExitFlush) == 0
    GraphicFlush(0, 7)  
       
  videoAtt := %0000_0011                            'Default is ALLOW ALL NUMBERS, no repeats
  VidPriority := 0                                  'Allow any video to start up

  Mode := 255                                       'Let DMD kernel revert back to whatever it was doing   



PUB videoStream | timeOut                               'Streams video directly from the SD card to display buffer

  if cnt < DMDframeTimer                                'This runs in-line with the rest of the DMD kernel
    return Mode                                         'Return back with the current status of Mode (so we don't override it)
 
  DMDframeTimer := cnt + 6_933_333                      '104MHz / 15 FPS
  
  targetAddress := @bufferD[0]
  requestSector := 4                                    'Request that the SD card loop loads a video frame

  timeOut := 0
  
  repeat while requestSector                            'Wait until a frame loads

  Graphics                                              'Draw scores and graphics on frame  

  'SmallNum(DMDCurrentFrame, 0, 5)
  'SmallNum(DMDtotalFrames, 16, 5)
  'SmallNum(Mode, 0, 10)
  'SmallNum(VidPriority, 16, 10)
  
  Load                                                  'Put the buffer into the display    

  if Mode <> 3 and Mode <> 8                            'If mode changed to something non-video, abort!

    return Mode
  
  DMDCurrentFrame += 1                                  'Advance frame #
     
  if DMDCurrentFrame > DMDtotalFrames                   'DMDFileSize < 1                                  'File Done?

    VidPriority := 0                                  'Set No Priority. If a video loops, it will have 0 priority, anything can override it                

    if videoAtt & loopVideo                           'Supposed to loop video?
                                                      'Run same video again, same parameters except Video Priority 0, so ANYTHING can override it
      DMDCurrentSector := DMDStartingSector           'Reload starting sector
      DMDCurrentFrame := 1                            'Start the video over again

      return 3                                        'Return that a video is still playing

    if (videoAtt & noExitFlush) == 0

      'serial.Str(STRING("FLUSHING EXIT..."))
      'serial.Tx(13)
    
      GraphicFlush(0, 7)                              'Video ALWAYS flushes graphics on video end
    
    videoAtt := %0000_0011                            'Default is ALLOW ALL NUMBERS, no repeats

    return 255                                        'File's done! Revert back to score display or something
      
  else
    
    return 3                                          'Return that a video is still playing   



PUB videoStepStream                                     'Streams video directly from the SD card to display buffer

  waitcnt(cnt + 2_500_000)                              'About 40 FPS max

  targetAddress := @bufferD[0]
  requestSector := 4                                    'Request that the SD card loop loads a video frame

  repeat while requestSector                            'Wait until it does
  
  Graphics  
  
  Load                                                  'Put the buffer into the display    

  if Mode <> 3                                          'Did mode change during the wait?

    return Mode

  if videoAtt & manualStep

    if videoStep == 0                                   'If no flag to advance video...

      DMDCurrentSector -= 4                             'Stay on this frame

      return Mode

  videoStep := 0                                        'Clear flag
 
  DMDCurrentFrame += 1                                  'Advance frame #
     
  if DMDCurrentFrame > DMDtotalFrames                   'DMDFileSize < 1                                  'File Done?

    VidPriority := 0                                  'Set No Priority. If a video loops, it will have 0 priority, anything can override it                

    if videoAtt & loopVideo                           'Supposed to loop video?
                                                      'Run same video again, same parameters except Video Priority 0, so ANYTHING can override it
      DMDCurrentSector := DMDStartingSector           'Reload starting sector
      DMDCurrentFrame := 1                            'Start the video over again

      return 3                                        'Return that a video is still playing

    if (videoAtt & noExitFlush) == 0
    
      GraphicFlush(0, 7)                                    'Video ALWAYS flushes graphics on video end
    
    videoAtt := %0000_0011                            'Default is ALLOW ALL NUMBERS, no repeats

    return 255                                        'File's done! Revert back to score display or something
      
  else
    
    return 3                                          'Return that a video is still playing   




PUB loadSprite(char0, char1, char2, showIt) | offset, startingSector                     'This is called by the main cog.

  currentDirectorySector0[3] := folderSector1[25]          'Start our search at beginning of the "_DZ" directory

  startingSector := 0   

  repeat while startingSector == 0
  
    sd0.readSector(currentDirectorySector0[3]++, @dataBlock0, 1)                                               'Read in a sector of the directory
    
    if dataBlock0[0] == 0                                                                                 'Empty sector?
      return 255                                                                                          'Return MERCY FILE NOT FOUND code
      
    repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block
     
      if dataBlock0[offset] == char0 and dataBlock0[offset + 1] == char1 and dataBlock0[offset + 2] == char2 
        startingSector := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector

  startingSector += 1                                                                                   'Skip past the metadata and null sector
  
  sd0.readSector(startingSector, @bufferD, 4)                                                           'Load 4 sector Sprite into memory



PUB LoadNumbers | g                                                             'Load large numerals from DMD SD card into memory
  
  loadSprite("ZML", 0)                                                     'Load Large Numeral sprite file into memory

  byteMove(@numberLarge[0], @bufferD, 1280)                                     'Copy it into the numberLarge variable (RAM)

  loadSprite("ZMM", 0)                                                     'Load Medium Numeral sprite file into memory

  repeat g from 0 to 15
  
    byteMove(@numberMedium[g * 44], @bufferD[g * 64], 44)                       'Copy it into the numberLarge variable (RAM)

  loadSprite("ZMS", 0)                                                     'Load Small Numeral sprite file into memory

  repeat g from 0 to 4
  
    byteMove(@numberSmall[g * 24], @bufferD[g * 64], 24)                       'Copy it into the numberLarge variable (RAM)

  loadSprite("ZMF", 0)                                           'Load Small Numeral sprite file into memory, but mostly we're looking for its sector #

  byteMove(@font[0], @bufferD[0], 2048)                       'Copy it into the numberLarge variable (RAM)
 
  Clear
   

PUB showVersions | xPos                                 'Gets the CODE version from EEPROM and displays them on startup

  repeat eepromAddress from 128 to 131

    eepromData := readLong($A0, eepromAddress) <- 8     'Get 4 bytes, shift position 

    repeat 4
    
      LoadAlpha(eepromData & $FF, cursorPos, 0, 8)
      cursorPos += 8
      eepromData <-= 8

  eepromData := readLong($A0, $0000) >> 24              'Always contains the checksum and code version. Rotate to leave just the leftmost byte (code version #)

  text(string("CODE VERSION:"), 0, 16)
  SmallNum(eepromData, 104, 18)
  text(string("A/V  VERSION:"), 0, 24)
  SmallNum(AVversion, 104, 26)
  Load

  Pause(2000)



PUB BuildFolderList0 | offset, g, directoriesFound                                                        'Finds the SFX folder and logs the directory sectors of all folders inside it

  Pause(100)

  currentDirectorySector0 := 0

  currentDirectorySector0 := getFileSector("SFX", card0DirectorySector)                              'Find SFX folder on card's root directory

  if currentDirectorySector0 == 0

    showMessage(3, 0, 0, 0, 7)
    Load

    Pause(2000)

    reboot
 
  
  directoriesFound := 0
  
  repeat
  
    currentDirectorySector0 := sd0.readSector(currentDirectorySector0, @dataBlock0, 1)                    'Read in a sector of the directory, advance the sector #

    repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block

      if dataBlock0[offset] == 0                                                                          'No more entries - done!
        return directoriesFound

      if dataBlock0[offset] == "_" and dataBlock0[offset + 1] == "F"                                      'Valid Folder Name?
     
        g := dataBlock0[offset + 2]                                                                        'Assign temp value so it's less messy
       
        if g > 64 and g < 91                                                                               'MUST be A-Z

          directoriesFound += 1
        
          folderSector0[g - 65] := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector 

  

PUB BuildFolderList1 | offset, g, directoriesFound                                                        'Read the root directory and make a list of starting sectors for all folders

  Pause(100)  

  currentDirectorySector1 := 0

  currentDirectorySector1 := getFileSector("DMD", card0DirectorySector)                                   'Start at the beginning of the Root Directory

  if currentDirectorySector1 == 0

    showMessage(4, 0, 6, 0, 7)      
    Load

    Pause(2000)

    reboot
    
 
  directoriesFound := 0

  PlayerScore[1] := 0                                                                                   'Use this as a flag set to 0. If new EEPROM found, this holds sector # of file
  
  repeat
  
    currentDirectorySector1 := sd0.readSector(currentDirectorySector1, @dataBlock0, 1)                    'Read in a sector of the directory, advance the sector #

    repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block

      if dataBlock0[offset] == 0                                                                          'No more entries - done!
        return directoriesFound

      if dataBlock0[offset] == "_" and dataBlock0[offset + 1] == "D"                                      'Valid DMD Folder Name?
      
        g := dataBlock0[offset + 2]                                                                        'Assign temp value so it's less messy
      
        if g > 64 and g < 91                                                                               'MUST be A-Z

          directoriesFound += 1
        
          folderSector1[g - 65] := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector 

      if dataBlock0[offset] == "P" and dataBlock0[offset + 1] == "R" and dataBlock0[offset + 2] == "O" and dataBlock0[offset + 3] == "P"

        'Use the filename to get the version #
        g := ((dataBlock0[offset + 5] - 48) * 100) + ((dataBlock0[offset + 6] - 48) * 10) + (dataBlock0[offset + 7] - 48)

        if g > AVversion

          PlayerScore[1] := ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector
          PlayerScore[2] := g




PUB getFileSector(char0, char1, char2, searchSector) | offset

  repeat
  
    searchSector := sd0.readSector(searchSector, @dataBlock0, 1)                                          'Read in a sector of the directory, advance the sector #

    repeat offset from 0 to 480 step 32                                                                   'Check all 16 entries in this block. Root directory probably won't have more than 3-4 files

      if dataBlock0[offset] == 0                                                                          'No more entries - done!
        return 0
    
      if dataBlock0[offset] == char0 and dataBlock0[offset + 1] == char1 and dataBlock0[offset + 2] == char2                                      'Matching file name?
        
        return ((((blockToWord0(offset + 20) << 16) | blockToWord0(offset + 26)) - 2) << 6 ) + card0DirectorySector 



PUB flashEEPROM                                                                'Loads a HEX file off the SD card to reprogram the Propeller's EERPOM

  Clear
  text(string("A/V UPDATING:"), 0, 0)

  SmallNum(PlayerScore[2], 104, 2)

  eepromAddress := 0                                                            'Starting page of the EEPROM

  repeat 64                                                                     'Load 64 sectors of data (512 bytes per sector)

    PlayerScore[1] := sd0.readSector(PlayerScore[1], @dataBlock0, 1)                'Read in 1 sector

    eepromData := 0                                                             'The offset of where we are in the dataBlock0
    
    repeat 16                                                                   '32 bytes per page is a very safe assumption of what the EEPROM can do (most can do 64 bytes per page)

      WritePage($A0, eepromAddress, @dataBlock0[0] + eepromData, 32)            'Write page

      Pause(5)                                                                  'Give EEPROM page buffer time to finish write cycle (just to be safe)
      
      eepromData += 32                                                          'Advance 32 bytes into the buffer
      eepromAddress += 32                                                       'Advance 32 bytes into the EEPROM

      frameTimer := 512
      
      repeat 4                                                                  'Draw progress bar onscreen

        byteFill(@bufferD + frameTimer, %1111_1111, eepromAddress >> 9)

        frameTimer += 64

      Load    
      
  text(string("DONE - REBOOTING"), 0, 24)
  Load
  
  Pause(1000)

  reboot
  


PUB I2Cinitialize

   outa[28] := 1                       '   reinitialized.  Drive SCL high.
   dira[28] := 1
   dira[29] := 0                       ' Set SDA as input
   repeat 9
      outa[28] := 0                    ' Put out up to 9 clock pulses
      outa[28] := 1
      if ina[29]                      ' Repeat if SDA not driven high
         quit                          '  by the EEPROM


PUB I2Cstart

   outa[28]~~                         ' Initially drive SCL HIGH
   dira[28]~~
   outa[29]~~                         ' Initially drive SDA HIGH
   dira[29]~~
   outa[29]~                          ' Now drive SDA LOW
   outa[28]~                          ' Leave SCL LOW
  
PUB I2CStop

   outa[28]~~                         ' Drive SCL HIGH
   outa[29]~~                         '  then SDA HIGH
   dira[28]~                          ' Now let them float
   dira[29]~                          ' If pullups present, they'll stay HIGH


PUB Write(dataX) : ackbit
'' Write i2c data.  Data byte is output MSB first, SDA data line is valid
'' only while the SCL line is HIGH.  Data is always 8 bits (+ ACK/NAK).
'' SDA is assumed LOW and SCL and SDA are both left in the LOW state.

   ackbit := 0 
   dataX <<= 24
   repeat 8                            ' Output data to SDA
      outa[29] := (dataX <-= 1) & 1
      outa[28]~~                      ' Toggle SCL from LOW to HIGH to LOW
      outa[28]~
   dira[29]~                          ' Set SDA to input for ACK/NAK
   outa[28]~~
   ackbit := ina[29]                  ' Sample SDA when SCL is HIGH
   outa[28]~
   outa[29]~                          ' Leave SDA driven LOW
   dira[29]~~


PUB Read(ackbit): dataX
'' Read in i2c data, Data byte is output MSB first, SDA data line is
'' valid only while the SCL line is HIGH.  SCL and SDA left in LOW state.

   dataX := 0
   dira[29]~                          ' Make SDA an input
   repeat 8                            ' Receive data from SDA
      outa[28]~~                      ' Sample SDA when SCL is HIGH
      dataX := (dataX << 1) | ina[29]
      outa[28]~
   outa[29] := ackbit                 ' Output ACK/NAK to SDA
   dira[29]~~
   outa[28]~~                         ' Toggle SCL from LOW to HIGH to LOW
   outa[28]~
   outa[29]~                          ' Leave SDA driven LOW


PUB ReadPage(devSel, addrReg, dataPtr, count) : ackbit
'' Read in a block of i2c data.  Device select code is devSel.  Device starting
'' address is addrReg.  Data address is at dataPtr.  Number of bytes is count.
'' The device select code is modified using the upper 3 bits of the 19 bit addrReg.
'' Return zero if no errors or the acknowledge bits if an error occurred.

   devSel |= addrReg >> 15 & %1110
   I2Cstart
   ackbit := Write(devSel | Xmit)
   ackbit := (ackbit << 1) | Write(addrReg >> 8 & $FF)
   ackbit := (ackbit << 1) | Write(addrReg & $FF)          
   I2Cstart
   ackbit := (ackbit << 1) | Write(devSel | Recv)
   
   repeat count - 1
      byte[dataPtr++] := Read(ACK)
   byte[dataPtr++] := Read(NAK)
   I2Cstop
   return ackbit
   


PUB ReadLong(devSel, addrReg) : dataX
'' Read in a single long of i2c data.  Device select code is devSel.  Device
'' starting address is addrReg.  The device select code is modified using the
'' upper 3 bits of the 19 bit addrReg.  This returns true if an error occurred.
'' Note that you can't distinguish between a return value of -1 and true error.

   if ReadPage(devSel, (addrReg << 2) + eepromBase, @dataX, 4)
      return -1
      

PUB WritePage(devSel, addrReg, dataPtr, count) : ackbit
'' Write out a block of i2c data.  Device select code is devSel.  Device starting
'' address is addrReg.  Data address is at dataPtr.  Number of bytes is count.
'' The device select code is modified using the upper 3 bits of the 19 bit addrReg.
'' Most devices have a page size of at least 32 bytes, some as large as 256 bytes.
'' Return zero if no errors or the acknowledge bits if an error occurred.  If
'' more than 31 bytes are transmitted, the sign bit is "sticky" and is the
'' logical "or" of the acknowledge bits of any bytes past the 31st.
   devSel |= addrReg >> 15 & %1110
   I2CStart
   ackbit := Write(devSel | Xmit)
   ackbit := (ackbit << 1) | Write(addrReg >> 8 & $FF)
   ackbit := (ackbit << 1) | Write(addrReg & $FF)          
   repeat count                        ' Now send the data
      ackbit := ackbit << 1 | ackbit & $80000000 ' "Sticky" sign bit         
      ackbit |= Write(byte[dataPtr++])
   I2CStop
   return ackbit
   

PUB WriteLong(devSel, addrReg, dataX)
'' Write out a single long of i2c data.  Device select code is devSel.  Device
'' starting address is addrReg.  The device select code is modified using the
'' upper 3 bits of the 19 bit addrReg.  This returns true if an error occurred.
'' Note that the long word value may not span an EEPROM page boundary.

   if WritePage(devSel, (addrReg << 2) + eepromBase, @dataX, 4)
      return true
   ' james edit - wait for 5ms for page write to complete (80_000 * 5 = 400_000)      
   waitcnt(800_000 + cnt)      
   return false





DAT                                                     

Message 

        file "messages.DAT"                             '40x35 pixels (20x35 bytes) Sprites that read:  Ball  , Credits: , Freeplay, DMD Error, SFX Error  

ORG 0                                                   'This machine language codes looks for serial data commands from the PIC32  

IOSetup

        rdlong dataBufferStart, par                     'We pass along location of Byte 0 of the Data Out buffer

        mov dataOutPosition, dataBufferStart            'This is our starting byte as well
        
        mov commBufferStart, dataBufferStart            'We copy that value into Comm Buffer Start
        add commBufferStart, #16                        'and add 16 to get Comm Buffer Start position

        mov dData, commBufferStart                      'Our starting command read byte
        
        mov commBufferTop, commBufferStart              'Load starting address into commBufferTop
        add commBufferTop, #256                         'Add commBuffSize to find the Top of Memory (256 bytes = 16 commands) 
        add commBufferTop, #256                         'Add commBuffSize to find the Top of Memory (256 bytes = 16 commands) 
                                                        'We do this twice to get a 512 byte buffer

        mov dataOut, #1                                'Setup masking bits for I/O data
        rol dataOut, #24
        mov Clock, #1
        rol Clock, #25
        mov dataIn, #1
        rol dataIn, #26
        mov dira, dataOut                               'There is one output line, set it
           
        rdbyte dataOutByte, dataOutPosition             'Get the first Data Out Byte from memory 
        mov DataMask, #1                                'Reset the bit mask 
        mov dataByte, #0                                'Clear the data in byte
        
Wait4ClockHigh
        test Clock, ina wz                              'See if the clock is HIGH yet
        if_z jmp #Wait4ClockHigh                        'If not, keep waiting...

FillData
        test dataIn, ina wc                             'See if there's a data bit on the line
        if_c or Databyte, DataMask                      'If so, OR Datamask onto Databyte (else its a zero)

        test dataOutByte, DataMask wc                   'If the current bit of DataOutByte is high...
        muxc outa, dataOut                              'Assert that value on the bus
        
        rol DataMask, #1                                'Shift to the left to make room for next bit
        
Wait4ClockLow
        test Clock, ina wc                              'See if Clock line is still high
        if_c jmp #Wait4ClockLow                         'Keep waiting if it is

        cmp DataMask, #256 wc                           'See if DataMask has shifted an entire byte (is this mask on Bit 8?)
        if_c jmp #Wait4ClockHigh                        'If hasn't, keep getting more bits - else, move on to main memory byte write

WriteByte
        wrbyte Databyte, dData                          'Write the byte we received to main memory
        mov DataMask, #1                                'Reset the bit mask 
        mov dataByte, #0                                'Clear the data in byte
        
        add dData, #1                                   'Increment the Command Buffer Pointer
        add dataOutPosition, #1                         'Increment the Data Output pointer
        
        cmp dataOutPosition, commBufferStart wz         'Did we reach the top? (16 bytes)
        if_z mov dataOutPosition, dataBufferStart       'Reset it!
         
        rdbyte dataOutByte, dataOutPosition             'Get the next (or if it reset, the first) data out byte from memory
        
        cmp dData, commBufferTop wz                     'Did the data buffer reach the top?
        if_z mov dData, commBufferStart                 'Reset it, hopefully SPIN has interpreted 32 commands by now

        jmp #Wait4ClockHigh                             'Wait for more bits



zero                    long    0

'Cog RAM Resident Variables

'Data lines
dataOut                 res       1       'long %00000001_00000000_00000000_00000000  
Clock                   res       1       'long %00000010_00000000_00000000_00000000
dataIn                  res       1       'long %00000100_00000000_00000000_00000000

Databyte                res       1       'byte 0
DataMask                res       1

dataBufferStart         res       1
dataOutPosition         res       1
dataOutByte             res       1       'Read this byte from main memory, then shift it out as new bits are shifted in

commBufferStart         res       1       'Address of first data table
dData                   res       1
commBufferTop           res       1       'Where the top of command line memory is