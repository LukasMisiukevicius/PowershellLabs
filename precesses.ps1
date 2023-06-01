function killing_a_process
{
    CLS
    Write-Host "Preparing process list" -ForegroundColor Green
    Get-Process
    $choice = Read-Host "Run search by? (process name, partial process name, id)"
    if($choice -eq "process name")
    {
        $input = Read-Host "Please enter process name"
        Write-Host "Searching for a process by" $input -ForegroundColor Green
    
        if(-not (Get-Process -Name $input -ErrorAction SilentlyContinue))
        {
            Write-Host "There is no process like that" -ForegroundColor Red
            break
        }
        else {
            Get-Process -Name $input
        }
    }
    elseif($choice -eq "partial process name")
    {
        $input = Read-Host "Please enter partial process name"
        Write-Host "Searching for a process by" $input -ForegroundColor Green
        if(-not (Get-Process -Name *$input* -ErrorAction SilentlyContinue))
        {
            Write-Host "There is no process like that" -ForegroundColor Red
            break
        }
        else {
            Get-Process -Name *$input*
        }    
    }
    elseif($choice -eq "id")
    {
        $input = Read-Host "Please enter process id"
        Write-Host "Searching for a process by" $input -ForegroundColor Green
        if(-not (Get-Process -Id $input -ErrorAction SilentlyContinue))
        {
            Write-Host "There is no process like that" -ForegroundColor Red
            break
        }
        else {
            Get-Process -Id $input
        }    
    }
    else 
    {
        Write-Host "Wrong choice" -ForegroundColor Red
        break
    }

    Write-Host "Would you like to kill a process? (yes, no)" -ForegroundColor Yellow
    $choiceSecond = Read-Host
    if($choiceSecond -eq "yes")
    {
        if($choice -eq "process name")
        {
            Write-Host "Killing a process" -ForegroundColor Yellow
            Stop-Process -Name $input -ErrorAction SilentlyContinue        
    
            if(Get-Process -Name $input -ErrorAction SilentlyContinue)
            {
                Write-Host "Process successfully killed" -ForegroundColor Green
                break
            }
            else 
            {
                Write-Host "Processess killing failed" -ForegroundColor Red
            }  
        }
        elseif($choice -eq "id")
        {
            Write-Host "Killing a process" -ForegroundColor Yellow
            Stop-Process -Id $input -ErrorAction SilentlyContinue
            if(Get-Process -Id $input -ErrorAction SilentlyContinue)
            {
                Write-Host "Process successfully killed" -ForegroundColor Green
                break
            }
            else 
            {
                Write-Host "Processess killing failed" -ForegroundColor Red
            }
        }
        else
        {
            Write-Host "I cant kill process by this parameter" -ForegroundColor Red
            break
        }
    }
    else
    {
        Write-Host "Not killing a process" -ForegroundColor Green    
    }
}

