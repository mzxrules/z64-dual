.n64
.relativeinclude on

.create "../roms/oot_mm.z64", 0
.incbin "../roms/base.z64"

;==============================================================================
; Constants
;==============================================================================

.include "addr.asm"
.include "constants.asm"

;==============================================================================
; G0 dmadata
;==============================================================================

;==============================================================================
; G0 Base editing region
;==============================================================================

.include "makerom.asm"
.include "boot.asm"
.include "G0/boot.asm"

;==============================================================================
; G1 Base editing region
;==============================================================================

.include "G1/boot.asm"
.include "G1/code.asm"

;==============================================================================
; New code region
;==============================================================================

.headersize (0x80400000 - 0x03480000)

.org 0x80400000
; .importobj "../build/bundle.o"
.close