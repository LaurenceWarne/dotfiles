# https://github.com/Umio-Yasuno/amdgpu_top/discussions/59
import sys, json

attrib = sys.argv[1]

value = content = json.loads(next(sys.stdin))["devices"][0]

for selector in attrib.split("."):
    value = value[selector]
    
print(value)


