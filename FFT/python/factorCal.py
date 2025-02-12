#Construct under Python 3.12.6

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
#函数，补码修正
def complementCorrection(n, bits=16):
    if n >= 0:
        return bin2hex(format(n, f'0{bits}b'))
    else:
        #计算负数补码
        return bin2hex(format((1 << bits) + n, f'0{bits}b'))
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
    #realPartHEX = invertByBitIfLessZero(realPartDEC)
    #imagPartHEX = invertByBitIfLessZero(imagPartDEC)
    realPartHEX = complementCorrection(realPartDEC)
    imagPartHEX = complementCorrection(imagPartDEC)
    #print(complementCorrection(imagPartDEC))
    #print(str(r)+":"+realPartHEX+"\n"+imagPartHEX)
    res = res \
        + "\tassign Wnr_real[" + str(r) + "] = 16'h" + realPartHEX + ';\n' \
        + "\tassign Wnr_imag[" + str(r) + "] = 16'h" + imagPartHEX + ';\n'
    r = r + 1
#print(res)
cb.copy(res)
if(cb.paste() == res):
    print("已将结果复制到剪切板，请检查")
else:
    print("复制结果至剪切板失败!\n以下是输出结果，请手动在控制台内复制：\n" + res)
#The Last Line