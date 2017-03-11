#Inicjalizacja bufora
png("dane.png", width=600, height=600);

#Dane
uczace_calosc <- read.csv(file="uczace.csv", header=TRUE, sep=";")
x1 <- uczace_calosc$x1
x2 <- uczace_calosc$x2

testX1 <- uczace_calosc$randX1
testX2 <- uczace_calosc$randX2

# Nagłówki
mainTitle <- "Analiza wygenerowanych danych"
labelX <- "x1"
labelY <- "x2"
limitX <- c(0, max(x1))
limitY <- c(0, max(x2))

#Ukrycie punktów i osi
axisType <- "p"
axisX <- "l"
axisY <- "l"
axis1color <- "blue"
axis2color <- "red"

#struktura bazowa grafiki
plot(
    x = x1,
    y = x2,
    main = mainTitle,
    xlab = labelX,
    ylab = labelY,
    xlim = limitX,
    ylim = limitY,
    type = axisType,
    xaxt = axisX,
    yaxt = axisY,
    col  = axis1color
);

points(
    x = testX1,
    y = testX2,
    type = axisType,
    xaxt = axisX,
    yaxt = axisY,
    col  = axis2color,
    pch  = 3,
    cex = 1
);

#Zamkniecie bufora w celu zapisu pliku
dev.off();




