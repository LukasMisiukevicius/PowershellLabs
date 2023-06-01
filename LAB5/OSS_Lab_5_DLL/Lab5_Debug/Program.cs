using OSS_Lab_5_DLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab5_Debug
{
    internal class Program
    {
        static void Main(string[] args)
        {
            GetPcInfo.GetPcName();
            GetPcInfo.GetHDDParams();
            GetPcInfo.GetCurrentCPU();
            GetPcInfo.GetPhysicalMemory();
            GetPcInfo.LastTenEventLogs();
        }
    }
}
