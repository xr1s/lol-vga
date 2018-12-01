.set MAX_COL, 319
.set MAX_ROW, 199
.set LOOP, (MAX_ROW + 1) / 2

.code16

  # initialize
  movw  $0x13, %ax
  int   $0x10

  movw  $0xc00, %ax  # color

loop:

  xorw  %cx, %cx     # col
  xorw  %dx, %dx     # row
  xorw  %bx, %bx     # circle

l2r:
  addb  $32, %al
  int   $0x10
  subb  $32, %al
  incw  %cx
  movw  %cx, %di
  addw  %bx, %di
  cmpw  $MAX_COL, %di
  jne   l2r

u2d:
  addb  $32, %al
  int   $0x10
  subb  $32, %al
  incw  %dx
  movw  %dx, %di
  addw  %bx, %di
  cmpw  $MAX_ROW, %di
  jne   u2d

r2l:
  addb  $32, %al
  int   $0x10
  subb  $32, %al
  decw  %cx
  movw  %cx, %di
  subw  %bx, %di
  cmpw  $0, %di
  jne   r2l

  incb  %al
  andb  $31, %al
  addw  $2, %bx
  cmpw  $LOOP, %bx
  je    loop

d2u:
  addb  $32, %al
  int   $0x10
  subb  $32, %al
  decw  %dx
  movw  %dx, %di
  subw  %bx, %di
  cmpw  $0, %di
  jne   d2u

  jmp   l2r

.org 510, 0x90
.word 0xaa55
