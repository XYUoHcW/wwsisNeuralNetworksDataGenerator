library("neuralnet")

uczace_calosc <- read.csv(file="uczace.csv", header=TRUE, sep=";")

h = c(10)
data = cbind(uczace_calosc$x1, uczace_calosc$x2, uczace_calosc$y);
colnames(data) <- c("x1", "x2", "y")
net.function <- neuralnet(y ~ x1+x2,data, hidden=10, threshold=0.01)


print(net.function)
plot(net.function)

testdata = cbind(uczace_calosc$randX1, uczace_calosc$randX2)
colnames(testdata) <- c("x1", "x2")

net.results <- compute(net.function, testdata)

print(net.results$net.result)

difference = net.results$net.result - uczace_calosc$randY
comparison = cbind(net.results$net.result, uczace_calosc$randY, difference)
colnames(comparison) <- c("net_result", "expected", "difference")
print(comparison)


dev.print(png, 'filename.png', width=600)

