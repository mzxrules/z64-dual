.headersize (0x800A5AC0-0xB3C000 - G1_ADDR)


.org 0x80190E5C   //audio seq lui/addiu
    lw      a1, G_G1_AUDIOSEQ

.org 0x80190E70   //audio bank
    lw      a1, G_G1_AUDIOBANK

.org 0x80190E84   //audio table
    lw      a1, G_G1_AUDIOTABLE