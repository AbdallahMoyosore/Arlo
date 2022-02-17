####
$ship1x = Get-Random(1..8)
$ship1y = Get-Random(1..8)
do {
$ship2x = Get-Random(1..8)
}
while ($ship1x -eq $ship2x)
$ship2y = Get-Random(1..8)



####
Clear-Host 
Write-Host "****************"
Write-Host "We have two ships now. Game Start !!!"
write-host

$ship1x
$ship1y
write-host "---"
$ship2x
$ship2y


$c = 0 
$Battleship1 = $Battleship2 = $false
 
while ($c -lt 20)
{
	
	do {
		$e = $false # e = error
		$xy = Read-Host "Please input your co-ordinate to guess (ex: 2,3) "
		$xy = $xy.Trim(" ") #Remove the space may have in the begining or in the end of input
		if ($xy.length -ne 3) {$e = $true} # if input is not 3 characters then hit error
		if (!$e) {
			try {
			$x = [int]$xy.Split(",")[0]  #got the x value of co-ordinate
			$y = [int]$xy.Split(",")[1]  #got the y value of co-ordinate
			}
			catch{
				$e = $true #if cannot the x value OR y value with interger then hit error
			}
			if ((1..8) -notcontains $x) {$e = $true} #if $x is not in 1->8 hit error
			if ((1..8) -notcontains $y) {$e = $true} #if $y is not in 1->8 hit error
		}
		if ($e) {write-host "Your Input is not correct !!!"; write-host}
	}
	while ($e)
	
	
	$b = $false
	if (!$Battleship1) { #in case the ship1 has not been found yet, we will do this one. 
		$d1 = [Math]::Abs($ship1x - $x) + [Math]::Abs($ship1y - $y) #Get distance to define cold hot warm 
		if ($d1 -eq 0) { #distance = 0 means we found the ship1
			$b = $Battleship1 = $true #b mean we just found a ship. 
			$txt = "Bingo: Ship 01 is (" + $x + "," + $y + ")"
			Write-Host $txt
			$d1 = 20
			if ($Battleship2) { #if we already found ship2 then we both found 2 ship then WIN
				write-host "You WIN !!!"
				break
			}
		}
	}
	
	if (!$Battleship2) {
		$d2 = [Math]::Abs($ship2x - $x) + [Math]::Abs($ship2y - $y)
		if ($d2 -eq 0) {
			$b = $Battleship2 = $true
			$txt = "Bingo: Ship 02 is (" + $x + "," + $y + ")"
			Write-Host $txt
			$d2 = 20
			if ($Battleship1) {
				write-host "You WIN !!!"
				break
			}
		}
	}	
	
	$d = [Math]::Min($d1,$d2) #min of two distances to define hot cold warm to a nearest ship
	if ((!$b) -and ($d -le 2)) { write-host "Hot"}
	if ((!$b) -and (($d -eq 3) -or ($d -eq 4))) { write-host "Warm"}
	if ((!$b) -and ($d -gt 4)) { write-host "Cold"}
	$c++ #count the number of guess
}
if ((!$Battleship1) -or (!$Battleship2)) { write-host "You LOSE !!!" } #if number of guess more than 20 but we cannot find 2 ships then we LOSE


