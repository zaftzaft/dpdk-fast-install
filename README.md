DPDK Fast Install
=================

# ubuntu depends install
```
sudo apt install python-minimal build-essential vim libnuma-dev
sudo apt install linux-headers-$(uname -r) libpcap-dev
```

# Centos
```
sudo yum install make gcc kernel-devel numactl-devel
#sudo yum install infiniband-diags-devel
yum install libibverbs
```

# Download
```
wget http://fast.dpdk.org/rel/dpdk-18.11.tar.xz
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
sudo make install
```




# hugepages, fstab.....
## /etc/default/grub
```
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=64"
```

## grub update
- CentOS
```
grub2-mkconfig -o /boot/grub2/grub.cfg
```

## /etc/fstab
```
hugetlbfs           /dev/hugepages  hugetlbfs      defaults        0 0
```

# dpdk-devbind....
