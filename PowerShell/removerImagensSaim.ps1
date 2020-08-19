$var="*16_L_N_L_BH*"
$source="E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset\"
$array= @(get-childitem $source)
for ($i=0; $i -lt $array.Length; $i++) {
	$folderChildren=join-path -path $source -childpath $array[$i]
    $arrayChildren= @(get-childitem $folderChildren -exclude *$var.* -name)
    for($j = 0; $j -lt $arrayChildren.Length; $j++) {
        $pathDelete = join-path -path $folderChildren -childpath $arrayChildren[$j]
        remove-item $pathDelete
    }
}