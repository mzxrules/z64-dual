.headersize (G_ENTRYPOINT - 0x1000)
.org G_ENTRYPOINT
.area 0x60, 0
    la  t0, G_BOOT_ENTRYPOINT
    lui sp, 0x8078
    jr  t0
    addiu   sp, sp, 0x1FF0
    nop
.endarea