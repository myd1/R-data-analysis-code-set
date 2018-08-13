#安装所需要的包
install.packages("quantmod")

#加载所需要的包
library(quantmod)

#载入依赖的包
library(zoo)
library(xts)
library(TTR)

#进行数据的加载
getSymbols("SINA")
# #注意，此处默认的是从 Yahoo 上访问数据，
# 如果我们需要从其他网站上访问数据，需要用到 
# src 命令 来读取其他网站的数据，例如：
getSymbols("SINA",src="google")

#也可以读取某个时间段的数据
etSymbols("300431.SZ",src="yahoo",auto.assign=FALSE,from="2015-05-01", to='2015-05-26')

#对加载的数据进行查看
head(SINA)

tail(SINA)

#使用dim进行数据规模的查看
dim(SINA) #第一列 2650 表示变量中包含的数据的行数，第二列 6 表示变量的维数。

#股票数据的图形绘制
# 一般来说，要对股票数据做一个直观的了解直接看 K 线图（时序图）。
# 画K线图需要用到 chartSeries 函数，其中 from 和 to 表示所画图形的
# 起始和终止时间，也可不写表示将下载的全部数据都画在图形上。
getSymbols("SINA",from="2017-01-03",to="2017-07-12")   #下载部分数据
chartSeries(SINA,from="2017-01-03",to="2017-07-12")

#注意，K线图里仅表示了新浪股票数据的日收盘价和成交量的时序图。

#更换图形的主题背景
chartSeries(SINA,theme="white",from="2017-01-03",to="2017-07-12") #背景为白色


#股票收益率的时序图
# 我们下载的股票数据的 6 个维度包含:开盘价、最高价、最低价、收盘价、
# 成交量、调整的收盘价。研究股票收益率是股票投资分析最基本的操作，
# 股票收益率通常简化为股票价格对数变化来表示，股票价格使用调整后的收盘价。

#计算股票收益率通常需要用到 log(求对数) diff（求差分） 函数。
SINA.Profit=diff(log(SINA$SINA.Adjusted))
chartSeries(SINA.Profit,theme="white")   #绘制图形

#股票收益率的密度函数图
#在画密度函数图之前我们要先下载 fBasics 软件包。
install.packages("fBasics")
library(fBasics)
#zaijiazaibaoshihuichucuo,yinci xuyaozhixingxiamianyijuhua
#载入依赖的包
library(zoo)
library(xts)
library(TTR)

#但在画图之前，由于我们的 SINA.Profit 是通过一阶差分得来的数据， 
#在第一行有一个空值（NA），需要先删除掉第一行才能继续画图。
SINA.Pro=na.omit(SINA.Profit)
de=density(SINA.Pro)   #获取密度函数
range(SINA.Pro)        #查看数据的取值范围，相当于 c(min(x),max(x))
x=seq(-.17,.17,.001)   #生成一个下界是 -0.17，上界是 0.17，时间间隔是 0.001 的数据，取值范围主要由 range 的结果决定
plot(de$x,de$y,xlab='x',ylab='density',type='l') #画密度函数图
ys=dnorm(x,mean(SINA.Pro),stdev(SINA.Pro))  #新建一个与 SINA.Pro 均值和标准差一致的正态分布函数 
lines(x,ys,lty=2) #在密度函数图上增加正态分布曲线（图中虚线）

#股票收益率的正态性检验
#股票收益率的基本统计量
#要获得股票收益数据的基本统计量的值，我们需要使用 fBasics 软件包中的 basicStats 函数。
basicStats(SINA.Pro)

# 根据上图结果，我们可以得到新浪股票收益率的各种基本统计结果：
# 
# nobs(数据个数)、Mean（均值）、Median（中位数）、Sum（总和）、Variance（方差）、
# Stdev（标准差）、Skewness（偏度）、Kurtosis（峰度）。
# 
# mean=0.003,接近于0，也就是说新浪股票收益率具有比较明显的向0集中的趋势。
# 
# Variance=0.001，接近于0，也就是说新浪股票收益率的离散程度较小，不分散。
# 
# Skewness=0.462, 明显不等于0，也就是说新浪股票收益率是非对称分布的。
# 
# Kurtosis=14.101 ，明显大于3，也就是说新浪股票收益率存在明显的高峰厚尾现象。

# 股票收益率的正态性检验
# 
# 要进行正态性检验，我们需要用到 normalTest 函数。
normalTest(SINA.Pro,method='jb')  # `jb`代表JB正态性检验

#数据解释说明
# 检验统计量 JB=1122.8358，p<2.2e-16<0.05，也就是说在5%的
# 显著性水平上拒绝新浪股票收益率服从正态分布函数的原假设，即新浪股票收益率不服从正态分布。

#实验结论
# 试验基于网络上现有的股票数据，结合 R 语言的 quantmod 和 fBasics 软件包下载股票数据，
# 实现数据的可视化，包括直观的 K 线图、收益率的时序图，以及密度函数图，最终从图形、统计结果以及 
# JB 检验三个方面来证明了该股票收益数据程非正态分布。整个实验让我们巩固了 R 语言基础，熟悉了如何使用 
# R 语言分析股票数据，为使用 R 语言做金融数据分析打下基础。










