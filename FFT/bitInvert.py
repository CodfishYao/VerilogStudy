import pandas.io.clipboard as cb
N = int(input("FFT的点数为："))
maxPOS = N - 1
length = len(bin(maxPOS)[2:])
print("二进制字符串长度为：" + str(length))
pos = 0
addend = 1
res_re = "\t//实部\n"
res_im = "\t//虚部\n"
while pos <= maxPOS:
    originBin = bin(pos)[2:].rjust(length,'0') #转换为二进制 去掉“0b” 且补齐
    #print(originBin)
    originBin = list(originBin)
    i = 0
    maxi = length / 2
    while i < maxi:
        j = length - 1 - i
        originBin[i], originBin[j] = originBin[j], originBin[i]
        i += 1
    originBin = ''.join(originBin)
    #print(originBin)
    outBin = "0b" + originBin #带"0b"
    #print(int(outBin,2))
    #print("assign x_re_mat[0][" + str(pos) + "] =  x_re_buf[" + str(int(outBin,2)) + "];\n")
    res_re = res_re + "\tassign x_re_mat[0][" + str(pos) + "] =  x_re_buf[" + str(int(outBin,2)) + "];\n"
    res_im = res_im + "\tassign x_im_mat[0][" + str(pos) + "] =  x_im_buf[" + str(int(outBin,2)) + "];\n"
    pos = pos + addend
res = res_re + res_im
#print(res)
cb.copy(res)
if(cb.paste() == res):
    print("已将结果复制到剪切板，请检查")
else:
    print("复制结果至剪切板失败!\n以下是输出结果，请手动在控制台内复制：\n" + res)
