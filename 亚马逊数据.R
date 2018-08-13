#对于json数据，如果在软件中早起安装了rjson包的话，就不用安装，如果没有安装的话
#首先进行安装rjson包
install.packages("rjson")
library("rjson")

#duquchengjishuju
grades <- fromJSON(file ="K:/experimental data/example/grades/grades.json")
print(grades)

#example data 
result <- fromJSON(file = "K:/experimental data/example/1.json")
print(result)

#从指定的文件中进行json格式的数据读取
amazon <- fromJSON(file = "K:/experimental data/amazon/meta_Clothing_Shoes_and_Jewelry.json")
print(amazon)

