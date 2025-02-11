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
import pandas.io.clipboard as cb
N = int(input("FFT的点数为："))
maxPOS = N - 1
length = len(bin(maxPOS)[2:])
print("二进制字符串长度为：" + str(length))
pos = 0
addend = 1
res_re = "\t//实部\n"
res_im = "\t//虚部\n"
res_matlab = ""
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
    #res_matlab = res_matlab + "\tres(" + str(pos + 1) + ") =  input(" + str(int(outBin,2) + 1) + ");\n"
    pos = pos + addend
res = res_re + res_im + res_matlab
#print(res)
cb.copy(res)
if(cb.paste() == res):
    print("已将结果复制到剪切板，请检查")
else:
    print("复制结果至剪切板失败!\n以下是输出结果，请手动在控制台内复制：\n" + res)
#The Last Line