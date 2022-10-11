            ;           Thomas Bernabe-Bacilio               Program2            4/6/22
            ; This Program will begin with a dot in memory location xE440 then the user will enter a character input "WASD" for directions to move the pen into 
            ; the corresponding direction and leave a trail. The user will be given the option to change the pen and pen's trail's color witht the "RGBY SPACE"
            ; keys. If the user enters the "RETURN" key then the display will be cleared. When the user is done they will enter the 'q' key and the program will 
            ; come to HALT. 

        .ORIG x3000

        AND R0, R0, #0
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0 
        AND R4, R4, #0
        AND R5, R5, #0
        AND R6, R6, #0


        LD R6, COLORWHITE   ; Loads the color white into R0 
        LD R1, START        ; Loads the Start location into R1 
        ST R1, CURRCOORD 
        ST R6, CURRCOLOR 


DRAWBOX LD R3, COLUMNSIZE

LOOP2   LD R2, ROWSIZE 
        LD R4, DROW 


LOOP1   STR R6, R1, #0 ; Places a pixel at R1 of color R0 
        ADD R1, R1, #1 ; Move location by 1 to the right 
        ADD R2, R2 #-1 ; decrements the counter 
        BRp LOOP1 ; When it is positive it goes back to the loop 

        
        ADD R1, R1, R4  ; This brings down the dot down by 4 
        ADD R3, R3, #-1
        BRp LOOP2 

        AND R0, R0, #0  ; Clears the registers 
        AND R2, R2, #0
        AND R3, R3, #0 
        AND R4, R4, #0
        AND R5, R5, #0
        AND R6, R6, #0
 

KEY     GETC        ; Key loop that asks for the user to input a character 
        OUT         ; This outputs the character to the screen for user to read 

        AND R3, R3, #0
        LD R2, ASCIIb       ; Checks for the b key 
        ADD R3, R0, R2
        BRz BLUE 

        AND R3, R3, #0
        LD R2, ASCIIg       ; Checks for the g key 
        ADD R3, R0, R2
        BRz GREEN 

        AND R3, R3, #0
        LD R2, ASCIIr       ; Checks for the r key 
        ADD R3, R0, R2
        BRz RED 

        AND R3, R3, #0
        LD R2, ASCIIy       ; Checks for the y key 
        ADD R3, R0, R2
        BRz YELLOW 

        AND R3, R3, #0
        LD R2, ASCIIwh      ;Checks for the space key 
        ADD R3, R0, R2 
        BRz WHITE 

        AND R4, R4, #0
        LD R3, ASCIIs       ; Checks for the s key 
        ADD R4, R0, R3
        BRz DOWNMOV 

        AND R4, R4, #0
        LD R3, ASCIIw       ; Checks for the w key 
        ADD R4, R0, R3 
        BRz UPMOV

        AND R4, R4, #0
        LD R3, ASCIId       ; Checks for the d key 
        ADD R4, R0, R3
        BRz RIMOV

        AND R4, R4, #0 
        LD R3, ASCIIa       ; Checks for the a key 
        ADD R4, R0, R3
        BRz LEMOV

        AND R4, R4, #0 
        LD R3, ASCIIq       ; Checks for the q key 
        ADD R4, R0, R3
        BRz END     

        AND R4, R4, #0 
        LD R3, ASCIIe       ; Checks for the enter key 
        ADD R4, R0, R3
        BRz CLEAR


BRnzp KEY       ; What this does is that if no recognized keys are entered then the program will continue to ask for an inpput 


 BLUE   LD R6, COLORBLUE        ; Loads the color blue into R6 
        ST R6, CURRCOLOR        ; Stores the color blue into the current color 
        LD R1, CURRCOORD        ; Loads the current coordinate of the pen into R1 
        BRnzp MAKEBOX

GREEN   LD R6, COLORGREEN
        ST R6, CURRCOLOR 
        LD R1, CURRCOORD 
        BRnzp MAKEBOX 

RED     LD R6, COLORRED 
        ST R6, CURRCOLOR 
        LD R1, CURRCOORD  
        BRnzp MAKEBOX

YELLOW  LD R6, COLORYELLOW 
        ST R6, CURRCOLOR 
        LD R1, CURRCOORD  
        BRnzp MAKEBOX

