import ezdxf
import sys

lines = sys.stdin.readlines()
header, comment, dimensions, precision = lines[:4]
width, height = [int(word) for word in dimensions.split(' ')]
dats = [int(line) for line in lines[4:]]

# Create a new DXF document.
doc = ezdxf.new("R12")
msp = doc.modelspace()

ii = 0
for ii, dat in enumerate(dats):
    if ii % 3 == 0:
        y = (ii // 3) // width
        x = (ii // 3) % width
        if dat > 120:
            msp.add_circle((x, height - y), 0.4)

doc.write(sys.stdout)
