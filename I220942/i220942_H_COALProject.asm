.386
.model flat,stdcall
.stack 4096
INCLUDE Irvine32.inc
includelib winmm.lib
PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

BUFFER_SIZE = 501
.data
;=================sound==================
SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
file BYTE "for_pacman.wav" , 0
;====================file handle===================
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "output.txt",0
fileHandle HANDLE ?
stringLength DWORD ?
bytesWritten DWORD ?
str1 BYTE "Cannot create file",0dh,0ah,0
str2 BYTE "Bytes written to file [output.txt]:",0
str3 BYTE "Enter up to 500 characters and press"
     BYTE "[Enter]: ",0dh,0ah,0

;========================For Scoring================
strScore BYTE "Your score is: ",0
score BYTE 0
      db 0ah,0
scorestring db 5 dup(0),0ah
;==========================For Lives=================
strLives BYTE "        Your Lives are: ",0
Lives BYTE 3
;==========================For Game_over=================
Restar db 0
end_game_str db "Game Over!",0ah,"               The hungry ghosts have outsmarted Pac-Man. Better luck next time, chomper!",0ah,0ah,0ah,"              Press (R) to Restart ",0ah,0ah,0ah,0
;=================For PAC MAN==================================
pacman_welcome db 0,"WELCOME TO ",0ah,0
pacman_welcome1 db "      ___    ___    _____               ___ " ,0ah, "         |   |  |   |  |          |\   /|  |   |  |\   | ",0ah,"         |___|  |___|  |          |  \/ |  |___|  | \  | ",0ah,"         |      |   |  |          |     |  |   |  |  \ | ",0ah,"         |      |   |  |_____     |     |  |   |  |   \| ",0ah,0

;==============================for background===========================
clear db "                                                                                                                           ",0ah,0
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0
temp byte ?
;========================PAC MAN_cords===============
xPos BYTE 50
xPP BYTE 20
yPos BYTE 20
yPP BYTE 20
;=======================Ghost _cords=================
xg1 BYTE 20
yg1 BYTE 20
xg2 BYTE 20
yg2 BYTE 20
xg3 BYTE 20
yg3 BYTE 20
xg4 BYTE 20
yg4 BYTE 20
tmep byte 20 dup(0)
yprev BYTE 20
xprev BYTE 20
;========================one coin=====================
xCoinPos BYTE ?
yCoinPos BYTE ?
;==============================User Input==============
inputChar BYTE 0
;===============================User Name===============
X DWORD ?
user_ask db "ENTER YOUR NAME: ",0
user_name db 15 dup(' '),0
user_length dd 0
;==========================Screens====================
MENU_game db "NEW GAME (N)",0ah,"          INSTRUCTION (I)",0ah,"          EXIT GAME (E)",0ah,0
instruct db "    1. Objective: Eat all pellets in the maze, avoiding ghosts.",0ah,"    2. Controls: Use arrow keys (Up, Down, Left, Right) to move Pacman.",0ah,"    3. Power-ups: Consume Power Pellets to briefly eat ghosts.",0ah,"    4. Scoring: Earn points by eating pellets, ghosts, and bonus fruits.",0ah,"    5.Game Over: Three lives; lose one when a ghost catches Pacman.",0ah,0ah,"                                                                                           BACK (B) ",0ah,0
level_menu db "          LEVEL 1 (1)           ",0ah,"          LEVEL 2 (2)              ",0ah,"          LEVEL 3 (3)               ",0ah,0
;==================Level 1 ==================================================================================================================
game_level db 1
level1 db "---------------",0
coin1 db "  ...........",0
level1_x db 25 dup (?)
level1_y db 25 dup (?)
;=============================================

Level_1 db "/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////",0ah
        db "                                                                                                                     ",0ah
        db "          o o o o o o o o                            o o o o o o o o o                      o o o o o o              ",0ah
        db "                                                                                                                     ",0ah
        db "       ||////////////////////////////           ///////////////////////////////          ////////////////            ",0ah
        db "       ||                                                                                              ||            ",0ah
        db "       ||                                                                                              ||            ",0ah
        db "       ||            o o o  o o o   o o o o                                                            ||            ",0ah
        db "       ||                                                                 o o o o o o o                ||            ",0ah
        db "       ||      ||///////////////////////////////////                                                   ||            ",0ah
        db "       ||      ||           ||                                        /////////////////////                          ",0ah
        db "       ||      ||   o o     ||                                                                                       ",0ah
        db "       ||      ||   o o     ||          o o o o o                                                                    ",0ah
        db "       oo      ||   o o     ||                                                                         ||            ",0ah
        db "       oo      ||                                                            o o o o o o o             ||            ",0ah
        db "       oo      ||                                                    ||//////////////////////////////////            ",0ah
        db "       ||      ||                        o o o o o                   ||                                              ",0ah
        db "       ||      ||                   ////////////////                 ||                                              ",0ah
        db "       ||                                                            ||                                              ",0ah
        db "       ||                                                 o o o o o  ||                                              ",0ah
        db "       ||               ///////////////////////////////////////////////                                              ",0ah
        db "                                                                                                                     ",0ah
        db "                                             o o o o o o o o                                                         ",0ah
        db "                                                                                                                     ",0ah
        db "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\",0




