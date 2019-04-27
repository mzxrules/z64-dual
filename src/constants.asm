.definelabel G_ENTRYPOINT,  0x80000400
.definelabel G_BOOT_ADDR, 0x7430  //must be within the first MB
.definelabel G_BOOT_ENTRYPOINT, (G_ENTRYPOINT + 0x7430 - 0x1000)
.definelabel G_SWAP_ENTRYPOINT, 0x80700000

//static static shared info
.definelabel G_G1_MAKEROM,  0x04000000-0x10000
.definelabel G_G0_DMADATA,  0x04000040-0x10000
.definelabel G_G1_DMADATA,  0x04000040-0x10000 + 0x6200
.definelabel G_G1_CART,     0xB0000000 + G_G1_DMADATA + 0x08
//\
//      (readu8("../roms/base.z64", G_G1_DMADATA + 0x08) << 24 )  \
//    + (readu8("../roms/base.z64", G_G1_DMADATA + 0x09) << 16)   \
//    + (readu8("../roms/base.z64", G_G1_DMADATA + 0x0A) << 8)    \
//    +  readu8("../roms/base.z64", G_G1_DMADATA + 0x0B)          \
    
.definelabel G_G1_AUDIOBANK,    0xB0000000 + G_G1_DMADATA + 0x38 
.definelabel G_G1_AUDIOSEQ,     0xB0000000 + G_G1_DMADATA + 0x48
.definelabel G_G1_AUDIOTABLE,   0xB0000000 + G_G1_DMADATA + 0x58

.definelabel G0_DMADATA_SIZE, 0x5F60

.definelabel G1_ENTRYPOINT, 0x80080000
.definelabel G1_ADDR, 0x4000000
.definelabel G1_DMADATA_SIZE, 0x6200
//.definelabel G1_DMADATA_ADDR, 0x01A500
//end 0x20700