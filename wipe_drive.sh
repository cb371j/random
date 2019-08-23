#!/bin/bash
sudo parted -s /dev/sda mklabel gpt
sudo parted -s /dev/sdb mklabel gpt
sudo parted -s /dev/sdc mklabel gpt
sudo parted -s /dev/sdd mklabel gpt
sudo parted -s /dev/sde mklabel gpt
sudo parted -s /dev/sdf mklabel gpt
sudo parted -s /dev/sdh mklabel gpt

