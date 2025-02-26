#!/bin/bash

# 🎨 تعریف رنگ‌ها برای نمایش زیباتر
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# 📌 نمایش پیام خوشامدگویی
echo -e "$CYAN"
echo "#################################################"
echo -e "$GREEN"
echo "           This script is created by MOHAMMAD REFAEI :)"
echo -e "$YELLOW"
echo "           Welcome to my Script"
echo "           Disk Bench"
echo "           Support Os (Cent-Os7-Alma8,9-Rocky9-Debian-Ubuntu)"
echo -e "$CYAN"
echo "           Version 1.1.1"
echo "#################################################"
echo -e "$CYAN"
sleep 2
clear

# 🔍 لیست دیسک‌های موجود
list_disks() {
    echo -e "${BOLD}${CYAN}Available Disks:${RESET}"
    lsblk -d -o NAME,SIZE,TYPE | grep disk
}

# 📝 گرفتن اطلاعات از کاربر
get_user_inputs() {
    echo -e "\n${BOLD}${CYAN}Test Parameters:${RESET}"
    
    list_disks
    read -p "Enter the disk you want to test (e.g., sdb, nvme0n1): " disk

    echo -e "\n${BOLD}${CYAN}Choose the test type:${RESET}"
    echo -e " 1️⃣  Test with ${YELLOW}DD${RESET}"
    echo -e " 2️⃣  Test with ${YELLOW}HDParm${RESET}"
    echo -e " 3️⃣  Test with ${YELLOW}Both (DD & HDParm)${RESET}"
    read -p "Enter your choice (1/2/3): " test_choice

    if [[ $test_choice == "1" || $test_choice == "3" ]]; then
        read -p "Enter block size in GB (e.g., 1, 4): " dd_block_size_gb
        read -p "Enter count (number of blocks): " dd_count
        total_size_gb=$((dd_block_size_gb * dd_count))

        echo -e "${YELLOW}Selected Disk: /dev/$disk${RESET}"
        echo -e "${YELLOW}Total Test Size: $total_size_gb GB${RESET}"
    fi
}

# 🚀 پارتیشن‌بندی و ساخت فایل‌سیستم
partition_and_format() {
    echo -e "${BOLD}${CYAN}Partitioning and Formatting /dev/$disk...${RESET}"
    echo -e "${YELLOW}Creating a new partition on /dev/$disk...${RESET}"
    
    wipefs -a /dev/$disk
    parted /dev/$disk mklabel gpt
    parted /dev/$disk mkpart primary ext4 0% 100%

    sleep 5

    partition=$(lsblk -ln -o NAME /dev/$disk | awk 'NR==2')

    if [[ -z "$partition" ]]; then
        echo -e "${RED}Partitioning failed! Exiting...${RESET}"
        exit 1
    fi

    partition_path="/dev/$partition"
    echo -e "${GREEN}Partition created: $partition_path${RESET}"

    mkfs.ext4 $partition_path -F

    mount_point="/mnt/dd_disk_test"
    mkdir -p $mount_point
    mount $partition_path $mount_point

    if mountpoint -q $mount_point; then
        echo -e "${GREEN}Partition mounted successfully at $mount_point${RESET}"
    else
        echo -e "${RED}Failed to mount partition! Exiting...${RESET}"
        exit 1
    fi

    test_folder="$mount_point/dd_test"
    mkdir -p $test_folder
    test_file="$test_folder/dd_test.img"
}

# 🛠 اجرای تست سرعت با `dd`
run_dd_test() {
    echo -e "${BOLD}${CYAN}Running DD Write Test...${RESET}"
    dd if=/dev/zero of=$test_file bs=${dd_block_size_gb}G count=$dd_count oflag=dsync status=progress 2> dd_write_output.log

    echo -e "${BOLD}${CYAN}Running DD Read Test...${RESET}"
    dd if=$test_file of=/dev/null bs=${dd_block_size_gb}G count=$dd_count iflag=direct status=progress 2> dd_read_output.log

    write_speed=$(grep -oP '[0-9]+(\.[0-9]+)? [KMGT]?B/s' dd_write_output.log | tail -1)
    read_speed=$(grep -oP '[0-9]+(\.[0-9]+)? [KMGT]?B/s' dd_read_output.log | tail -1)

    echo -e "${GREEN}DD Disk Test Results:${RESET}"
    echo -e "  ${YELLOW}Write Speed:${RESET} $write_speed"
    echo -e "  ${YELLOW}Read Speed:${RESET} $read_speed"

    rm -f dd_write_output.log dd_read_output.log
}

# 🚀 اجرای تست سرعت با `hdparm`
run_hdparm_test() {
    echo -e "${BOLD}${CYAN}Running HDParm Test on /dev/$disk...${RESET}"
    
    hdparm -Tt /dev/$disk | tee hdparm_output.log

    cached_speed=$(grep "Timing cached reads" hdparm_output.log | awk '{print $(NF-1), $NF}')
    buffered_speed=$(grep "Timing buffered disk reads" hdparm_output.log | awk '{print $(NF-1), $NF}')

    echo -e "${GREEN}HDParm Disk Test Results:${RESET}"
    echo -e "  ${YELLOW}Cached Read Speed:${RESET} $cached_speed"
    echo -e "  ${YELLOW}Buffered Read Speed:${RESET} $buffered_speed"

    rm -f hdparm_output.log
}

# 🔚 پاک‌سازی و خروج
cleanup_and_exit() {
    echo -e "${BOLD}${CYAN}Cleaning up...${RESET}"

    if mountpoint -q $mount_point; then
        umount $mount_point
    fi

    rm -rf $mount_point

    echo -e "${RED}Wiping all partitions on /dev/$disk...${RESET}"
    wipefs -a /dev/$disk
    parted /dev/$disk mklabel gpt

    echo -e "${GREEN}Test completed successfully. The disk /dev/$disk is now empty.${RESET}"
}

# 📌 اجرای تست‌های انتخاب شده توسط کاربر
get_user_inputs

if [[ $test_choice == "1" ]]; then
    partition_and_format
    run_dd_test
    cleanup_and_exit
elif [[ $test_choice == "2" ]]; then
    run_hdparm_test
elif [[ $test_choice == "3" ]]; then
    partition_and_format
    run_dd_test
    run_hdparm_test
    cleanup_and_exit
else
    echo -e "${RED}Invalid choice! Exiting...${RESET}"
    exit 1
fi
