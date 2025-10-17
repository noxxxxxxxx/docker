import os
import sys
import zipfile

# 用法：python sync_zip.py <模板目录> <目标目录> <输出zip文件>
template_dir = sys.argv[1]
target_dir = sys.argv[2]
output_zip = sys.argv[3]

with zipfile.ZipFile(output_zip, 'w') as zf:
    for root, dirs, files in os.walk(template_dir):
        rel_root = os.path.relpath(root, template_dir)
        for file in files:
            template_path = os.path.join(root, file)
            target_path = os.path.join(target_dir, rel_root, file)
            if os.path.exists(target_path):
                arcname = os.path.join(rel_root, file)
                zf.write(target_path, arcname)

print(f"压缩完成：{output_zip}")