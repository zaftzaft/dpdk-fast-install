DPDK Fast Install
=================

# ubuntu depends install
```
sudo apt install python-minimal build-essential vim libnuma-dev gdb  libfdt-dev
sudo apt install linux-headers-$(uname -r) libpcap-dev


sed -ri s/"1/"0/ /etc/apt/apt.conf.d/20auto-upgrades

```

# Centos
```
sudo yum install make gcc kernel-devel numactl-devel
#sudo yum install infiniband-diags-devel
yum install libibverbs
```

# Download
```bash
# wget http://fast.dpdk.org/rel/dpdk-18.11.tar.xz
wget https://fast.dpdk.org/rel/dpdk-19.02.tar.xz
```

# Install
```
make config T=x86_64-native-linuxapp-gcc
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
sed -ri 's,(IEEE1588=).*,\1y,' build/.config
sed -ri 's,(IP_FRAG_MAX_FRAG=).*,\18,' build/.config

# Netcope
sed -ri 's,(PMD_SZEDATA2=).*,\1y,' build/.config

# Mellanox
sed -ri 's,(MLX5_PMD=).*,\1y,' build/.config

make
# all core
make -j `grep -c ^processor /proc/cpuinfo 2>/dev/null`

# Debug make
EXTRA_CFLAGS=-g make


sudo make install
```




# hugepages, fstab.....
## /etc/default/grub
```
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=64"

## for IOMMU
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=40 iommu=pt intel_iommu=on"
```

## grub update
- Ubuntu
```
update-grub
```

- CentOS
```
grub2-mkconfig -o /boot/grub2/grub.cfg
```


## /etc/fstab
```
hugetlbfs           /dev/hugepages  hugetlbfs      defaults        0 0
```

## .bashrc
```
export RTE_SDK=/usr/local/share/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
```

# dpdk-devbind....
```dpdk-init.sh
modprobe uio
insmod /opt/dpdk-19.02/build/kmod/igb_uio.ko
insmod /opt/dpdk-19.02/build/kmod/rte_kni.ko

dpdk-devbind -b igb_uio 0000:18:00.0
dpdk-devbind -b igb_uio 0000:18:00.1
```



# uninstall DPDK
```

rm /usr/local/lib/librte_*
rm /usr/local/lib/libdpdk.a
rm -r /usr/local/share/dpdk
rm -r /usr/local/include/dpdk
```





# appendix
## ubuntu useradd
```
sudo useradd -m -s /bin/bash USER
sudo gpasswd -a USER sudo
sudo passwd USER
```

## Mellanox OFED
```

apt install libmnl-dev
apt update
./mlnxofedinstall --upstream-libs --dpdk
```

## Mellanox TOOLS (MFT)
http://www.mellanox.com/page/management_tools

```
./install.sh
mst start
```

```
mlxlink -d /dev/mst/XXXXXXXXX


mlxlink -d /dev/mst/XXXXXXXXX --show_fec
```


## Check IOMMU
```
dmesg | grep -e DMAR -e IOMMU
```