Level2 db "                                                                                                                     ",0ah
       db " \\\\\\\\\\\\\\\\\\\\\\       \\\\\\\\\\\\\\\\\\\\\\\\\      \\\\\\\\\\\\\\\\\\\\\\\\          \\\\\\\\\\\\\\\\\\\\\\",0ah
       db "                         o                                                                                           ",0ah
       db "  |\\\\\\\\\\\\\\|                             |\\\\\\\\\\\\|                                           o            ",0ah
       db "  |    ooooo     |       |\\\\\\\\\\\|                             |\\\\\\\\\\|                                      ",0ah
       db "  |           @  |                             |////////////|                                            o           ",0ah
       db "  |/////    /////|     o                                             o             |\\\\\\\\\\\\\\|                  ",0ah
       db "                          o           |\\\\\\\\\\|                                 | @            |                  ",0ah
       db "                                                                                   |                                 ",0ah
       db "                   |/////    /////|                 |\\\\\\\\\\\\|                 |\\\\\\\\\\           o           ",0ah
       db "      o            |  ooo       @ |            o       o           o       o       | @       o                       ",0ah
       db "        o          |     ooo      |                                                |     o        |                  ",0ah
       db "      o            |//////////////|      |\\\\\\\\\\\\\\\\\\\\\|                   |  o           |       o          ",0ah
       db "                                                                                    o             |                  ",0ah
       db "  \\\\\\\\\\\    \\\\\\\\\\\\\\\\\    \\\\\\\\\\\\\   \\\\\\\\\\\\\\\     \\\\\          \\\\\\\\\|       o          ",0ah
       db "                                                                                          oo    @ |                  ",0ah
       db "                                                                                   |        ooo   |                  ",0ah
       db "      o            |/////    /////|                 |\\\\\\\\\\\\|                 |\\\\\\\\\\\\\\|                  ",0ah
       db "           o       |   ooo      @ |                                                                                  ",0ah
       db "      o            |      ooo     |                              o        o          o              o            o   ",0ah
       db "                   |//////////////|      |\\\\\\\\\\\\\\\\\\\\\|                    |\\\\\\\\\\\\\\\\\\\\\|          ",0ah
       db "        o                                                                                                            ",0ah
       db "                                                                                                                     ",0ah
       db "\\\\\\\\\\       \\\\\\\\\\\\\\\\\\\\   \\\\\\\\\\\\\\\\\\\\\\\\\\\      \\\\\\\\\\\\\\\\\\\\\\\          \\\\\\\\\\\",0


Level3 db "/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////",0ah
       db "  @                 |                                                                      |                     @   ",0ah
       db "     ///////////    |   o                              oo                                  |                         ",0ah
       db "     //       o     |   o     |////////////         ///////////             oo             |                         ",0ah
       db "     //       //////|/  o     |                                         |///////////       |       |/////////        ",0ah
       db "         o    |      |        |              o           o o o          |                  |       |                 ",0ah
       db " ////////     |  o   |   @    |       oo                                |                  |       |        //////// ",0ah
       db "              |  o   |        |     //////         |////////      //////|    o                     |                 ",0ah
       db "    o         |      |/////////                    |                  |      o                     |             o   ",0ah
       db "    o         |  o                                 |     o o o o      |                            |/////////    o   ",0ah
       db "    o         |            oo            oo        | @           @    |            //            @|             o   ",0ah
       db "    o         | o       ////////       //////      ////////////////////            //      ////////| o      /////////",0ah
       db "    o  ///////|                                              |                     //              |                 ",0ah
       db "    o         |  o              oo                           |            o o o   @//              |////////         ",0ah
       db "    o   o     |       //////////////////////                 |         /////////////                                 ",0ah
       db "//////  o     |   o              |                           |                                         o o o         ",0ah
       db "        o     |                  |         o o o o o o o     |                                     |                 ",0ah
       db "        o     |    o             |                           |    o o o o                          |                 ",0ah
       db "        o     //////////////     |///////////      ///////////////////////////           /////////////  o o o        ",0ah
       db "        o                                                                    |                                       ",0ah
       db "                    ||                                o o o o o o o o        |   o o o o  o o     /////////////      ",0ah
       db "                    ||                                                       |                                       ",0ah
       db "////////////////////||///////////////////////////////////////////////////////////////////////////////////////////////",0

;==============================================================================================================================================
.code

clear_screen proc
    mov ecx,29   
 L1:
    mov dl,0
    mov dh,cl
    call Gotoxy
         mov edx, offset clear
        call WriteString
    LOOP L1
    ret
clear_screen endp

   ;===========================================WELCOME======================================
    welcome_screen proc
        ;===========================RESET=================================
        call Clrscr
        mov score,0
        mov inputChar,0
        mov Restar,0
        MOV xPos,20
        MOV yPos,20

        ;=================================================================
    ; Back ground
     mov eax,white ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,10
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET pacman_welcome
    call WriteString
    mov dl,4
    mov dh,3
    call Gotoxy
    mov edx,OFFSET pacman_welcome1
    call WriteString
                
                    ;================= User Name================
    mov dl,10
    mov dh,13
    call Gotoxy
    mov edx, offset user_ask
    call WriteString
    mov edx,offset user_name
    mov ecx,15
    call ReadString
    mov user_length,eax
    mov byte ptr[edx+eax],0ah
    add user_length,1

            call clear_screen
    ret
    welcome_screen endp
;===============================================MENU=====================================================
Main_Menu proc
here:
       ; Back ground
     mov eax,white ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,10
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET pacman_welcome
    call WriteString
    mov dl,4
    mov dh,3
    call Gotoxy
    mov edx,OFFSET pacman_welcome1
    call WriteString
                    ;====Options====
    mov dl,10
    mov dh,13
    call Gotoxy
    mov edx, offset Menu_game
    call WriteString
    call ReadChar
        cmp al,'E'
        je endGame
        cmp al,'I'
         je instruction
        cmp al,'N'
        je select_level
            call clear_screen
            ret
endGame:
    exit
    ;==============================Instructions====================
instruction:
    mov dl,0
    mov dh,13
    call Gotoxy
    mov edx, offset instruct
    call WriteString
    call ReadChar
                call clear_screen
        cmp al,'B'
        je here
  select_level:
    mov dl,0
    mov dh,13
    call Gotoxy
    mov edx, offset level_Menu
    call WriteString
    call ReadChar
         cmp al,'1'
        jne else1
        mov game_level,1
                        call clear_screen
            ret
       else1: 
           cmp al,'2'
            jne else2
            mov game_level,2
            ret
       else2:
            mov game_level,3
                call clear_screen
      ret  