function print_process_to_file
{
    New-Item -Path C:\Users\Public\ -Name "ProcessOut" -ItemType "directory" -ErrorAction SilentlyContinue | Out-Null
    CLS
    $out_date = Get-Date
    Write-Host "Preparing process list" -ForegroundColor Green
    Write-Host "By what you want to see processes? (process name, partial process name, id)"
    $choice = Read-Host
    if($choice -eq "process name")
    {
        Get-Process
        $process_name = Read-Host "What is process name?"
        Write-Host "Looking for process named:" $process_name -ForegroundColor Yellow
        if(-not (Get-Process -Name $process_name -ErrorAction SilentlyContinue))
        {
            Write-Host "There is not process with this name" -ForegroundColor Red
        }
        else
        {
            Get-Process -Name $process_name
            $how_often = Read-Host "How often do you want to write it to file? seconds"
            Write-Host "Writing processes to file... ($how_often sec intervals) To Stop press ctrl+c"
            $i = 0
            for(;;)
            {
                $how_many_obj = (Get-ChildItem  C:\Users\Public\ProcessOut\).Count;
                if($how_many_obj -gt 4)
                {
                    Get-ChildItem C:\Users\Public\ProcessOut\ | Sort CreationTime | Select -First 1 | Remove-Item
                }
                Get-Process -Name $process_name >> C:\Users\Public\ProcessOut\$(Get-Date -Format MM-dd-yyyy_HH-mm-ss).txt
                $i++
                Write-Host "Writing" $i
                Sleep($how_often)
            }      
        }        
    }
    elseif($choice -eq "id")
    {
        Get-Process
        $process_id = Read-Host "What is process id?"
        Write-Host "Looking for process id:" $process_name -ForegroundColor Yellow
        if(-not (Get-Process -Id $process_id -ErrorAction SilentlyContinue))
        {
            Write-Host "There is not process with this id" -ForegroundColor Red
        }
        else
        {
            Get-Process -Id $process_id
            $how_often = Read-Host "How often do you want to write it to file? seconds"
            Write-Host "Writing processes to file... (30 sec intervals) in folder C:\Users\Public\ProcessOut\ To Stop press ctrl+c"
            $i = 0
            for(;;)
            {
                $how_many_obj = (Get-ChildItem  C:\Users\Public\ProcessOut\).Count;
                if($how_many_obj -gt 4)
                {
                    Get-ChildItem C:\Users\Public\ProcessOut\ | Sort CreationTime | Select -First 1 | Remove-Item
                }
                Get-Process -Id $process_id >> C:\Users\Public\ProcessOut\$(Get-Date -Format MM-dd-yyyy_HH-mm-ss).txt
                $i++
                Write-Host "Writing" $i
                Sleep($how_often)
            }      
        }        
    }
    elseif($choice -eq "partial process name")
    {
        Get-Process
        $partial_name = Read-Host "What is partial process name?"
        Write-Host "Looking for process name like:" $partial_name -ForegroundColor Yellow
        if(-not (Get-Process -Name *$partial_name* -ErrorAction SilentlyContinue))
        {
            Write-Host "There is not process with this partial name" -ForegroundColor Red
        }
        else
        {
            Get-Process -Name *$partial_name*
            $how_often = Read-Host "How often do you want to write it to file? seconds"
            Write-Host "Writing processes to file... (30 sec intervals) To Stop press ctrl+c"
            $i = 0
            for(;;)
            {
                $how_many_obj = (Get-ChildItem  C:\Users\Public\ProcessOut\).Count;
                if($how_many_obj -gt 4)
                {
                    Get-ChildItem C:\Users\Public\ProcessOut\ | Sort CreationTime | Select -First 1 | Remove-Item
                }
                Get-Process -Name *$partial_name* >> C:\Users\Public\ProcessOut\$(Get-Date -Format MM-dd-yyyy_HH-mm-ss).txt
                $i++
                Write-Host "Writing" $i
                Sleep($how_often)
            }      
        }        
    }
}

Write-Host "Writing RunTime to registry" -ForegroundColor Red
Sleep(5)
CLS

$reg_path = 'HKCU:\Software\PowershellScriptRuntime'
New-Item -Path "HKCU:\Software\" -Name PowershellScriptRunTime -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "$reg_path" -Name "RunTime" -Value (Get-Date -Format yyyy-MM-dd_HH:mm) -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "Please select operation" -ForegroundColor Cyan
Write-Host "If you want to search or search and kill processes by name, id or partial name type: kill" -ForegroundColor DarkYellow
Write-Host "If you want to search process by name or id and store it into file type: file" -ForegroundColor DarkYellow 

$meniu = Read-Host "Please enter your choice"
if($meniu -eq "kill")
{
    killing_a_process
}
elseif($meniu -eq "file")
{
    print_process_to_file
}
else
{
    Write-Host "Wrong choice" -ForegroundColor Red
}