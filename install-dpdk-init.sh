service=dpdk-init

systemctl is-enabled $service
if [ $? -eq 0 ]; then
  systemctl stop $service
fi


if [ -d /usr/lib/systemd/system/ ]; then
  unit_dir=/usr/lib/systemd/system
else
  unit_dir=/etc/systemd/system
fi


tee ${unit_dir}/${service}.service << EOS
[Unit]
Description=DPDK init

[Service]
Type=oneshot
ExecStart=/bin/bash /opt/dpdk-init.sh

[Install]
WantedBy=default.target
EOS


systemctl daemon-reload
systemctl enable $service
systemctl start $service

