PI_DRAM_ADDR_REG equ 0xA4600000
PI_CART_ADDR_REG equ 0xA4600004
PI_RD_LEN_REG equ 0xA4600008
PI_WR_LEN_REG equ 0xA460000C
PI_STATUS_REG equ 0xA4600010

.definelabel osInvalICache, 0x800041A0
.definelabel osInvalDCache, 0x80004250
.definelabel osWritebackDCache, 0x80003440
.definelabel bcopy, 0x80004DC0
.definelabel osGetCount, 0x80004D50