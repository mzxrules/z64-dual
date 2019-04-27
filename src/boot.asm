.headersize (G_BOOT_ENTRYPOINT - G_BOOT_ADDR)
.org G_BOOT_ENTRYPOINT
BOOT: 
    addiu   sp, sp, -0x20
    sw      s0, 0x18(sp)
    sw      s1, 0x1C(sp)

    // copy boot code into it's own address space
    la      s0, G_SWAP_ENTRYPOINT
    la      a0, G_BOOT_ENTRYPOINT
    addu    a1, s0, r0
    li      s1, G0_DMADATA_SIZE
    jal     bcopy
    addu    a2, s1, r0
    
    // flush the cache
    addu    a0, s0, r0
    jal     osWritebackDCache
    addu    a1, s1, r0

    addu    a0, s0, r0
    jal     osInvalICache
    addu    a1, s1, r0

    j       BOOT_3
    nop

.headersize (G_SWAP_ENTRYPOINT - G_BOOT_ADDR)
BOOT_3:
    //jal     osGetCount
    //nop
    lui     v1, 0x8000
    lb      v0, (0x031C+0x1C)(v1)
    andi    at, v0, 0x01
    addiu   v0, v0, 1
    bnez    at, @BOOT_G1
    sb      v0, (0x031C+0x1C)(v1)

@BOOT_G0:
    lw      s0, 0x18(sp)
    lw      s1, 0x1C(sp)

    //original boot
    li      t0, 0x80006830
    li      t1, 0x4910
@@L0:
    addi    t1, t1, -0x08
    sw      r0, 0x0000(t0)
    sw      r0, 0x0004(t0)
    bnez    t1, @@L0
    addi    t0, t0, 0x08
    li      t2, 0x80000498
    li      sp, 0x80007220
    jr      t2
    nop


@BOOT_G1: 
    
@@Loop:
    lw      t3, PI_STATUS_REG
    andi    at, t3, 0x03
    bnez    at, @@Loop
    nop

    la      t4, (0xB0000000 + G_G1_MAKEROM)
    lw      t0, 0x0008(t4)
    li      t1, 0x1FFFFFFF
    //
    lui     at, hi(PI_DRAM_ADDR_REG)
    and     t2, t0, t1
    sw      t2, lo(PI_DRAM_ADDR_REG)(at)

    lui     at, hi(PI_CART_ADDR_REG)
    lw      t6, G_G1_CART
    li      t7, 0xB0001000
    addu    t4, t6, t7
    and     t5, t4, t1
    sw      t5, lo(PI_CART_ADDR_REG)(at)

    lui     at, hi(PI_WR_LEN_REG)
    li      t3, 0xFFFFF
    sw      t3, lo(PI_WR_LEN_REG)(at)

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

@@Loop2:
    lw      t3, PI_STATUS_REG
    andi    at, t3, 0x03
    bnez    at, @@Loop2
    nop
    lw      s0, 0x18(sp)
    lw      s1, 0x1C(sp)

    jr      t0
    nop