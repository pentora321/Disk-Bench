# Disk-Bench
🚀 DiskBench - Disk Speed Test Script

DiskBench is a Bash script for testing the read and write speed of HDD, SSD, and NVMe drives. It utilizes DD and HDParm to measure disk performance.
✨ Features:

✔ Supports DD and HDParm tests for accurate disk benchmarking
✔ Automatic partitioning and formatting before testing
✔ Measures write and read speed using DD and cache/buffer read speed using HDParm
✔ Cleans up and resets the disk after testing (useful for temporary tests)
✔ Compatible with Linux distributions: CentOS 7, AlmaLinux 8/9, Rocky 9, Debian, Ubuntu
🛠 How to Use
1️⃣ Download and Run the Script

wget https://codeload.github.com/pentora321/Disk-Bench/zip/refs/heads/main -O disk_bench.sh
chmod +x disk_bench.sh
sudo ./dis_kbench.sh

2️⃣ Manual Execution (Copy & Run Manually)

If you want to run the script manually, follow these steps:

nano disk_bench.sh  # Or use vi disk_bench.sh

Paste the script content inside the file, then save and exit. After that, run:

chmod +x disk_bench.sh
sudo ./disk_bench.sh

3️⃣ Select the Disk to Test

The script will list available disks. Enter the disk name, e.g.:

Enter the disk you want to test (e.g., sdb, nvme0n1): sdb

4️⃣ Select the Test Type

Choose the type of test:

1️⃣  Test with DD (Measures read/write speed)  
2️⃣  Test with HDParm (Quick read test)  
3️⃣  Run both tests (DD & HDParm)  

5️⃣ (If DD Test is Selected) Set Block Size and Count

Enter block size in GB (e.g., 1, 4): 1  
Enter count (number of blocks): 4  
Total Test Size: 4 GB

6️⃣ View Test Results

After the test, the results will be displayed, for example:

Write Speed: 450 MB/s  
Read Speed: 520 MB/s  
Cached Read Speed: 5.4 GB/s  
Buffered Read Speed: 480 MB/s  

7️⃣ Cleanup and Restore Disk

After the test, the script will wipe all partitions and restore the disk to its original state.

⚠ Warning: All data on the selected disk will be erased! Make sure to back up your data before running the test.

✨ Now, test your disk and evaluate its performance! 🚀

# Disk-Bench
🚀  اسکریپت تست سرعت دیسک

DiskBench یک اسکریپت Bash برای تست سرعت خواندن و نوشتن هارددیسک (HDD)، اس‌اس‌دی (SSD) و NVMe است. این اسکریپت از ابزارهای DD و HDParm برای اندازه‌گیری عملکرد دیسک استفاده می‌کند.
✨ ویژگی‌ها:

✔ پشتیبانی از تست DD و HDParm برای اندازه‌گیری دقیق سرعت دیسک
✔ پارتیشن‌بندی و فرمت خودکار دیسک مورد نظر قبل از تست
✔ اندازه‌گیری سرعت نوشتن و خواندن با DD و سرعت خواندن کش و بافر با HDParm
✔ پاک‌سازی و ریست دیسک پس از تست (مناسب برای تست‌های موقت)
✔ سازگاری با توزیع‌های لینوکس: CentOS 7، AlmaLinux 8/9، Rocky 9، Debian، Ubuntu
🛠 نحوه استفاده از اسکریپت
1️⃣ دانلود و اجرای اسکریپت

wget https://codeload.github.com/pentora321/Disk-Bench/zip/refs/heads/main -O disk_bench.sh
chmod +x disk_bench.sh
sudo ./disk_bench.sh

2️⃣ اجرای دستی اسکریپت (کپی و اجرا به‌صورت دستی)

اگر می‌خواهید اسکریپت را دستی اجرا کنید، مراحل زیر را دنبال کنید:

nano disk_bench.sh  # یا استفاده از vi disk_bench.sh

محتوای اسکریپت را درون فایل جای‌گذاری کنید، سپس فایل را ذخیره و خارج شوید. بعد از آن، دستورات زیر را اجرا کنید:

chmod +x disk_bench.sh
sudo ./disk_bench.sh

3️⃣ انتخاب دیسک مورد نظر برای تست

بعد از اجرای اسکریپت، لیست دیسک‌های موجود نمایش داده می‌شود. نام دیسک مورد نظر را وارد کنید، مثلاً:

Enter the disk you want to test (e.g., sdb, nvme0n1): sdb

4️⃣ انتخاب نوع تست

یکی از گزینه‌های زیر را انتخاب کنید:

1️⃣  تست با DD (اندازه‌گیری سرعت خواندن و نوشتن)  
2️⃣  تست با HDParm (تست سریع سرعت خواندن)  
3️⃣  اجرای هر دو تست (DD & HDParm)  

5️⃣ (در صورت انتخاب تست DD) تنظیم اندازه بلاک و تعداد بلاک‌ها

Enter block size in GB (e.g., 1, 4): 1  
Enter count (number of blocks): 4  
Total Test Size: 4 GB

6️⃣ مشاهده نتایج تست

پس از انجام تست، سرعت خواندن و نوشتن نمایش داده می‌شود، مثلاً:

Write Speed: 450 MB/s  
Read Speed: 520 MB/s  
Cached Read Speed: 5.4 GB/s  
Buffered Read Speed: 480 MB/s  

7️⃣ پاک‌سازی و بازگردانی دیسک

بعد از تست، اسکریپت تمامی پارتیشن‌ها را حذف کرده و دیسک را به حالت اولیه بازمی‌گرداند.

⚠ هشدار: تمامی اطلاعات دیسک انتخاب شده حذف خواهد شد! قبل از اجرای تست، از اطلاعات خود بکاپ بگیرید.

✨ اکنون دیسک خود را تست کنید و عملکرد آن را بسنجید! 🚀
