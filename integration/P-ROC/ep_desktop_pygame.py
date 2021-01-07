import sys
import procgame
import pinproc
from threading import Thread
import random
import string
import time
import locale
import math
import copy
import ctypes
import itertools
from procgame.events import EventManager
import os
import usb.core
import usb.util
import usb.backend.libusb1


try:
    import pygame
    import pygame.locals
except ImportError:
    #print "Error importing pygame; ignoring."
    pygame = None

if hasattr(ctypes.pythonapi, 'Py_InitModule4'):
   Py_ssize_t = ctypes.c_int
elif hasattr(ctypes.pythonapi, 'Py_InitModule4_64'):
   Py_ssize_t = ctypes.c_int64
else:
   raise TypeError("Cannot determine type of Py_ssize_t")

PyObject_AsWriteBuffer = ctypes.pythonapi.PyObject_AsWriteBuffer
PyObject_AsWriteBuffer.restype = ctypes.c_int
PyObject_AsWriteBuffer.argtypes = [ctypes.py_object,
                                  ctypes.POINTER(ctypes.c_void_p),
                                  ctypes.POINTER(Py_ssize_t)]

def array(surface):
   buffer_interface = surface.get_buffer()
   address = ctypes.c_void_p()
   size = Py_ssize_t()
   PyObject_AsWriteBuffer(buffer_interface,
                          ctypes.byref(address), ctypes.byref(size))
   bytes = (ctypes.c_byte * size.value).from_address(address.value)
   bytes.object = buffer_interface
   return bytes


