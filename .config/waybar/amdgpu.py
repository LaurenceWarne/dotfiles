import sys

attrib = sys.argv[1]

for l in sys.stdin:
    result = next(((c.split(" ")[-1][:-2]) for c in l.split(", ") if c.startswith(attrib + " ")), None)
    if result and attrib == "vram": print(f"{float(result)/1024:.2g} G")
    if result and attrib == "gpu": print(f"{result}")
