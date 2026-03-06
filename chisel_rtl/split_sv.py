import os
import re
import argparse

def split_sv_file(input_file, output_dir):
    # 检查并创建输出目录
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"📁 创建输出目录: {output_dir}")

    # 预编译正则表达式，提高匹配效率
    # 匹配 module 声明，并提取模块名 (忽略前导空格)
    module_pattern = re.compile(r'^\s*module\s+(\w+)')
    # 匹配 endmodule 声明
    endmodule_pattern = re.compile(r'^\s*endmodule')

    current_module = None
    out_file = None
    module_count = 0

    print(f"🚀 开始解析文件: {input_file} ...\n")

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            for line in f:
                # 1. 检测模块开始
                match = module_pattern.search(line)
                if match:
                    current_module = match.group(1)
                    file_path = os.path.join(output_dir, f"{current_module}.sv")
                    out_file = open(file_path, 'w', encoding='utf-8')
                    module_count += 1
                    print(f"  ├── 提取模块: {current_module}.sv")

                # 2. 写入当前行 (如果在模块内部)
                if out_file:
                    out_file.write(line)

                # 3. 检测模块结束
                if endmodule_pattern.search(line):
                    if out_file:
                        out_file.close()
                        out_file = None
                        current_module = None

    except FileNotFoundError:
        print(f"❌ 错误: 找不到输入文件 '{input_file}'，请检查路径。")
        return

    print(f"\n✅ 拆分完成！共成功提取了 {module_count} 个独立模块到 '{output_dir}' 目录中。")


if __name__ == "__main__":
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(description="SystemVerilog 模块拆分工具 (提取巨型文件中的各个 module)")
    parser.add_argument("-i", "--input", required=True, help="输入的巨型 .sv 文件名 (例如: RvvCoreMiniAxi.sv)")
    parser.add_argument("-o", "--output", default=".\\split_rtl", help="输出文件夹路径 (默认: 当前目录下的 split_rtl)")

    args = parser.parse_args()
    
    split_sv_file(args.input, args.output)