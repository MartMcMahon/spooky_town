from glob import glob

file_list = glob("assets/Daemonum Infernum/**", recursive=True)
f = open("./sprites.lua", "w")
f.write(
    f"""
local lg = love.graphics
asset_list = {{}}
"""
)
for filename in file_list:
    if not filename.endswith(".png") or filename.endswith("Large.png"):
        continue
    asset_name = filename.split("/")[-2].split(".")[0].lower()
    frame_cols = 16
    if filename.endswith(".png"):
        frame_rows = 16

    f.write(
        f"""
{asset_name}_tiles = lg.newImage("{filename}")
"""
    )

f.write("return asset_list")
f.close()

# {asset_name}_quads = {{}}
# for y=0, {frame_rows} do
#   {asset_name}_quads[y] = {{}}
#   for x=0, {frame_cols} do
#     table.insert({asset_name}_quads[y], lg.newQuad(x*256, y*256, 256, 256, 4096, 4096))
#   end
# end
# {asset_name}_animation = {{currentTime = 0, duration = 1, quads = {asset_name}_quads, image = {asset_name}_tiles}}
# table.insert(asset_list, {asset_name}_animation)
