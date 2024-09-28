import subprocess, json

result = subprocess.run(["sensors", "-j"], capture_output=True)
sensor_info = json.loads(result.stdout)

amdgpu_temp_info = next(v for k, v in sensor_info.items() if k.startswith("amdgpu"))
# https://www.reddit.com/r/Amd/comments/ll8jpu/5700xt_junction_temp_vs_current_temp/
junction = amdgpu_temp_info["junction"]

temp = junction["temp2_input"]
crit = junction["temp2_crit"]
print(temp, flush=True)