class EP_Desktop():
    """The :class:`Desktop` class helps manage interaction with the desktop, providing both a windowed
    representation of the DMD, as well as translating keyboard input into pyprocgame events."""

    exit_event_type = 99
    """Event type sent when Ctrl-C is received."""

    key_map = {}

    def __init__(self):
        #print "Init Color Desktop"
        self.ctrl = 0
        self.i = 0
        self.HD = False


        self.dev = usb.core.find(idVendor=0x0314, idProduct=0xE457)

        if self.dev is None:
            raise ValueError('Device not found')

        self.add_key_map(pygame.locals.K_LSHIFT, 3)
        self.add_key_map(pygame.locals.K_RSHIFT, 1)



    def Render_RGB24(self, buffer):
        
        gamma_table = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3,
                 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5,
                 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7,
                 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10,
                 11, 11, 11, 11, 11, 12, 12, 12, 12, 13, 13, 13, 13, 13, 14, 14,
                 14, 14, 15, 15, 15, 16, 16, 16, 16, 17, 17, 17, 18, 18, 18, 18,
                 19, 19, 19, 20, 20, 20, 21, 21, 21, 22, 22, 22, 23, 23, 23, 24,
                 24, 24, 25, 25, 25, 26, 26, 27, 27, 27, 28, 28, 29, 29, 29, 30,
                 30, 31, 31, 31, 32, 32, 33, 33, 34, 34, 35, 35, 35, 36, 36, 37,
                 37, 38, 38, 39, 39, 40, 40, 41, 41, 42, 42, 43, 43, 44, 44, 45,
                 45, 46, 47, 47, 48, 48, 49, 49, 50, 50, 51, 52, 52, 53, 53, 54,
                 55, 55, 56, 56, 57, 58, 58, 59, 60, 60, 61, 62, 62, 63, 63, 63]

        OutputPacketBuffer = [None] * 12292

        OutputPacketBuffer[0] = 0x81
        OutputPacketBuffer[1] = 0xC3
        OutputPacketBuffer[2] = 0xE9
        OutputPacketBuffer[3] = 18
        pixelR,pixelG,pixelB,pixelRl,pixelGl,pixelBl = 0,0,0,0,0,0
   
        for i in range(0,6144,3):
 
        #use these mappings for RGB panels
            pixelR = buffer[i]
            pixelG = buffer[i+1]
            pixelB = buffer[i+2]
            # lower half of display
            pixelRl = buffer[6144 + i]
            pixelGl = buffer[6144 + i + 1]
            pixelBl = buffer[6144 + i + 2]
 
        #use these mappings for RBG panels
            #pixelR = buffer[i]
            #pixelG = buffer[i+2]
            #pixelB = buffer[i+1]
            # lower half of display
            #pixelRl = buffer[6144 + i]
            #pixelGl = buffer[6144 + i + 2]
            #pixelBl = buffer[6144 + i + 1]

            #color correction
            pixelR = gamma_table[pixelR]
            pixelG = gamma_table[pixelG]
            pixelB = gamma_table[pixelB]

            pixelRl = gamma_table[pixelRl]
            pixelGl = gamma_table[pixelGl]
            pixelBl = gamma_table[pixelBl]

            targetIdx = (i/3)  + 4
           
            for j in range(0,6,1):
                OutputPacketBuffer[targetIdx] = ((pixelGl & 1) << 5) | ((pixelBl & 1) << 4) | ((pixelRl & 1) << 3) | ((pixelG & 1) << 2) | ((pixelB & 1) << 1) | ((pixelR & 1) << 0)
                pixelR >>= 1
                pixelG >>= 1
                pixelB >>= 1
                pixelRl >>= 1
                pixelGl >>= 1
                pixelBl >>= 1
                targetIdx += 2048    

        self.dev.write(0x01,OutputPacketBuffer,1000)
                    
    def draw_window(self,pixel,xoffset=0,yoffset=0):
        self.pixel_size = pixel
        if self.pixel_size == 14:
            self.xOffset = 64 + xoffset
            self.yOffset = 376 + yoffset
            self.xDefault = 64
            self.yDefault = 316
        elif self.pixel_size == 10:
            self.xOffset = 43 + xoffset
            self.yOffset = 233 + yoffset
            self.xDefault = 30
            self.yDefault = 175
        else:
            self.xOffset = xoffset
            self.yOffset = yoffset
            self.xDefault = 0
            self.yDefault = 0

        if 'pygame' in globals():
            self.setup_window()
        else:
            #print 'Desktop init skipping setup_window(); pygame does not appear to be loaded.'
            pass

    def load_images(self,dots_path,images_path):
        ## dot images
        #dot_black = pygame.image.load(dots_path+ 'DotBlack.png')
        dot_dark_grey_low = pygame.image.load(dots_path+ 'DotDarkGreyLow.png')
        dot_dark_grey_low = pygame.transform.scale(dot_dark_grey_low, (self.pixel_size,self.pixel_size))
        dot_dark_grey_low.convert()
        dot_dark_grey_mid = pygame.image.load(dots_path+ 'DotDarkGreyMid.png')
        dot_dark_grey_mid = pygame.transform.scale(dot_dark_grey_mid, (self.pixel_size,self.pixel_size))
        dot_dark_grey_mid.convert()
        dot_dark_grey = pygame.image.load(dots_path+ 'DotDarkGrey.png')
        dot_dark_grey = pygame.transform.scale(dot_dark_grey, (self.pixel_size,self.pixel_size))
        dot_dark_grey.convert()
        dot_dark_red_low = pygame.image.load(dots_path+ 'DotDarkRedLow.png')
        dot_dark_red_low = pygame.transform.scale(dot_dark_red_low, (self.pixel_size,self.pixel_size))
        dot_dark_red_low.convert()
        dot_dark_red_mid = pygame.image.load(dots_path+ 'DotDarkRedMid.png')
        dot_dark_red_mid = pygame.transform.scale(dot_dark_red_mid, (self.pixel_size,self.pixel_size))
        dot_dark_red_mid.convert()
        dot_dark_red = pygame.image.load(dots_path+ 'DotDarkRed.png')
        dot_dark_red = pygame.transform.scale(dot_dark_red, (self.pixel_size,self.pixel_size))
        dot_dark_red.convert()
        dot_grey_low = pygame.image.load(dots_path+ 'DotGreyLow.png')
        dot_grey_low = pygame.transform.scale(dot_grey_low, (self.pixel_size,self.pixel_size))
        dot_grey_low.convert()
        dot_grey_mid = pygame.image.load(dots_path+ 'DotGreyMid.png')
        dot_grey_mid = pygame.transform.scale(dot_grey_mid, (self.pixel_size,self.pixel_size))
        dot_grey_mid.convert()
        dot_grey = pygame.image.load(dots_path+ 'DotGrey.png')
        dot_grey = pygame.transform.scale(dot_grey, (self.pixel_size,self.pixel_size))
        dot_grey.convert()
        dot_dark_brown_low = pygame.image.load(dots_path+ 'DotDarkBrownLow.png')
        dot_dark_brown_low = pygame.transform.scale(dot_dark_brown_low, (self.pixel_size,self.pixel_size))
        dot_dark_brown_low.convert()
        dot_dark_brown_mid = pygame.image.load(dots_path+ 'DotDarkBrownMid.png')
        dot_dark_brown_mid = pygame.transform.scale(dot_dark_brown_mid, (self.pixel_size,self.pixel_size))
        dot_dark_brown_mid.convert()
        dot_dark_brown = pygame.image.load(dots_path+ 'DotDarkBrown.png')
        dot_dark_brown = pygame.transform.scale(dot_dark_brown, (self.pixel_size,self.pixel_size))
        dot_dark_brown.convert()
        dot_brown_low = pygame.image.load(dots_path+ 'DotBrownLow.png')
        dot_brown_low = pygame.transform.scale(dot_brown_low, (self.pixel_size,self.pixel_size))
        dot_brown_low.convert()
        dot_brown_mid = pygame.image.load(dots_path+ 'DotBrownMid.png')
        dot_brown_mid = pygame.transform.scale(dot_brown_mid, (self.pixel_size,self.pixel_size))
        dot_brown_mid.convert()
        dot_brown = pygame.image.load(dots_path+ 'DotBrown.png')
        dot_brown = pygame.transform.scale(dot_brown, (self.pixel_size,self.pixel_size))
        dot_brown.convert()
        dot_red_low = pygame.image.load(dots_path+ 'DotRedLow.png')
        dot_red_low = pygame.transform.scale(dot_red_low, (self.pixel_size,self.pixel_size))
        dot_red_low.convert()
        dot_red_mid = pygame.image.load(dots_path+ 'DotRedMid.png')
        dot_red_mid = pygame.transform.scale(dot_red_mid, (self.pixel_size,self.pixel_size))
        dot_red_mid.convert()
        dot_red = pygame.image.load(dots_path+ 'DotRed.png')
        dot_red = pygame.transform.scale(dot_red, (self.pixel_size,self.pixel_size))
        dot_red.convert()
        dot_dark_green_low = pygame.image.load(dots_path+ 'DotDarkGreenLow.png')
        dot_dark_green_low = pygame.transform.scale(dot_dark_green_low, (self.pixel_size,self.pixel_size))
        dot_dark_green_low.convert()
        dot_dark_green_mid = pygame.image.load(dots_path+ 'DotDarkGreenMid.png')
        dot_dark_green_mid = pygame.transform.scale(dot_dark_green_mid, (self.pixel_size,self.pixel_size))
        dot_dark_green_mid.convert()
        dot_dark_green = pygame.image.load(dots_path+ 'DotDarkGreen.png')
        dot_dark_green = pygame.transform.scale(dot_dark_green, (self.pixel_size,self.pixel_size))
        dot_dark_green.convert()
        dot_flesh_low = pygame.image.load(dots_path+ 'DotFleshLow.png')
        dot_flesh_low = pygame.transform.scale(dot_flesh_low, (self.pixel_size,self.pixel_size))
        dot_flesh_low.convert()
        dot_flesh_mid = pygame.image.load(dots_path+ 'DotFleshMid.png')
        dot_flesh_mid = pygame.transform.scale(dot_flesh_mid, (self.pixel_size,self.pixel_size))
        dot_flesh_mid.convert()
        dot_flesh = pygame.image.load(dots_path+ 'DotFlesh.png')
        dot_flesh = pygame.transform.scale(dot_flesh, (self.pixel_size,self.pixel_size))
        dot_flesh.convert()
        dot_purple_low = pygame.image.load(dots_path+ 'DotPurpleLow.png')
        dot_purple_low = pygame.transform.scale(dot_purple_low, (self.pixel_size,self.pixel_size))
        dot_purple_low.convert()
        dot_purple_mid = pygame.image.load(dots_path+ 'DotPurpleMid.png')
        dot_purple_mid = pygame.transform.scale(dot_purple_mid, (self.pixel_size,self.pixel_size))
        dot_purple_mid.convert()
        dot_purple = pygame.image.load(dots_path+ 'DotPurple.png')
        dot_purple = pygame.transform.scale(dot_purple, (self.pixel_size,self.pixel_size))
        dot_purple.convert()
        dot_green_low = pygame.image.load(dots_path+ 'DotGreenLow.png')
        dot_green_low = pygame.transform.scale(dot_green_low, (self.pixel_size,self.pixel_size))
        dot_green_low.convert()
        dot_green_mid = pygame.image.load(dots_path+ 'DotGreenMid.png')
        dot_green_mid = pygame.transform.scale(dot_green_mid, (self.pixel_size,self.pixel_size))
        dot_green_mid.convert()
        dot_green = pygame.image.load(dots_path+ 'DotGreen.png')
        dot_green = pygame.transform.scale(dot_green, (self.pixel_size,self.pixel_size))
        dot_green.convert()
        dot_yellow_low = pygame.image.load(dots_path+ 'DotYellowLow.png')
        dot_yellow_low = pygame.transform.scale(dot_yellow_low, (self.pixel_size,self.pixel_size))
        dot_yellow_low.convert()
        dot_yellow_mid = pygame.image.load(dots_path+ 'DotYellowMid.png')
        dot_yellow_mid = pygame.transform.scale(dot_yellow_mid, (self.pixel_size,self.pixel_size))
        dot_yellow_mid.convert()
        dot_yellow = pygame.image.load(dots_path+ 'DotYellow.png')
        dot_yellow = pygame.transform.scale(dot_yellow, (self.pixel_size,self.pixel_size))
        dot_yellow.convert()
        dot_blue_low = pygame.image.load(dots_path+ 'DotBlueLow.png')
        dot_blue_low = pygame.transform.scale(dot_blue_low, (self.pixel_size,self.pixel_size))
        dot_blue_low.convert()
        dot_blue_mid = pygame.image.load(dots_path+ 'DotBlueMid.png')
        dot_blue_mid = pygame.transform.scale(dot_blue_mid, (self.pixel_size,self.pixel_size))
        dot_blue_mid.convert()
        dot_blue = pygame.image.load(dots_path+ 'DotBlue.png')
        dot_blue = pygame.transform.scale(dot_blue, (self.pixel_size,self.pixel_size))
        dot_blue.convert()
        dot_orange_low = pygame.image.load(dots_path+ 'DotOrangeLow.png')
        dot_orange_low = pygame.transform.scale(dot_orange_low, (self.pixel_size,self.pixel_size))
        dot_orange_low.convert()
        dot_orange_mid = pygame.image.load(dots_path+ 'DotOrangeMid.png')
        dot_orange_mid = pygame.transform.scale(dot_orange_mid, (self.pixel_size,self.pixel_size))
        dot_orange_mid.convert()
        dot_orange = pygame.image.load(dots_path+ 'DotOrange.png')
        dot_orange = pygame.transform.scale(dot_orange, (self.pixel_size,self.pixel_size))
        dot_orange.convert()
        dot_cyan_low = pygame.image.load(dots_path+ 'DotCyanLow.png')
        dot_cyan_low = pygame.transform.scale(dot_cyan_low, (self.pixel_size,self.pixel_size))
        dot_cyan_low.convert()
        dot_cyan_mid = pygame.image.load(dots_path+ 'DotCyanMid.png')
        dot_cyan_mid = pygame.transform.scale(dot_cyan_mid, (self.pixel_size,self.pixel_size))
        dot_cyan_mid.convert()
        dot_cyan = pygame.image.load(dots_path+ 'DotCyan.png')
        dot_cyan = pygame.transform.scale(dot_cyan, (self.pixel_size,self.pixel_size))
        dot_cyan.convert()
        dot_white_255 = pygame.image.load(dots_path+ 'DotWhite255.png')
        dot_white_255 = pygame.transform.scale(dot_white_255, (self.pixel_size,self.pixel_size))
        dot_white_255.convert()
        dot_white_238 = pygame.image.load(dots_path+ 'DotWhite238.png')
        dot_white_238 = pygame.transform.scale(dot_white_238, (self.pixel_size,self.pixel_size))
        dot_white_238.convert()
        dot_white_221 = pygame.image.load(dots_path+ 'DotWhite221.png')
        dot_white_221 = pygame.transform.scale(dot_white_221, (self.pixel_size,self.pixel_size))
        dot_white_221.convert()
        dot_white_204 = pygame.image.load(dots_path+ 'DotWhite204.png')
        dot_white_204 = pygame.transform.scale(dot_white_204, (self.pixel_size,self.pixel_size))
        dot_white_204.convert()
        dot_white_187 = pygame.image.load(dots_path+ 'DotWhite187.png')
        dot_white_187 = pygame.transform.scale(dot_white_187, (self.pixel_size,self.pixel_size))
        dot_white_187.convert()
        dot_white_170 = pygame.image.load(dots_path+ 'DotWhite170.png')
        dot_white_170 = pygame.transform.scale(dot_white_170, (self.pixel_size,self.pixel_size))
        dot_white_170.convert()
        dot_white_153 = pygame.image.load(dots_path+ 'DotWhite153.png')
        dot_white_153 = pygame.transform.scale(dot_white_153, (self.pixel_size,self.pixel_size))
        dot_white_153.convert()
        dot_white_136 = pygame.image.load(dots_path+ 'DotWhite136.png')
        dot_white_136 = pygame.transform.scale(dot_white_136, (self.pixel_size,self.pixel_size))
        dot_white_136.convert()
        dot_white_119 = pygame.image.load(dots_path+ 'DotWhite119.png')
        dot_white_119 = pygame.transform.scale(dot_white_119, (self.pixel_size,self.pixel_size))
        dot_white_119.convert()
        dot_white_102 = pygame.image.load(dots_path+ 'DotWhite102.png')
        dot_white_102 = pygame.transform.scale(dot_white_102, (self.pixel_size,self.pixel_size))
        dot_white_102.convert()
        dot_white_085 = pygame.image.load(dots_path+ 'DotWhite085.png')
        dot_white_085 = pygame.transform.scale(dot_white_085, (self.pixel_size,self.pixel_size))
        dot_white_085.convert()
        dot_white_068 = pygame.image.load(dots_path+ 'DotWhite068.png')
        dot_white_068 = pygame.transform.scale(dot_white_068, (self.pixel_size,self.pixel_size))
        dot_white_068.convert()
        dot_white_051 = pygame.image.load(dots_path+ 'DotWhite051.png')
        dot_white_051 = pygame.transform.scale(dot_white_051, (self.pixel_size,self.pixel_size))
        dot_white_051.convert()
        dot_white_034 = pygame.image.load(dots_path+ 'DotWhite034.png')
        dot_white_034 = pygame.transform.scale(dot_white_034, (self.pixel_size,self.pixel_size))
        dot_white_034.convert()
        dot_magenta_low = pygame.image.load(dots_path+ 'DotMagentaLow.png')
        dot_magenta_low = pygame.transform.scale(dot_magenta_low, (self.pixel_size,self.pixel_size))
        dot_magenta_low.convert()
        dot_magenta_mid = pygame.image.load(dots_path+ 'DotMagentaMid.png')
        dot_magenta_mid = pygame.transform.scale(dot_magenta_mid, (self.pixel_size,self.pixel_size))
        dot_magenta_mid.convert()
        dot_magenta = pygame.image.load(dots_path+ 'DotMagenta.png')
        dot_magenta = pygame.transform.scale(dot_magenta, (self.pixel_size,self.pixel_size))
        dot_magenta.convert()

        image_kapow = pygame.image.load(images_path+'kapow.jpg').convert()
        image_boom = pygame.image.load(images_path+'boom.jpg').convert()
        image_powie = pygame.image.load(images_path+'powie.jpg').convert()
        image_bang = pygame.image.load(images_path+'bang.jpg').convert()
        image_zap = pygame.image.load(images_path+'zap.jpg').convert()
        image_doho = pygame.image.load(images_path+'doho.jpg').convert()
        image_kapooya = pygame.image.load(images_path+'kapooya.jpg').convert()
        image_jacob = pygame.image.load(images_path+'jacob.jpg').convert()

        self.mm_banners = [image_kapow, image_boom, image_powie, image_bang, image_zap, image_doho, "GIMMICK"]
        self.mm_gimmick = [image_kapooya, image_jacob]

        self.colors = [[None,None,None,None], # blank
                       [None,dot_grey_low,dot_grey_mid,dot_grey], # color 1 grey
                       [None,dot_dark_grey_low,dot_dark_grey_mid,dot_dark_grey], # color 2 dark grey
                       [None,dot_dark_green_low,dot_dark_green_mid,dot_dark_green], # color 3 dark green
                       [None,dot_flesh_low,dot_flesh_mid,dot_flesh], # color 4 flesh tone
                       [None,dot_purple_low,dot_purple_mid,dot_purple], # color 5 purple
                       [None,dot_dark_red_low,dot_dark_red_mid,dot_dark_red], # color 6 dark red
                       [None,dot_brown_low,dot_brown_mid,dot_brown], # color 7 - Brown
                       [None,dot_dark_brown_low,dot_dark_brown_mid,dot_dark_brown], # color 8 dark brown
                       [None,dot_red_low,dot_red_mid,dot_red], # color 9 - Red
                       [None,dot_green_low,dot_green_mid,dot_green], # color 10 - Green
                       [None,dot_yellow_low,dot_yellow_mid,dot_yellow], # color 11 - Yellow
                       [None,dot_blue_low,dot_blue_mid,dot_blue], # color 12 blue
                       [None,dot_orange_low,dot_orange_mid,dot_orange], # color 13 orange
                       [None,dot_cyan_low,dot_cyan_mid,dot_cyan], # color 14 - cyan
                       [None,dot_magenta_low,dot_magenta_mid,dot_magenta], # color 15 - magenta
                       #[None,dot_white_low,dot_white_mid,dot_white]] # default color - white
                       [None,None,dot_white_034,dot_white_051,dot_white_068,dot_white_085,dot_white_102,dot_white_119,dot_white_136,dot_white_153,dot_white_170,dot_white_187,dot_white_204,dot_white_221,dot_white_238,dot_white_255]]


    def add_key_map(self, key, switch_number):
        """Maps the given *key* to *switch_number*, where *key* is one of the key constants in :mod:`pygame.locals`."""
        self.key_map[key] = switch_number

    def clear_key_map(self):
        """Empties the key map."""
        self.key_map = {}

    def get_keyboard_events(self):
        """Asks :mod:`pygame` for recent keyboard events and translates them into an array
        of events similar to what would be returned by :meth:`pinproc.PinPROC.get_events`."""
        key_events = []
        for event in pygame.event.get():
            EventManager.default().post(name=self.event_name_for_pygame_event_type(event.type), object=self, info=event)
            key_event = {}
            if event.type == pygame.locals.KEYDOWN:
                if event.key == pygame.locals.K_RCTRL or event.key == pygame.locals.K_LCTRL:
                    self.ctrl = 1
                if event.key == pygame.locals.K_c:
                    if self.ctrl == 1:
                        key_event['type'] = self.exit_event_type
                        key_event['value'] = 'quit'
                elif (event.key == pygame.locals.K_ESCAPE):
                    key_event['type'] = self.exit_event_type
                    key_event['value'] = 'quit'
                elif event.key in self.key_map:
                    key_event['type'] = pinproc.EventTypeSwitchClosedDebounced
                    key_event['value'] = self.key_map[event.key]
            elif event.type == pygame.locals.KEYUP:
                if event.key == pygame.locals.K_RCTRL or event.key == pygame.locals.K_LCTRL:
                    self.ctrl = 0
                elif event.key in self.key_map:
                    key_event['type'] = pinproc.EventTypeSwitchOpenDebounced
                    key_event['value'] = self.key_map[event.key]
            if len(key_event):
                key_events.append(key_event)
        return key_events


    event_listeners = {}

    def event_name_for_pygame_event_type(self, event_type):
        return 'pygame(%s)' % (event_type)

    screen = None
    """:class:`pygame.Surface` object representing the screen's surface."""
    screen_multiplier = 4

    def setup_window(self):
        os.environ['SDL_VIDEO_WINDOW_POS'] = "%d,%d" % (self.xOffset,self.yOffset)
        pygame.init()
                    
        SetWindowPos = ctypes.windll.user32.SetWindowPos
        self.screen = pygame.display.set_mode(((self.pixel_size*128),(self.pixel_size*32)),pygame.NOFRAME)        
        SetWindowPos(pygame.display.get_wm_info()['window'], -1, self.xOffset, self.yOffset, 0, 0, 0x0001)
        pygame.mouse.set_visible(False)
        pygame.display.set_caption('Cactus Canyon Continued')
	#hide the display from the desktop
        pygame.display.iconify()

    def draw(self, frame):
        """Draw the given :class:`~procgame.dmd.Frame` in the window."""
        # Use adjustment to add a one pixel border around each dot, if
        # the screen size is large enough to accomodate it.
        if not self.HD:

            frame_string = frame.get_data()
            RGB_buffer = []

            x = 0
            y = 0
            # fill the screen black
            self.screen.fill((0,0,0))

            for dot in frame_string:
                dot_value = ord(dot)
                RGB_value = (0,0,0)
                image = None
                # if we got something other than 0
                if dot_value != 0:
                    # set the brightness and color
                    brightness = (dot_value&0xf)
                    # if we have a brightness but no color - use white
                    if brightness and (dot_value >>4) == 0:
                        color = 16
                        bright_value = brightness
                        del brightness
                    # otherwise, find the color and set the brightness
                    else:
                        if brightness <= 3:
                            bright_value = 0
                            del brightness
                        elif brightness <= 8:
                            bright_value = 1
                            del brightness
                        elif brightness <= 13:
                            bright_value = 2
                            del brightness
                        else:
                            bright_value = 3
                            del brightness
                        color = (dot_value >> 4)

                    ##print "Dot Value: " + str(derp) +" - color: " + str(color) + " - Brightness: " +str(brightness)
                    # set the image based on color and brightness
                    ##image = self.colors[color][bright_value]
 
                    if self.colors[color][bright_value]:
                        self.screen.blit(self.colors[color][bright_value],((x*self.pixel_size), (y*self.pixel_size)))
                        RGB_value = self.colors[color][bright_value].get_at((2,2))
                         
                    del color
                    del bright_value

                RGB_buffer.extend((RGB_value[0],RGB_value[1],RGB_value[2]))
                del RGB_value
                del dot
                del dot_value

                #if image:
                #    self.screen.blit(image, ((x*self.pixel_size), (y*self.pixel_size)))
                x += 1
                if x == 128:
                    x = 0
                    y += 1
                #del image

            del x
            del y
            del frame_string
            self.Render_RGB24(RGB_buffer)
            del RGB_buffer

            pygame.display.update()

    def clear_hd(self):
        self.HD = False

    def blit(self,image,x=0,y=0):
        self.HD = True
        self.screen.blit(image,(x,y))
        pygame.display.update()

    def blackout(self):
        self.screen.fill((0,0,0))
        pygame.display.update()



    def __str__(self):
        return '<Desktop pygame>'

