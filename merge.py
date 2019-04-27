import io
import struct
from ntype import int32

## WARNING: Only implemented for decompressed roms

class Rom(object):
    def __init__(self, path, key, dma):
        self.path = path
        self.key = key
        self.dmadata = dma

    def dmadata_size(self):
        return self.dmadata[1]-self.dmadata[0]

class Static_Segment(object):
    def __init__(self, devAddr):
        self.addr = devAddr
        self.G1_makerom = self.addr
        self.G0_dmadata = self.addr + 0x40
        self.G1_dmadata = self.G0_dmadata + 0x6200

romA = Rom('roms/Ocarina (U10).z64', 'z', (0x7430, 0xD390))
romB = Rom('roms/Mask (U10).z64', 'z2', (0x01A500, 0x20700))

romOut = 'roms/base.z64'
dmaOut = 'resources/dmadata.z64'

shift = 0x4000000
static_seg = Static_Segment(shift - 0x10000)

def merge():
    vrom = []

    with open(romA.path, 'rb') as stream:
        vrom = bytearray(stream.read())

    # copy dmadata to new section
    start = static_seg.G0_dmadata
    end = start + romA.dmadata_size()
    vrom[start:end] = vrom[romA.dmadata[0]:romA.dmadata[1]]
    
    buffer = []
    with open(romB.path, 'rb') as stream:
        buffer = bytearray(stream.read())
    
    dmadata = dma_shift(buffer, romB.dmadata[0], shift)
    writedma(buffer, romB.dmadata[0], dmadata)

    # copy makerom header to new section
    start = static_seg.G1_makerom
    end = start + 0x40
    vrom[start:end] = buffer[0:0x40]
    
    # copy dmadata to new section
    start = static_seg.G1_dmadata
    end = start + romB.dmadata_size()
    vrom[start:end] = buffer[romB.dmadata[0]:romB.dmadata[1]]
    
    vrom.extend(buffer)
    
    with open(romOut, 'wb') as stream:
        stream.write(vrom)
    
def dma_shift(b, a, s):
    #b = bytes
    #a = dmadata address
    #s = dmadata shift offset
    d = []
    i = a
    while True:
        va = int32.r(b, i)
        vb = int32.r(b, i + 0x04)
        pa = int32.r(b, i + 0x08)
        pb = int32.r(b, i + 0x0C)
        if vb == 0:
            break
        
        if pa == -1:
            d += va, vb, pa, pb
        elif pb == 0:
            d += va, vb, pa + s, 0
        else:
            d += va, vb, pa + s, pa + s

        i += 0x10
    return d
    
def dma_copy(b, a):
    print(a)
    d = []
    i = a
    while True:
        vb = int32.r(b, i + 0x04)
        i += 0x10
        if vb == 0:
            break
            
    i += 0x10
    print (i)
    return b[a:i]
    
def writedma(b, a, d):
    i = a
    for v in d:
        int32.w(b, i, v)
        i += 4
        
def output_dmadata(rom, start, end):
    buffer = []
    with open(rom, 'rb') as stream:
        buffer = bytearray(stream.read(0x80000))
        
    # d = dma_copy(buffer, start, end)
    d = buffer[start:end]
    
    with open(dmaOut, 'wb') as stream:
        stream.write(bytearray(d))
    
merge()
# output_dmadata(romA, romA.dmadata[0], romA.dmadata[1])