Main_Menu endp

END_GAME proc
    call clear_screen
   ; Back ground
     mov eax,white ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,10
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET pacman_welcome
    call WriteString
    mov dl,4
    mov dh,3
    call Gotoxy
    mov edx,OFFSET pacman_welcome1
    call WriteString
    mov dl,30
    mov dh,15
    call Gotoxy
    mov edx,OFFSET end_game_str
    call WriteString 
    ;////////////////////file handling////////////////////////////////
    ; Write the username to the output file.
    mov eax, fileHandle
    mov edx, OFFSET user_name
    mov ecx, user_length
    call WriteToFile

    movzx ax,score
    mov ecx,4
     mov edi,offset scorestring
L1:
    mov bl,10
    div bl
    mov [edi],al
    movzx ax,ah
    loop L1
    mov edx,offset scorestring 
    call WriteString

    ; Write the scores to the output file.
    mov eax, fileHandle
    mov edx,offset scorestring
    mov ecx,6
    call WriteToFile
    call Crlf
    ;////////////////////file handling/////////////////////////////////
    call ReadChar
    cmp al,'R'
    jne quit
     mov Restar,1
     jmp end_1
quit:  
        call CloseFile
    exit
end_1:
ret
END_GAME endp

;===================================Game Background===============================
Draw_background proc
    ; draw ground at (0,29):
    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,27
    mov dh,2
    l1:
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc dh
    loop l1


    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
ret
Draw_background endp

;==============================================================================================
main PROC
 ; Create a new text file.
    mov edx, OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax

    ; Check for errors.
    cmp eax, INVALID_HANDLE_VALUE ; error found?
    jne file_ok
    ; no: skip
    mov edx, OFFSET str1
    ; display error
    call WriteString
    jmp end_game_loop

file_ok:
   NEW_GAME::
   ;===============================================
     INVOKE PlaySound, OFFSET file, NULL, SND_ASYNC     
   ;===============================================

                       ;welcome screen
                                call welcome_screen
                                call Main_Menu 
                                call Draw_background
                                call DrawPlayer
                            ;=======================levels====================
                            cmp game_level,1
                            jne next
                              ;call Drawlevel1
                                    call DrawLevel_1

                               jmp end_level
                            next:
                                cmp game_level,2
                                jne next2
                                                              call create_ghost
                                call Drawlevel2
                                jmp end_level
                            next2:
                                                          call create_ghost
                                 call Drawlevel3
                        end_level:
                            ;====================================
                                call Draw_coins
                                call Randomize
    gameLoop:

    ;=======================levels====================
                            cmp game_level,1
                            jne next3
                                mov eax,180
                                call Delay
                                ;////////////////for roll_number//////////////////
                               ;call Drawlevel1
                               ;call check_coins
                               ;call Check_collision
                               ;////////////////for roll_number//////////////////
                               call Check_collis
                                  cmp score,89 
                                  jg end_game_loop 
                               jmp end_level2
                            next3:
                                cmp game_level,2
                                jne next4
                                 mov eax,150
                                call Delay
                                ; Update Ghost
                                          call update_ghost
                                          call update_ghost2
                                          call update_ghost3
                                          call update_ghost4
                                                  call check_lives
                                call Check_collision2
                                cmp score,100
                                  jg end_game_loop 
                                jmp end_level2
                            next4:
                                mov eax,100
                                call Delay
                                ; Update Ghost
                                          call update_ghost
                                          call update_ghost2
                                          call update_ghost3
                                          call update_ghost4
                                       call check_lives
                                
                                 call Check_collision3
                        end_level2:
    ;====================================================
        mov eax,white ;(black * 16)
        call SetTextColor
        call draw_score 
        call DrawLives
         
         cmp Lives,0
         jle end_game_loop

         mov eax,4
         call RandomRange
                      ; get user key input:
                        mov al,inputChar
                        call readkey
                        cmp al,1
                        je no_key
                        cmp al,'p'
                        je Pause_Menu
                        mov inputChar, al   
                        no_key:
continue:
      ; ===========================exit game if user types 'x'=========================:
        cmp inputChar,"x"
        je end_game_loop

      mov dl,yPos
      mov yPP,dl
      mov dl,xPos
      mov xPP,dl
      ;==================================movement========================
        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        jmp gameLoop
        moveUp:

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop

        moveDown:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop

    jmp gameLoop

    end_game_loop:
            call END_GAME
        cmp Restar,1
        je NEW_GAME
    exit

pause_Menu:
    call ReadChar 
    jmp continue
main ENDP
;===========================Level _ 1======================================
Drawlevel1 proc
mov eax,yellow
    call SetTextColor

   mov ecx,10
   mov al,1
   mov ah,0
   mov esi,0
L1:
    mov [level1_x+esi],10
    mov [level1_y+esi],ah
        add ah,3
    inc esi
    LOOP L1   
    mov ecx,10
    mov esi,1
L2:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
    call Gotoxy
       mov edx,offset level1
       call WriteString
    inc esi
    LOOP L2

   mov ecx,10
   mov ah,0
   mov esi,11
L3:
    mov [level1_x+esi],80
    mov [level1_y+esi],ah
        add ah,3
    inc esi
    LOOP L3   
    mov ecx,9
    mov esi,12
L4:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
    call Gotoxy
       mov edx,offset level1
       call WriteString
    inc esi
    LOOP L4
    ret
Drawlevel1 endp
;==============Level2==========
Drawlevel2 proc
    mov eax,blue
    call SetTextColor
    mov dh,3
    mov dl,2
    call Gotoxy
        mov edx,offset Level2

