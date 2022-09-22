# Generated by Anaconda 34.25.0.29
# Generated by pykickstart v3.32
#version=RHEL9
# Use graphical install
graphical

%addon com_redhat_kdump --disable

%end

%addon com_redhat_oscap
    content-type = scap-security-guide
    datastream-id = scap_org.open-scap_datastream_from_xccdf_ssg-rhel9-xccdf-1.2.xml
    xccdf-id = scap_org.open-scap_cref_ssg-rhel9-xccdf-1.2.xml
    profile = xccdf_org.ssgproject.content_profile_stig_gui
%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate
network  --hostname=rhel9work

%packages
@^workstation-product-environment
aide
audit
fapolicyd
firewalld
opensc
openscap
openscap-scanner
openssh-server
openssl-pkcs11
policycoreutils
rng-tools
rsyslog
rsyslog-gnutls
scap-security-guide
tmux
usbguard
# for tpm unlocking
clevis-dracut 
clevis-luks
clevis-systemd
-iprutils
-krb5-workstation
-rsh-server
-sendmail
-telnet-server
-tftp-server
-tuned
-vsftpd

%end

# Run the Setup Agent on first boot
firstboot --disable

# Generated using Blivet version 3.4.0
ignoredisk --only-use=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=1024
part /boot/efi --fstype="efi" --ondisk=sda --size=600 --fsoptions="umask=0077,shortname=winnt"
part pv.308 --fstype="lvmpv" --ondisk=sda --grow --encrypted --passphrase='temppass' --luks-version=luks2
volgroup rhel_test --pesize=4096 pv.308
logvol /home --fstype="xfs" --percent=8 --name=home --vgname=rhel_test
logvol /var --fstype="xfs" --percent=8 --name=var --vgname=rhel_test
logvol /tmp --fstype="xfs" --percent=8 --name=tmp --vgname=rhel_test
logvol swap --fstype="swap" --size=4036 --name=swap --vgname=rhel_test
logvol /var/log --fstype="xfs" --percent=10 --name=var_log --vgname=rhel_test
logvol /var/log/audit --fstype="xfs" --percent=8 --name=var_log_audit --vgname=rhel_test
logvol /var/tmp --fstype="xfs" --percent=8 --name=var_tmp --vgname=rhel_test
logvol / --fstype="xfs" --percent=40 --name=root --vgname=rhel_test


# System timezone
timezone America/Detroit --utc

# Root password
rootpw --iscrypted $6$khyrK8aoPudRnFy4$yPv83XCQ9tVgoSpsC6.YsVJrcE7P6iQd3cOiFd1vMSAVpDA7TqZHoQX.Mz0TSh.TE66/.VS/ZwpaHA6kWboWb/
user --groups=wheel --name=ansible_user --password=$6$LSGHLICmHAAuKGc/$yrrv4051kwLQ3pUcFt6RaOGwywAt0MLSiJHGglE/HYdklkKhJ2pPViNf1ET9hUgND23SfDoLpVfqSPft7xiI7. --iscrypted --gecos="ansible_user"

# %post
# clevis luks bind -k - -d /dev/sda3 tpm2 '{"hash":"sha1","key":"rsa"}' <<< 'temppass'
# dracut -fv --regenerate-all
# reboot
# %end
