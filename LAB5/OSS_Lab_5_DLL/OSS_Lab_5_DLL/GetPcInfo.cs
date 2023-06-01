using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Management;
using System.Text;
using System.Threading.Tasks;

namespace OSS_Lab_5_DLL
{
    public class GetPcInfo
    {
        public static void GetPcName()
        {
            try
            {
                ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT Name FROM Win32_ComputerSystem");

                foreach (ManagementObject queryObj in searcher.Get())
                {
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine("PC INFO:");
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine("Name: {0}", queryObj["Name"]);
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        public static void GetHDDParams()
        {
            try
            {
                ManagementObject moHD = new ManagementObject("Win32_LogicalDisk.DeviceID=\"C:\"");

                moHD.Get();
                {
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine("HDD Info:");
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine("Serial number: " + moHD["VolumeSerialNumber"].ToString());
                    Console.WriteLine("Drive Type: " + moHD["DriveType"].ToString());
                    double size = Convert.ToDouble(moHD["Size"]) / 1024 / 1024 / 1024;
                    double freeSpace = Convert.ToDouble(moHD["FreeSpace"]) / 1024 / 1024 / 1024;
                    Console.WriteLine("Size: " + Math.Round(size, 2) + "GB".ToString());
                    Console.WriteLine("FreeSpace: " + Math.Round(freeSpace, 2) + "GB".ToString());
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        public static void GetCurrentCPU()
        {
            try
            {
                ManagementObjectSearcher searcher = new ManagementObjectSearcher("select Name, PercentProcessorTime from Win32_PerfFormattedData_PerfOS_Processor");

                Console.WriteLine("-----------------------------------");
                Console.WriteLine("Current CPU Usage:");
                Console.WriteLine("-----------------------------------");
                foreach (ManagementObject obj in searcher.Get())
                {
                    int i = 0;
                    var usage = obj["PercentProcessorTime"];
                    var name = obj["Name"];
                    Console.WriteLine(name + " : " + usage + "%");
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            Console.WriteLine("-----------------------------------");
            Console.WriteLine();
        }

        public static void GetPhysicalMemory()
        {
            try
            {
                ManagementObjectSearcher search = new ManagementObjectSearcher("root\\CIMV2", "Select TotalVisibleMemorySize, FreePhysicalMemory from Win32_OPeratingSystem");

                foreach (ManagementObject x in search.Get())
                {
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine("Physical Memory Info:");
                    Console.WriteLine("-----------------------------------");
                    ulong totalMemory = (ulong)x["TotalVisibleMemorySize"];
                    ulong freeMemory = (ulong)x["FreePhysicalMemory"];
                    Console.WriteLine("Total Physical Memory: " + totalMemory /1024 + "MB");
                    Console.WriteLine("Total Free Physical Memory: " + freeMemory/1024 + "MB");
                    Console.WriteLine("-----------------------------------");
                    Console.WriteLine();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            
        }

        public static void LastTenEventLogs()
        {
            string eventLogName = "Application";
            EventLog eventLog = new EventLog();
            eventLog.Log = eventLogName;
            int count = 0;
            Console.WriteLine("-----------------------------------");
            Console.WriteLine("Last Ten EventLogs:");
            Console.WriteLine("-----------------------------------");
            foreach (EventLogEntry log in eventLog.Entries)
            {
                if (count == 10)
                {
                    break;
                }
                Console.WriteLine("{0}\n", log.Source);
                count++;
            }
            Console.WriteLine("-----------------------------------");
            Console.WriteLine();

        }
    }
}
