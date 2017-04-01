#Wczytanie biblioteki
library("neuralnet")

#Wczytanie danych
uczace_calosc <- read.csv(file="uczace.csv", header=TRUE, sep=";")

minY <- min(uczace_calosc$y)
maxY <- max(uczace_calosc$y)
normY <- (uczace_calosc$y-minY)/(maxY-minY)

data = cbind(uczace_calosc$normX1, uczace_calosc$normX2, normY);
colnames(data) <- c("x1", "x2", "y")
h = c(10, 8)
net.function <- neuralnet(y ~ x1+x2,data, hidden=h, threshold=0.01)


print(net.function)
plot(net.function)

testdata = cbind(uczace_calosc$normRandX1, uczace_calosc$normRandX2)
colnames(testdata) <- c("x1", "x2")

net.results <- compute(net.function, testdata)
result = (net.results$net.result*(maxY-minY))+minY

print(net.results$net.result)

# Porównanie sieci dla danych znormalizowanych
difference = result - uczace_calosc$randY
comparison = cbind(uczace_calosc$randX1, uczace_calosc$randX2, result, uczace_calosc$randY, difference)
colnames(comparison) <- c("x1", "x2", "net_result", "expected", "difference")
print(comparison)




mainTitle <- "Analiza wygenerowanych danych"
labelX <- "x1"
labelY <- "x2"
color <- 'red'


plot(
    uczace_calosc$randY,
    result,
    col= color,
    main = mainTitle,
    xlab = labelX,
    ylab = labelY,
    pch=18,
    cex=0.7
)
abline(0,1,lwd=1)
legend('bottomright',legend='Wyniki z sieci neuronowej',pch=18,col='red', bty='n')






