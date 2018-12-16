DPDK Fast Install
=================

# ubuntu depends install
```
sudo apt install python-minimal build-essential vim libnuma-dev
sudo apt install linux-headers-$(uname -r) libpcap-dev
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

make
sudo make install
```




# hugepages, fstab.....

# dpdk-devbind....