L1:
 mov eax,blue
    call SetTextColor
    mov al,[edx]
        cmp al,0
        je exit_1
        cmp al,'o'
        jne else1
            mov bl,al
             mov eax,yellow
            call SetTextColor
            mov al,bl
            jmp exit_con
    else1:
        cmp al,'@'
        jne else2
            mov bl,al
             mov eax,white
            call SetTextColor
            mov al,bl
            jmp exit_con    
    else2:
    exit_con:
    call WriteChar
    inc edx
    jmp L1
exit_1:
    ret
Drawlevel2 endp

Drawlevel3 proc
    mov eax,blue
    call SetTextColor
    mov dh,3
    mov dl,2
    call Gotoxy
        mov edx,offset Level3

L1:
 mov eax,blue
    call SetTextColor
    mov al,[edx]
        cmp al,0
        je exit_1
        cmp al,'o'
        jne else1
            mov bl,al
             mov eax,yellow
            call SetTextColor
            mov al,bl
            jmp exit_con
    else1:
        cmp al,'@'
        jne else2
            mov bl,al
             mov eax,white
            call SetTextColor
            mov al,bl
            jmp exit_con    
    else2:
    exit_con:
    call WriteChar
    inc edx
    jmp L1
exit_1:
    ret
Drawlevel3 endp
DrawLevel_1 proc
    mov eax,blue
    call SetTextColor
    mov dh,3
    mov dl,2
    call Gotoxy
        mov edx,offset Level_1

L1:
 mov eax,blue
    call SetTextColor
    mov al,[edx]
        cmp al,0
        je exit_1
        cmp al,'o'
        jne else1
            mov bl,al
             mov eax,yellow
            call SetTextColor
            mov al,bl
            jmp exit_con
    else1:
        cmp al,'@'
        jne else2
            mov bl,al
             mov eax,white
            call SetTextColor
            mov al,bl
            jmp exit_con    
    else2:
    exit_con:
    call WriteChar
    inc edx
    jmp L1
exit_1:
    ret 
DrawLevel_1 endp

;==================================Coins==================================
Draw_coins proc

     mov ecx,10
    mov esi,1
L2:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
    sub dh,1
    mov eax,red
    call SetTextColor
    call Gotoxy
    mov edx,offset coin1
    call WriteString
     add esi,2
    LOOP L2

    ret
Draw_coins endp

check_coins proc
mov ecx,10
    mov esi,1
L2:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
    add dl,2
    sub dh,1
    cmp xPos, dl        ; compare xPos with dl
    jl  not_decrement  ; jump to not_decrement if xPos < dl
    add dl,11
    cmp xPos,dl  ; compare xPos with dl+15
    jg  not_decrement  ; jump to not_decrement if xPos > dl+15
    cmp dh,yPos     ; compare yPos with dh
    jne not_decrement  ; jump to not_decrement if yPos != dh
    ; Decrement xPos
        inc score
not_decrement:
     add esi,2
    LOOP L2

check_coins endp


;=================================collision=========================
Check_collis proc
; Calculate the position of Pac-Man in the level
    mov eax,118
    movzx ebx, yPos
    dec ebx
        dec ebx
        dec ebx

    imul eax,ebx
    movzx edi,xPos; Multiply yPos by the width
    mov esi,eax
    add esi,edi ; Add xPos to get the position in the 1D array

    ; Check if Pac-Man collides with any obstacle in level 2
    mov edi,offset Level_1
    add edi,esi
    mov al, [Level_1 + esi]
    cmp al, '|'    
    je  PacmanHitObstacle
    cmp al, '/'    
    je  PacmanHitObstacle
    cmp al, '\'    
    je  PacmanHitObstacle


    ; Check if Pac-Man collects a coin
    mov al, [Level_1 + esi]
    cmp al, 'o'
    je  PacmanCollectsCoin
    cmp al, '@'
    jne  other
        add score,10
other:
    ret
PacmanHitObstacle:
    mov bl,xPos
    mov bh,yPos
    mov cl,al
            call UpdatePlayer
    mov dl,yPP
    mov yPos,dl
    mov dl,xPP
    mov xPos,dl
            call DrawPlayer
    mov eax,blue
    call SetTextColor
    mov dl,bl
    mov dh,bh
    call Gotoxy
    mov al,cl
    call WriteChar

    ret

PacmanCollectsCoin:
    inc score
ret
Check_collis endp

Check_collision proc
       mov ecx,10
    mov esi,1
L2:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
   
    cmp xPos, dl        ; compare xPos with dl
    jl  not_decrement  ; jump to not_decrement if xPos < dl
    add dl,15
    cmp xPos,dl  ; compare xPos with dl+15
    jg  not_decrement  ; jump to not_decrement if xPos > dl+15
    cmp dh,yPos     ; compare yPos with dh
    jne not_decrement  ; jump to not_decrement if yPos != dh

    ; Decrement xPos
            call UpdatePlayer
    mov dl,yPP
    mov yPos,dl
    mov dl,xPP
    mov xPos,dl
            call DrawPlayer

not_decrement:
    inc esi
    LOOP L2

    mov ecx,10
    mov esi,11
L3:
    mov dl,[level1_x+esi]
    mov dh,[level1_y+esi]
   
    cmp xPos, dl        ; compare xPos with dl
    jl  not_decrement2  ; jump to not_decrement if xPos < dl
    add dl,15
    cmp xPos,dl  ; compare xPos with dl+15
    jg  not_decrement2  ; jump to not_decrement if xPos > dl+15
    cmp dh,yPos     ; compare yPos with dh
    jne not_decrement2  ; jump to not_decrement if yPos != dh

    ; Decrement xPos
      call UpdatePlayer
    mov dl,yPP
    mov yPos,dl
      call DrawPlayer

