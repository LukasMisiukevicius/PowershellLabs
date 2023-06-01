cls
#Nuskaitytus duomenis įrašyti į failą nurodant, datą kada duomenys buvo nuskaityti
$dateVar = Get-Date -Format yyyy-MM-dd_HH-mm-ss
function pcParameters{
    echo "Kompiuterio pavadinimas: "
    Get-WmiObject -class Win32_ComputerSystem | Format-List Name
    echo "Kompiuterio disku parametrai: "
    Get-WmiObject -class Win32_LogicalDisk | Format-List DeviceID, VolumeName
    echo "CPU naudojimas einamuoju metu: "
    Get-WmiObject -class Win32_Processor | Format-List LoadPercentage
    echo "Kompiuteryje esanti visa ir laisva atmintis MB:" 
    Get-WmiObject -class Win32_LogicalDisk | ? {$_.DriveType -eq 3} | select DeviceID, {$_.Size /1MB}, {$_.FreeSpace /1MB}
}

pcParameters > C:\Users\Public\Documents\$dateVar.txt

#Nuskaityti ir į atskirus failus įrašyti sistemoje esančius servisus. Viename faile turi būti aktyvūs (running), kitame neaktyvūs (stopped) servisai.
Get-Service | Where-Object {$_.Status -eq "Running"} > C:\Users\Public\Documents\Running_Services.txt
Get-Service | Where-Object {$_.Status -eq "Stopped"} > C:\Users\Public\Documents\Stopped_Services.txt

#Sukurti funkciją, kuriai per parametrą būtų perduodamas serviso pavadinimas, o išvedama serviso būsena.
function isRunningOrNot
{
    $userInput = Read-Host "Iveskite proceso pavadinima"
    Get-Service | Where-Object {$_.Name -eq $userInput} | Format-List Status
    if(!(Get-Service | Where-Object {$_.Name -eq $userInput} | Format-List Status))
    {
        Write-Host "Procesas tokiu pavadinimu nerastas" -ForegroundColor Red
    }
}
#isRunningOrNot

#Nuskaityti 10 paskutinių sisteminių įvykių iš EventLog objekto. 

Write-Host "10 paskutiniu sisteminiu ivykiu is EventLog objekto, Application" -ForegroundColor Green
Get-EventLog -LogName Application -Newest 10

#Sukurti funkciją, kuriai per parametrą būtų perduodamas programos pavadinimas ir norimų grąžinti įvykių skaičius.
#Funkcija turi sukurti failą <ProgramosPavadinimas_Data>, kuriame būtų įrašyti atrinkti įvykiai.
 
function eventLogs
{
    $userInput2 = Read-Host "Iveskite programos pavadinima"
    $userInputNum = Read-Host "Iveskite norimu grazinti ivykiu skaiciu"
    if(!(Get-EventLog -LogName Application -Source $userInput2 -Newest $userInputNum -ErrorAction SilentlyContinue))
    {
        Write-Host "Ivykiu tokiu pavadinimu nera" -ForegroundColor Red
    }
    else
    {
        Write-Host "Irasomi EventLogai i faila" -ForegroundColor Yellow
        Get-EventLog -LogName Application -Source $userInput2 -Newest $userInputNum -ErrorAction SilentlyContinue > C:\Users\Public\Documents\$userInput2`_$dateVar.txt 
    }
}

#eventLogs
