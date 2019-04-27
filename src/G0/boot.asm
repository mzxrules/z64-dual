.headersize(0x80000460 - 0x1060)
.org 0x80000E70
    lui     v0, hi(G_G0_DMADATA)
    addiu   v0, v0, lo(G_G0_DMADATA)
    sw      ra, 0x001C(sp)
    lui     t6, hi(G_G0_DMADATA + G0_DMADATA_SIZE)
    addiu   t6, t6, lo(G_G0_DMADATA + G0_DMADATA_SIZE)
.org 0x80003260
    nop