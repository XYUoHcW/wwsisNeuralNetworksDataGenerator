<?php
$minX = 0;
$maxX = 10;
$xIncrement = 1;

$minY = 2;
$maxY = 8;
$yIncrement = 0.5;

$decimals = 7;

$x = ['x1'];
$y = ['x2'];
$z = ['y'];

$xNorm = ['normX1'];
$yNorm = ['normX2'];
$zNorm = ['normY'];

$randX = ['randX1'];
$randY = ['randX2'];

$xVal = $minX;
$yVal = $minY;

while ($yVal <= $maxY) {
   $x[] = $xVal;
   $y[] = $yVal;
   $z[] = definedFunction($xVal, $yVal);


   $xNormValue = normalize($xVal, $minX, $maxX);
   $yNormValue = normalize($yVal, $minY, $maxY);
   $xNorm[] = $xNormValue; 
   $yNorm[] = $yNormValue;
   $zNorm[] = definedFunction($xNormValue, $yNormValue);


   $randX[] = random($minX, $maxX, $decimals);
   $randY[] = random($minY, $maxY, $decimals);

   $xVal += $xIncrement;

   if ($xVal > $maxX) {
       $xVal = $minX;
       $yVal += $yIncrement;
   }
}

$generatedData = [$x, $y, $z, $xNorm, $yNorm, $zNorm, $randX, $randY];

generateCsv($generatedData);

function definedFunction($x1, $x2)
{
    return 3*$x1+8*$x2;
}

function normalize($val, $min, $max)
{
    return ($val-$min)/($max-$min);
}

function random($min, $max, $decimals)
{
    $exponent = pow(10, $decimals);
    return (rand($min * $exponent, $max * $exponent)) / $exponent;

}

function valuesString(array $generatedData)
{
    $string = '';
    $delimiter = ';';

    /*
     *  Sprawdzenie, czy zbiory sa rowne
     */
    $prev = null;
    foreach ($generatedData as $dataSet) {
        if ($prev === null) {
            $prev = $dataSet;
            continue;
        }
        if (count($dataSet) !== count($prev)) {
            throw Exception('Zbiory danych nie sa rowne!');
        }
    }

    /*
     * Tworzenie stringa
     */
    foreach ($generatedData as $set) {
        $line = '';
        foreach ($set as $value) {
            $line .= $delimiter.$value;
        } 
        $line = ltrim($line, $delimiter);
        $string .= $line."\r\n";
    }

    return $string;
}



function valuesStringColumns(array $generatedData)
{
    $string = '';
    $delimiter = ';';
    $dataCount = 0;

    /*
     *  Sprawdzenie, czy zbiory sa rowne
     */
    $prev = null;
    foreach ($generatedData as $dataSet) {
        if ($prev === null) {
            $prev = $dataSet;
            $dataCount = count($dataSet);
            continue;
        }
        if (count($dataSet) !== count($prev)) {
            throw Exception('Zbiory danych nie sa rowne!');
        }
    }

    /*
     * Tworzenie stringa
     */
    for ($i=0; $i < $dataCount; $i++) {
        $line = '';
        foreach ($generatedData as $set) {
            $line .= $set[$i] . $delimiter;
        }
        $line = rtrim($line, $delimiter)."\r\n";
        $string .= $line;
    }
    $string = rtrim($string, "\r\n");

    return $string;
}


function generateCsv(array $generatedData)
{
    file_put_contents('data.csv', valuesStringColumns($generatedData));
}
