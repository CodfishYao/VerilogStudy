#Construct under Python 3.12.6
#Copyright (c) 2024 YaoYucheng(UCAS, https://yaohaolin.cn)
#
#Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#
#2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#
#Subject to the terms and conditions of this license, each copyright holder and contributor hereby grants to those receiving rights under this license a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except for failure to satisfy the conditions of this license) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer this software, where such license applies only to those patent claims, already acquired or hereafter acquired, licensable by such copyright holder or contributor that are necessarily infringed by:
#
#(a) their Contribution(s) (the licensed copyrights of copyright holders and non-copyrightable additions of contributors, in source or binary form) alone; or
#
#(b) combination of their Contribution(s) with the work of authorship to which such Contribution(s) was added by such copyright holder or contributor, if, at the time the Contribution is added, such addition causes such combination to be necessarily infringed. The patent license shall not apply to any other combinations which include the Contribution.
#
#Except as expressly stated above, no rights or licenses from any copyright holder or contributor is granted under this license, whether expressly, by implication, estoppel or otherwise.
#
#DISCLAIMER
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Code
#算法思路：
# 1.用欧拉公式表示Wnr;
# 2.将实部和虚部的余弦/正弦值先计算出来;
# 3.二者分别乘以8192（十进制）;
# 4.四舍五入取整，转换为16位二进制;
# 5.负数结果按位取反.
# 最终结果用十六进制表示（短，好看）
# 代码逻辑与该思路或稍有差异

#公式：
# Wnr = exp(-2Pi*j*r/n) = cos(2Pi*r/n)+jsin(-2Pi*r/n) = cos(C*r)-jsin(C*r); 
# r = N/2 - 1(index of VerilogHDL codes， pls omit the true meaning...), 
# n = N(64/256/···).

#代码如下
import pandas.io.clipboard as cb
import math
#函数，16位二进制转换为十六进制
def bin2hex(a):
    num = list(a)
    num0 = str(int(num[0])*8+int(num[1])*4+int(num[2])*2+int(num[3])*1)
    match num0:
        case "10":
            num0 = "A"
        case "11":
            num0 = "B"
        case "12":
            num0 = "C"
        case "13":
            num0 = "D"
        case "14":
            num0 = "E"
        case "15":
            num0 = "F"
        case _:
            num0 = num0
    #第2位(从左至右)
    num1 = str(int(num[4])*8+int(num[5])*4+int(num[6])*2+int(num[7])*1)
    match num1:
        case "10":
            num1 = "A"
        case "11":
            num1 = "B"
        case "12":
            num1 = "C"
        case "13":
            num1 = "D"
        case "14":
            num1 = "E"
        case "15":
            num1 = "F"
        case _:
            num1 = num1
    #第3位
    num2 = str(int(num[8])*8+int(num[9])*4+int(num[10])*2+int(num[11])*1)
    match num2:
        case "10":
            num2 = "A"
        case "11":
            num2 = "B"
        case "12":
            num2 = "C"
        case "13":
            num2 = "D"
        case "14":
            num2 = "E"
        case "15":
            num2 = "F"
        case _:
            num2 = num2
    #第4位
    num3 = str(int(num[12])*8+int(num[13])*4+int(num[14])*2+int(num[15])*1)
    match num3:
        case "10":
            num3 = "A"
        case "11":
            num3 = "B"
        case "12":
            num3 = "C"
        case "13":
            num3 = "D"
        case "14":
            num3 = "E"
        case "15":
            num3 = "F"
        case _:
            num3 = num3
    res = num0 + num1 + num2 + num3
    #print("转换后的十六进制的结果为：" + res)
    return res
#函数，负数取绝对值后按位取反
def invertByBitIfLessZero(num):
    numBIN = bin(abs(num))[2:].rjust(16,'0') #转换为二进制 去掉“0b” 且补齐
    numBINList = list(numBIN)
    #print(''.join(numBINList))
    if(num < 0):
        #print("小于0！")
        cnt = 0
        for k in numBINList:
            numBINList[cnt] = '0' if k=='1' else '1'
            cnt = cnt + 1
    res = ''.join(numBINList)
    #print(res)
    return bin2hex(res)
#main
N = int(input("FFT的点数为："))
rTotal = N/2 - 1
res = "//旋转因子\n"
C = 2*math.pi/N
r = 0
while r <= rTotal:
    realPartDEC = math.trunc(math.cos(C*r)*8192)
    #unsigned
    imagPartDEC = math.trunc(math.sin(-C*r)*8192)
    #print(str(r)+":"+str(realPartDEC)+"\n  "+str(imagPartDEC))
    realPartHEX = invertByBitIfLessZero(realPartDEC)
    imagPartHEX = invertByBitIfLessZero(imagPartDEC)
    #print(str(r)+":"+realPartHEX+"\n"+imagPartHEX)
    res = res \
        + "\tassign factor_real[" + str(r) + "] = 16'h" + realPartHEX + ';\n' \
        + "\tassign factor_imag[" + str(r) + "] = 16'h" + imagPartHEX + ';\n'
    r = r + 1
#print(res)
cb.copy(res)
if(cb.paste() == res):
    print("已将结果复制到剪切板，请检查")
else:
    print("复制结果至剪切板失败!\n以下是输出结果，请手动在控制台内复制：\n" + res)
#The Last Line