clear

$var="*06_R_N_L_BH*"
$origem = "E:\Pontificia Universidade Catolica de Goias\TCC\Base de Dados\Banco de Dados Mãos - Original"
$destino="E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset\"
$array= @(get-childitem $origem)

$individuosAlvo = "23", "25", "27", "29", "31", "32", "34", "35", "36", "37", "38", "39", "54", "41", "42", "43", "44", "47", "46", "48", "49", "50", "51", "52", "55", "56", "57", "58", "59", "60", "62", "63", "64", "65", "66", "67", "70", "72", "73", "75", "76", "77", "79", "81", "84", "85", "86", "87", "88", "89", "90", "93", "94", "95", "96", "98", "99", "102", "103", "104", "105", "106", "107", "108", "109", "110", "112", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "127"

for ($i=0; $i -lt $individuosAlvo.Length; $i++) {
    if(Test-Path -Path "$($destino)\$($individuosAlvo[$i])") {
        Remove-Item -Path "$($destino)\$($individuosAlvo[$i])\*"
    }else{
        mkdir "$($destino)\$($individuosAlvo[$i])"
    }
}

for ($i=0; $i -lt $array.Length; $i++) {
    if($individuosAlvo.Contains($array[$i].Name)){
        $folderChildren=join-path -path $origem -childpath $array[$i]

        $arrayChildren= @(get-childitem $folderChildren -include *$var.* -name)

        for($j = 0; $j -lt $arrayChildren.Length; $j++) {
            $path = join-path -path $folderChildren -childpath $arrayChildren[$j]
            $destinationFile = join-path -path $($destino + $array[$i].Name) -childpath $arrayChildren[$j]
            
            Copy-Item -Path $path -Destination $destinationFile -Recurse
        }
    }
}

[Console]::Beep(500,500)