WHITE   LD R6, COLORWHITE 
        ST R6, CURRCOLOR 
        LD R1, CURRCOORD 
        BRnzp MAKEBOX 



DOWNMOV LD R5, DOWN         ; Loads 128 into R5 
        LD R1, CURRCOORD 
        LD R6, CURRCOLOR    ; Loads current color into R6
        ADD R1, R1, R5      ; Adds 128 pixels to the current coordinate it is in to bring it straight down 
        ADD R1, R1, R5
        ADD R1, R1, R5
        ADD R1, R1, R5
        ST R1, CURRCOORD    ; Stores the new current coordinate into R1 
        BRnzp MAKEBOX

UPMOV   LD R5, UP       ; Loads -128 into R5 
        LD R1, CURRCOORD 
        LD R6, CURRCOLOR  
        ADD R1, R1, R5  ; Adds -128 pixels to the current coordinate to bring it straight up 
        ADD R1, R1, R5
        ADD R1, R1, R5
        ADD R1, R1, R5
        ST R1, CURRCOORD    ; Stores the new current coordinate into R1 
        BRnzp MAKEBOX

RIMOV   LD R1, CURRCOORD  
        LD R6, CURRCOLOR
        ADD R1, R1, #4      ; To move right I added 4 
        ST R1, CURRCOORD 
        BRnzp MAKEBOX

LEMOV   LD R1, CURRCOORD 
        LD R6, CURRCOLOR 
        ADD R1, R1, #-4     ; To move left I added -4 
        ST R1, CURRCOORD 
        BRnzp MAKEBOX 

END      HALT   ; When q is entered the program halts 

    ; Clears the screen 

CLEAR   LD R2, COLORBLACK   ; Load the color black into R2 
        LD R5, CLEARCOORD   ; Load the top left coordinate into R5 
        AND R3, R3, #0
        LD R3, AREA     ; Loads the entire area of the display into R3 

LOOP6   STR R2, R5, #0 
        ADD R5, R5, #1  ; Increment counter 
        ADD R3, R3, #-1 
        BRp LOOP6       ; Will loop until is is negative (all of the area is cleared)
        LD R1, CURRCOORD ; This was to try to keep the current coordinate the same before I cleared the screen 
        
        
        



BRnzp MAKEBOX 



   



        


MAKEBOX LD R3, COLUMNSIZE       ; This "MAKEBOX" is used to make a 4x4 pixel box when it comes to the commands. This MAKEBOX is different thatn DRAWBOX 

LOOP3   LD R2, ROWSIZE 
        LD R4, DROW 


LOOP4   STR R6, R1, #0 ; Places a pixel at R1 of color R0 
        ADD R1, R1, #1 ; Move location by 1 to the right 
        ADD R2, R2 #-1 ; decrements the counter 
        BRp LOOP4 ; When it is positive it goes back to the loop 

        
        ADD R1, R1, R4
        ADD R3, R3, #-1
        BRp LOOP3 

BRnzp KEY       ; Essentailly will go back to asking for an input 


HALT 

COLORWHITE   .FILL x7FFF
COLORRED     .FILL x7C00
COLORGREEN   .FILL x03E0
COLORBLUE    .FILL x001F
COLORYELLOW  .FILL x7FED 
COLORBLACK   .FILL x0000 

ASCIIr       .FILL #-114
ASCIIg       .FILL #-103
ASCIIb       .FILL #-98
ASCIIy       .FILL #-121
ASCIIwh      .FILL #-32

ASCIId       .FILL #-100 
ASCIIa       .FILL #-97
ASCIIs       .FILL #-115
ASCIIW       .FILL #-119

ASCIIe       .FILL #-10 
ASCIIq       .FILL #-113

ROW          .FILL #-132 ; This goes to the next row
DROW         .FILL #124
START        .FILL xE440
ROWSIZE      .FILL #4
COLUMNSIZE   .FILL #4 

DOWN         .FILL #128 
UP           .FILL #-128
RIGHT        .FILL #4
LEFT         .FILL #-4

CURRCOLOR    .FILL x0000
CURRCOORD    .FILL x0000


AREA         .FILL #15872
CLEARCOORD   .FILL xC000



        .END