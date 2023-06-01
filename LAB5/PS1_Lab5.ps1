$SampleAssembly = [Reflection.Assembly]::LoadFile("C:\Users\Lukas\source\repos\OSS_Lab_5_DLL\OSS_Lab_5_DLL\bin\Debug\OSS_Lab_5_DLL.dll")

function toFile
{
    [OSS_Lab_5_DLL.GetPcInfo]::GetPcName() 
    [OSS_Lab_5_DLL.GetPcInfo]::GetHDDParams()
    [OSS_Lab_5_DLL.GetPcInfo]::GetCurrentCPU()
    [OSS_Lab_5_DLL.GetPcInfo]::GetPhysicalMemory()
    [OSS_Lab_5_DLL.GetPcInfo]::LastTenEventLogs()
}

toFile | Out-File -FilePath C:\Users\Public\DLL_Output.txt