not_decrement2:
    inc esi
    LOOP L3
ret
ret
Check_collision endp

Check_collision2 proc
    ; Calculate the position of Pac-Man in the level
    mov eax,118
    movzx ebx, yPos
    dec ebx
        dec ebx
        dec ebx

    imul eax,ebx
    movzx edi,xPos; Multiply yPos by the width
    mov esi,eax
    add esi,edi ; Add xPos to get the position in the 1D array

    ; Check if Pac-Man collides with any obstacle in level 2
    mov edi,offset Level2
    add edi,esi
    mov al, [Level2 + esi]
    cmp al, '|'    
    je  PacmanHitObstacle
    cmp al, '/'    
    je  PacmanHitObstacle
    cmp al, '\'    
    je  PacmanHitObstacle


    ; Check if Pac-Man collects a coin
    mov al, [Level2 + esi]
    cmp al, 'o'
    je  PacmanCollectsCoin
    cmp al, '@'
    jne  other
        add score,20
other:
    ret
PacmanHitObstacle:
    mov bl,xPos
    mov bh,yPos
    mov cl,al
            call UpdatePlayer
    mov dl,yPP
    mov yPos,dl
    mov dl,xPP
    mov xPos,dl
            call DrawPlayer
    mov eax,blue
    call SetTextColor
    mov dl,bl
    mov dh,bh
    call Gotoxy
    mov al,cl
    call WriteChar

    ret

PacmanCollectsCoin:
    inc score
ret
Check_collision2 endp

;=======================level3=============================
Check_collision3 proc
    ; Calculate the position of Pac-Man in the level
    mov eax,118
    movzx ebx, yPos
    dec ebx
        dec ebx
        dec ebx

    imul eax,ebx
    movzx edi,xPos; Multiply yPos by the width
    mov esi,eax
    add esi,edi ; Add xPos to get the position in the 1D array

    ; Check if Pac-Man collides with any obstacle in level 2
    mov edi,offset Level3
    add edi,esi
    mov al, [Level3 + esi]
    cmp al, '|'    
    je  PacmanHitObstacle
    cmp al, '/'    
    je  PacmanHitObstacle
    cmp al, '\'    
    je  PacmanHitObstacle


    ; Check if Pac-Man collects a coin
    mov al, [Level3 + esi]
    cmp al, 'o'
    je  PacmanCollectsCoin
    cmp al, '@'
    jne  other
        add score,20
other:
    ret

PacmanHitObstacle:
    mov bl,xPos
    mov bh,yPos
    mov cl,al
            call UpdatePlayer
    mov dl,yPP
    mov yPos,dl
    mov dl,xPP
    mov xPos,dl
            call DrawPlayer
    mov eax,blue
    call SetTextColor
    mov dl,bl
    mov dh,bh
    call Gotoxy
    mov al,cl
    call WriteChar

    ret

PacmanCollectsCoin:
    inc score
    ret

Check_collision3 endp


;===========================
check_lives proc    
                    mov bl,xg1
                    mov bh,xPos
                .if(bl==bh)
                    mov bl,yg1
                    mov bh,yPos
                    .if (bl==bh)
                             dec Lives
                             mov yPos,10
                            mov xPos,100
                     .else
                     .endif
                .else
                .endif
                  mov bl,xg2
                    mov bh,xPos
                .if(bl==bh)
                    mov bl,yg2
                    mov bh,yPos
                    .if (bl==bh)
                             dec Lives
                             mov dl,xPos
                             mov dh,yPos
                                call Gotoxy
                            mov al," "
                            call WriteChar
                             mov yPos,10
                            mov xPos,100 
                     .else
                     .endif
                .else
                .endif
                mov bl,xg3
                    mov bh,xPos
                .if(bl==bh)
                    mov bl,yg3
                    mov bh,yPos
                    .if (bl==bh)
                             dec Lives
                             mov dl,xPos
                             mov dh,yPos
                                call Gotoxy
                            mov al," "
                            call WriteChar
                             mov yPos,10
                            mov xPos,100
                     .endif
                .else
                .endif
                mov bl,xg4
                    mov bh,xPos
                .if(bl==bh)
                    mov bl,yg4
                    mov bh,yPos
                    .if (bl==bh)
                             dec Lives
                             mov dl,xPos
                             mov dh,yPos
                                call Gotoxy
                            mov al," "
                            call WriteChar
                            mov yPos,10
                            mov xPos,100  
                     .else
                     .endif
                .else
                .endif
ret
check_lives endp

create_ghost proc
push eax
push edx
    ;--1--
    mov eax,white
    call SetTextColor
    mov dl,100
            mov xg1,dl
    mov dh,15
            mov yg1,dh
    call Gotoxy
    mov al,"A"
    call WriteChar
    ;--2--
    mov eax,red
    call SetTextColor
    mov dl,50
            mov xg2,dl
    mov dh,20
            mov yg2,dh
    call Gotoxy
    mov al,"A"
    call WriteChar
    ;--3--
    mov eax,cyan
    call SetTextColor
    mov dl,60
             mov xg3,dl
    mov dh,14
            mov yg3,dh
    call Gotoxy
    mov al,"A"
    call WriteChar
    ;--4--
    mov eax,green
    call SetTextColor
    mov dl,30
            mov xg4,dl
    mov dh,20
            mov yg4,dh
    call Gotoxy
    mov al,"A"
    call WriteChar

    pop edx
    pop eax
