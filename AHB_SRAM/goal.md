# AHB-SRAM控制器

设计一个基于AHB从接口的单端口SRAM控制器，实现SRAM存储器与AHB总线的数据信息交换，将AHB总线上的读写操作转换成标准SRAM读写操作。

SRAM大小为4096x32-bit，AHB接口数据大小固定为32-bit，AHB接口地址范围为0x00000000
– 0x00003FFC。AHB接口能够实现单次或突发模式的数据读写操作。

顶层模块名为**sram_ctr_ahb**，输入输出功能定义：

| **名称**   | **方向** | **位宽** | **描述**        |
| -------- | ------ | ------ | ------------- |
| hclk     | I      | 1      | 系统时钟          |
| hresetn  | I      | 1      | 系统异步复位，低电平有效  |
| hwrite   | I      | 1      | 写有效           |
| htrans   | I      | 2      | 当前传输类型        |
| hsize    | I      | 3      | 当前传输大小        |
| haddr    | I      | 32     | 读写地址          |
| hburst   | I      | 3      | 当前突发类型        |
| hwdata   | I      | 32     | 写数据           |
| hready   | O      | 1      | 传输完成指示        |
| hresp    | O      | 2      | 传输响应          |
| hrdata   | O      | 32     | 读数据           |
| sram_csn | O      | 1      | SRAM片选，低电平有效  |
| sram_wen | O      | 1      | SRAM写使能，低电平有效 |
| sram_a   | O      | 12     | SRAM读写地址      |
| sram_d   | O      | 32     | SRAM写数据       |
| sram_q   | I      | 32     | SRAM读数据       |

注：仿真时SRAM时钟与hclk相同，SRAM可以用FPGA的单端口SRAM IP核仿真模型或者使用单端口SRAM行为级模型代替。

设计要求：

1 Verilog实现代码可综合，给出综合以及仿真结果。

2 仿真时应给出各种典型情况下的数据读写接口信号波形。
