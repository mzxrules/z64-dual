.headersize(0x80080060 - G1_ADDR - 0x1060)

//Fix dmadata read
.org 0x80080D14
    lui     a0, hi(G_G1_DMADATA)
    lui     t6, hi(G_G1_DMADATA + G1_DMADATA_SIZE)
    addiu   t6, lo(G_G1_DMADATA + G1_DMADATA_SIZE)
    addiu   a0, a0, lo(G_G1_DMADATA)

//prevent osNmiBuffer from being wiped
.org 0x8008A8F0
    nop