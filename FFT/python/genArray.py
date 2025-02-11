import pandas.io.clipboard as cb
res1 = "xr = ["
res2 = "xj =["
i = 1
while i < 256:
    res1 = res1 + str(i) + ", "
    res2 = res2 + str(i) + "i, "
    i += 1
res1 = res1 + "256];"
res2 = res2 + "256i];"
res = res1 + '\n' + res2
cb.copy(res)
if(cb.paste() == res):
    print("已将结果复制到剪切板，请检查")
else:
    print("复制结果至剪切板失败!\n以下是输出结果，请手动在控制台内复制：\n" + res)