ret
create_ghost endp
;=============================================
update_ghost proc
    ;---1-------------------------------------------
         
    mov dl,xg1
    mov dh,yg1
    call Gotoxy
    mov al," "
    call WriteChar
    
            ;///////////LOGIC//////////////
             mov dl,xg1
             mov xprev,dl
             mov dh,yg1
             mov yprev,dh
            mov eax,5
             call RandomRange
                cmp eax,1
                jne next1
                    inc xg1
                    jmp end_con
            next1:
                cmp eax,2
                jne next2
                    dec xg1
                    jmp end_con
            next2:
                cmp eax,3
                jne next3
                    inc yg1
                    jmp end_con
            next3:
                    dec yg1 
            end_con:
                .if(xg1<3)
                    mov eax,117
                    call RandomRange
                    mov xg1,al
                    mov eax,27
                            call RandomRange
                            mov yg1,al
                .else
                    .if(xg1>117)
                         mov eax,117
                            call RandomRange
                            mov xg1,al
                            mov eax,27
                            call RandomRange
                            mov yg1,al
                    .else
                           ;do  nothing
                    .endif
                .endif
                .if(yg1<2)
                            mov eax,27
                            call RandomRange
                            mov yg1,al
                            mov eax,117
                            call RandomRange
                            mov xg1,al
                .else
                    .if(yg1>27)
                         mov eax,27
                            call RandomRange
                            mov yg1,al
                            mov eax,117
                            call RandomRange
                            mov xg1,al
                    .else
                           ;do  nothing
                    .endif
                .endif
 mov eax,white
    call SetTextColor
    mov dl,xg1
    mov dh,yg1
    call Gotoxy
    mov al,"A"
    call WriteChar
                ;==================================================////////////////////////////////

                         cmp game_level,1
                            jne next31
                                ;=======================level 1 collision================================
                                ;=========================================
                               jmp end_level2
                            next31:
                                cmp game_level,2
                                jne next41
                                 ;=======================level 2 collision================================
                                    mov eax,118
                                    movzx ebx, yg1
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg1; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level2
                                    add edi,esi
                                    mov al, [Level2 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle
                                    cmp al, '/'    
                                    je  PacmanHitObstacle
                                    cmp al, '\'    
                                    je  PacmanHitObstacle


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level2 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin
                                ret
                                PacmanHitObstacle:
                                    mov bl,xg1
                                    mov bh,yg1
                                    mov cl,al
                                           ;========
                                                        mov dl,xg1
                                                        mov dh,yg1
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg1,dl
                                    mov dl,xprev
                                    mov xg1,dl
                                            mov eax,white
                                                    call SetTextColor
                                                    mov dl,xg1
                                                    mov dh,yg1
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin:
                                  mov eax,yellow
                                    call SetTextColor
                                    mov dl,xg1
                                    mov dh,yg1
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg1
                                ;=========================================
                                jmp end_level2
                            next41:
                                ;=======================level 3 collision================================
                                    mov eax,118
                                    movzx ebx, yg1
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg1; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level3
                                    add edi,esi
                                    mov al, [Level3 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle2
                                    cmp al, '/'    
                                    je  PacmanHitObstacle2
                                    cmp al, '\'    
                                    je  PacmanHitObstacle2


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level3 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin2
                                ret
                                PacmanHitObstacle2:
                                    mov bl,xg1
                                    mov bh,yg1
                                    mov cl,al
                                           ;========
                                                        mov dl,xg1
                                                        mov dh,yg1
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg1,dl
                                    mov dl,xprev
                                    mov xg1,dl
                                            mov eax,white
                                                    call SetTextColor
                                                    mov dl,xg1
                                                    mov dh,yg1
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin2:
                                    mov dl,xg1
                                    mov dh,yg1
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg1
                                ;========================================= 
                        end_level2:
                ;//////////////////////////////////////=================================================
           ; //////////////////////
   
    ;-------------------------------------------------
ret
 
update_ghost endp
;///////////////////////////////////////////////////////2//////////////////////////////////////
update_ghost2 proc
  ;---2-------------------------------------------
         
    mov dl,xg2
    mov dh,yg2
    call Gotoxy
    mov al," "
    call WriteChar
    
            ;///////////LOGIC//////////////
             mov dl,xg2
             mov xprev,dl
             mov dh,yg2
             mov yprev,dh
            mov eax,5
             call RandomRange
                cmp eax,1
                jne next1
                    inc xg2
                    jmp end_con
            next1:
                cmp eax,2
                jne next2
                    dec xg2
                    jmp end_con
            next2:
                cmp eax,3
                jne next3
                    inc yg2
                    jmp end_con
            next3:
                    dec yg2 
            end_con:
                .if(xg2<3)
                    mov eax,117
                    call RandomRange
                    mov xg2,al
                    mov eax,27
                            call RandomRange
                            mov yg2,al
                .else
                    .if(xg2>117)
                         mov eax,117
                            call RandomRange
                            mov xg2,al
                            mov eax,27
                            call RandomRange
                            mov yg2,al
                    .else
                           ;do  nothing
                    .endif
                .endif
                .if(yg2<2)
                            mov eax,27
                            call RandomRange
                            mov yg2,al
                            mov eax,117
                            call RandomRange
                            mov xg2,al
                .else
                    .if(yg2>27)
                         mov eax,27
                            call RandomRange
                            mov yg2,al
                            mov eax,117
                            call RandomRange
                            mov xg2,al
                    .else
                           ;do  nothing
                    .endif
                .endif
 mov eax,red
    call SetTextColor
    mov dl,xg2
    mov dh,yg2
    call Gotoxy
    mov al,"A"
    call WriteChar
                ;==================================================////////////////////////////////

                         cmp game_level,1
                            jne next31
                                ;=======================level 1 collision================================
                                ;=========================================
                               jmp end_level2
                            next31:
                                cmp game_level,2
                                jne next41
                                 ;=======================level 2 collision================================
                                    mov eax,118
                                    movzx ebx, yg2
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg2; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level2
                                    add edi,esi
                                    mov al, [Level2 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle
                                    cmp al, '/'    
                                    je  PacmanHitObstacle
                                    cmp al, '\'    
                                    je  PacmanHitObstacle


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level2 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin
                                ret
                                PacmanHitObstacle:
                                    mov bl,xg2
                                    mov bh,yg2
                                    mov cl,al
                                           ;========
                                                        mov dl,xg2
                                                        mov dh,yg2
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg2,dl
                                    mov dl,xprev
                                    mov xg2,dl
                                            mov eax,red
                                                    call SetTextColor
                                                    mov dl,xg2
                                                    mov dh,yg2
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin:
                                 mov eax,yellow
                                 call SetTextColor
                                    mov dl,xg2
                                    mov dh,yg2
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg2
                                ;=========================================
                                jmp end_level2
                            next41:
                                 ;=======================level 3 collision================================
                                    mov eax,118
                                    movzx ebx, yg2
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg2; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level3
                                    add edi,esi
                                    mov al, [Level3 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle2
                                    cmp al, '/'    
                                    je  PacmanHitObstacle2
                                    cmp al, '\'    
                                    je  PacmanHitObstacle2


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level3 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin2
                                ret
                                PacmanHitObstacle2:
                                    mov bl,xg2
                                    mov bh,yg2
                                    mov cl,al
                                           ;========
                                                        mov dl,xg2
                                                        mov dh,yg2
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg2,dl
                                    mov dl,xprev
                                    mov xg2,dl
                                            mov eax,white
                                                    call SetTextColor
                                                    mov dl,xg2
                                                    mov dh,yg2
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin2:
                                 mov eax,white
                                    call SetTextColor
                                    mov dl,xg2
                                    mov dh,yg2
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg2
                                ;========================================= 
                        end_level2:
                ;//////////////////////////////////////=================================================
           ; //////////////////////
   
    ;-------------------------------------------------
ret
update_ghost2 endp


;/////////////////////////////////////3////////////////////////////////////////
update_ghost3 proc
    ;---1-------------------------------------------
         
    mov dl,xg3
    mov dh,yg3
    call Gotoxy
    mov al," "
    call WriteChar
    
            ;///////////LOGIC//////////////
             mov dl,xg3
             mov xprev,dl
             mov dh,yg3
             mov yprev,dh
            mov eax,5
             call RandomRange
                cmp eax,1
                jne next1
                    inc xg3
                    jmp end_con
            next1:
                cmp eax,2
                jne next2
                    dec xg3
                    jmp end_con
            next2:
                cmp eax,3
                jne next3
                    inc yg3
                    jmp end_con
            next3:
                    dec yg3 
            end_con:
                .if(xg3<3)
                    mov eax,117
                    call RandomRange
                    mov xg3,al
                    mov eax,27
                            call RandomRange
                            mov yg3,al
                .else
                    .if(xg3>117)
                         mov eax,117
                            call RandomRange
                            mov xg3,al
                            mov eax,27
                            call RandomRange
                            mov yg3,al
                    .else
                           ;do  nothing
                    .endif
                .endif
                .if(yg3<2)
                            mov eax,27
                            call RandomRange
                            mov yg3,al
                            mov eax,117
                            call RandomRange
                            mov xg3,al
                .else
                    .if(yg3>27)
                         mov eax,27
                            call RandomRange
                            mov yg3,al
                            mov eax,117
                            call RandomRange
                            mov xg3,al
                    .else
                           ;do  nothing
                    .endif
                .endif
 mov eax,cyan
    call SetTextColor
    mov dl,xg3
    mov dh,yg3
    call Gotoxy
    mov al,"A"
    call WriteChar
                ;==================================================////////////////////////////////

                         cmp game_level,1
                            jne next31
                                ;=======================level 1 collision================================
                                ;=========================================
                               jmp end_level2
                            next31:
                                cmp game_level,2
                                jne next41
                                 ;=======================level 2 collision================================
                                    mov eax,118
                                    movzx ebx, yg3
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg3; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level2
                                    add edi,esi
                                    mov al, [Level2 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle
                                    cmp al, '/'    
                                    je  PacmanHitObstacle
                                    cmp al, '\'    
                                    je  PacmanHitObstacle


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level2 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin
                                ret
                                PacmanHitObstacle:
                                    mov bl,xg3
                                    mov bh,yg3
                                    mov cl,al
                                           ;========
                                                        mov dl,xg3
                                                        mov dh,yg3
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg3,dl
                                    mov dl,xprev
                                    mov xg3,dl
                                            mov eax,cyan
                                                    call SetTextColor
                                                    mov dl,xg3
                                                    mov dh,yg3
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin:
                                 mov eax,yellow
                                                    call SetTextColor
                                    mov dl,xg3
                                    mov dh,yg3
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg3
                                ;=========================================
                                jmp end_level2
                            next41:
                                ;=======================level 3 collision================================
                                    mov eax,118
                                    movzx ebx, yg3
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg3; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level3
                                    add edi,esi
                                    mov al, [Level3 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle2
                                    cmp al, '/'    
                                    je  PacmanHitObstacle2
                                    cmp al, '\'    
                                    je  PacmanHitObstacle2


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level3 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin2
                                ret
                                PacmanHitObstacle2:
                                    mov bl,xg3
                                    mov bh,yg3
                                    mov cl,al
                                           ;========
                                                        mov dl,xg3
                                                        mov dh,yg3
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov yg3,dl
                                    mov dl,xprev
                                    mov xg3,dl
                                            mov eax,cyan
                                                    call SetTextColor
                                                    mov dl,xg3
                                                    mov dh,yg3
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin2:
                                mov eax,yellow
                                    call SetTextColor
                                    mov dl,xg3
                                    mov dh,yg3
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg3
                                ;========================================= 
                        end_level2:
                ;//////////////////////////////////////=================================================
           ; //////////////////////
   
    ;-------------------------------------------------
ret
 
update_ghost3 endp
;/////////////////////////////////////4////////////////////////////////////////
update_ghost4 proc
    ;---1-------------------------------------------
         
    mov dl,xg4
    mov dh,xg4
    call Gotoxy
    mov al," "
    call WriteChar
    
            ;///////////LOGIC//////////////
             mov dl,xg4
             mov xprev,dl
             mov dh,xg4
             mov yprev,dh
            mov eax,5
             call RandomRange
                cmp eax,1
                jne next1
                    inc xg4
                    jmp end_con
            next1:
                cmp eax,2
                jne next2
                    dec xg4
                    jmp end_con
            next2:
                cmp eax,3
                jne next3
                    inc xg4
                    jmp end_con
            next3:
                    dec xg4 
            end_con:
                .if(xg4<3)
                    mov eax,117
                    call RandomRange
                    mov xg4,al
                    mov eax,27
                            call RandomRange
                            mov xg4,al
                .else
                    .if(xg4>117)
                         mov eax,117
                            call RandomRange
                            mov xg4,al
                            mov eax,27
                            call RandomRange
                            mov xg4,al
                    .else
                           ;do  nothing
                    .endif
                .endif
                .if(xg4<2)
                            mov eax,27
                            call RandomRange
                            mov xg4,al
                            mov eax,117
                            call RandomRange
                            mov xg4,al
                .else
                    .if(xg4>27)
                         mov eax,27
                            call RandomRange
                            mov xg4,al
                            mov eax,117
                            call RandomRange
                            mov xg4,al
                    .else
                           ;do  nothing
                    .endif
                .endif
 mov eax,green
    call SetTextColor
    mov dl,xg4
    mov dh,xg4
    call Gotoxy
    mov al,"A"
    call WriteChar
                ;==================================================////////////////////////////////

                         cmp game_level,1
                            jne next31
                                ;=======================level 1 collision================================
                                ;=========================================
                               jmp end_level2
                            next31:
                                cmp game_level,2
                                jne next41
                                 ;=======================level 2 collision================================
                                    mov eax,118
                                    movzx ebx, xg4
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg4; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level2
                                    add edi,esi
                                    mov al, [Level2 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle
                                    cmp al, '/'    
                                    je  PacmanHitObstacle
                                    cmp al, '\'    
                                    je  PacmanHitObstacle


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level2 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin
                                ret
                                PacmanHitObstacle:
                                    mov bl,xg4
                                    mov bh,xg4
                                    mov cl,al
                                           ;========
                                                        mov dl,xg4
                                                        mov dh,xg4
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov xg4,dl
                                    mov dl,xprev
                                    mov xg4,dl
                                            mov eax,green
                                                    call SetTextColor
                                                    mov dl,xg4
                                                    mov dh,xg4
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin:
                                 mov eax,yellow
                                                    call SetTextColor
                                    mov dl,xg4
                                    mov dh,xg4
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg4
                                ;=========================================
                                jmp end_level2
                            next41:
                                ;=======================level 3 collision================================
                                    mov eax,118
                                    movzx ebx, xg4
                                    dec ebx
                                        dec ebx
                                        dec ebx
                                    imul eax,ebx
                                    movzx edi,xg4; Multiply yPos by the width
                                    mov esi,eax
                                    add esi,edi

                                    ; Check if ghost collides with any obstacle in level 2
                                    mov edi,offset Level3
                                    add edi,esi
                                    mov al, [Level3 + esi]
                                    cmp al, '|'    
                                    je  PacmanHitObstacle2
                                    cmp al, '/'    
                                    je  PacmanHitObstacle2
                                    cmp al, '\'    
                                    je  PacmanHitObstacle2


                                    ; Check if Pac-Man collects a coin
                                    mov al, [Level3 + esi]
                                    cmp al, 'o'
                                    je  PacmanCollectsCoin2
                                ret
                                PacmanHitObstacle2:
                                    mov bl,xg4
                                    mov bh,xg4
                                    mov cl,al
                                           ;========
                                                        mov dl,xg4
                                                        mov dh,xg4
                                                        call Gotoxy
                                                        mov al," "
                                                        call WriteChar
                                           ;========

                                    mov dl,yprev
                                    mov xg4,dl
                                    mov dl,xprev
                                    mov xg4,dl
                                            mov eax,green
                                                    call SetTextColor
                                                    mov dl,xg4
                                                    mov dh,xg4
                                                    call Gotoxy
                                                    mov al,"A"
                                                    call WriteChar
                                    mov eax,blue
                                    call SetTextColor
                                    mov dl,bl
                                    mov dh,bh
                                    call Gotoxy
                                    mov al,cl
                                    call WriteChar

                                    ret

                                PacmanCollectsCoin2:
                                mov eax,yellow
                                    call SetTextColor
                                    mov dl,xg4
                                    mov dh,xg4
                                        call Gotoxy
                                    mov al,'o'
                                    call WriteChar
                                    inc xg4
                                ;========================================= 
                        end_level2:
                ;//////////////////////////////////////=================================================
           ; //////////////////////
   
    ;-------------------------------------------------
ret
 
update_ghost4 endp


;=============================


DrawLives PROC
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strLives
        call WriteString
        mov al,Lives
        call WriteInt
    ret
DrawLives ENDP
DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawCoin PROC
    mov eax,yellow ;(red * 16)
    call SetTextColor
    mov dl,xCoinPos
    mov dh,yCoinPos
    call Gotoxy
    mov al,"."
    call WriteChar
    ret
DrawCoin ENDP

CreateRandomCoin PROC
    mov eax,55
    inc eax
    call RandomRange
    mov xCoinPos,al
    call RandomRange
    mov yCoinPos,al
    ret
CreateRandomCoin ENDP

draw_score proc
 ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteInt
ret
draw_score endp

END main