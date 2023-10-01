#!/bin/sh
bak_before() { # backup before anything. options= 1st path of file to backup.
  if   [[ -d "${1}" ]] ; then
       sudo cp -rf ${1} ${1}.bak
  elif [[ -f "${1}" ]] ; then 
       sudo cp -f ${1} ${1}.bak &&
       [[ ! -f "${1}_os_default.bak" ]] && 
       sudo cp -f ${1} ${1}_os_default.bak
  fi
}

detect_os() {
  grep -m 1 -iho "${1}" /etc/*release >/dev/null 2>&1
}

has_command() {
  command -v ${1} >/dev/null 2>&1
}

modify_or_append() { # if string exists modify it, if not append. options= 1st string to find, 2nd string to modify or append (it also comment out strings), 3rd file name.
  sudo grep -qi ''${1}'' ${3} && sudo sed -i -e "s|.*${1}.*|${2}|" ${3} || sudo sh -c "echo '${2}' >> ${3}"
  #sudo sed -i -e 's|.*'$1'.*|'$2'|' -e t -i -e '$a '$2'' $3
}

# grub setup
grubup_write() {
  A0='/etc/default/grub'
  A1='GRUB_DEFAULT=saved'
  B1='#GRUB_SAVEDEFAULT=true'
  A2='GRUB_TIMEOUT=1'
  A3='GRUB_TIMEOUT_STYLE=menu'
  A4='GRUB_TERMINAL_INPUT=console'
  A5='#GRUB_TERMINAL_OUTPUT=console'
  A6='#GRUB_THEME=""'
  A7='GRUB_GFXMODE=auto' #auto #1920x1080
  A8='GRUB_GFXPAYLOAD_LINUX=keep'
  A9='GRUB_DISABLE_OS_PROBER=false'
  A10='GRUB_ENABLE_BLSCFG=false'
  A11='GRUB_DISABLE_SUBMENU=false'
  A12='GRUB_DISABLE_RECOVERY=false'
  A13='GRUB_CMDLINE_LINUX='
  # kernel parameters for arch based distros to enable apparmor
  A14='GRUB_CMDLINE_LINUX="rd.luks.options=discard rd.udev.log_priority=3 vt.global_cursor_default=0 loglevel=3 quiet splash sysrq_always_enabled=1 lsm=landlock,lockdown,yama,integrity,apparmor,bpf amdgpu.ppfeaturemask=0xffffffff amdgpu.gttsize=3000 pci=noats"'
  # kernel parameters for any distro
  A15='GRUB_CMDLINE_LINUX="rd.luks.options=discard rd.udev.log_priority=3 vt.global_cursor_default=0 loglevel=3 quiet splash sysrq_always_enabled=1 amdgpu.ppfeaturemask=0xffffffff amdgpu.gttsize=3000 pci=noats"'
  # make backup before any action
  bak_before ${A0};
  # writting /etc/default/grub
  modify_or_append ${A1::13}  ${A1}  ${A0}
  modify_or_append ${B1::17}  ${B1}  ${A0}
  modify_or_append ${A2::13}  ${A2}  ${A0}
  modify_or_append ${A3::19}  ${A3}  ${A0}
  modify_or_append ${A4::20}  ${A4}  ${A0}
  modify_or_append ${A5:1:21} ${A5}  ${A0}
  modify_or_append ${A6::11}  ${A6}  ${A0}
  modify_or_append ${A7::13}  ${A7}  ${A0}
  modify_or_append ${A8::22}  ${A8}  ${A0}
  modify_or_append ${A9::23}  ${A9}  ${A0}
  modify_or_append ${A10::19} ${A10} ${A0}
  modify_or_append ${A11::21} ${A11} ${A0}
  modify_or_append ${A12::22} ${A12} ${A0}
  
  if detect_os arch; then
       sudo grep -qi "${A14::19}" ${A0} && 
       sudo sed -i -e "s|.*${A14::19}.*|${A15}|" ${A0} || 
       sudo sh -c "echo '${A14}' >> ${A0}"
  else
       sudo grep -qi "${A15::19}" ${A0} && 
       sudo sed -i -e "s|.*${A15::19}.*|${A15}|" ${A0} || 
       sudo sh -c "echo '${A15}' >> ${A0}"
  fi
  # grub entries (shutdown and reboot).
  echo -e '#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the "exec tail" line above.

menuentry "Shutdown" --class shutdown {
	echo "System shutting down..."
	halt
}

menuentry "Restart" --class restart {
	echo "System rebooting..."
	reboot
}

#if [ ${grub_platform} == "efi" ]; then
#	menuentry "Firmware Setup (UEFI)" --class recovery {
#		fwsetup
#	}
#fi' | sudo tee /etc/grub.d/61_custom_leave_options >/dev/null
  
}

grubup() {
  # apply grub settings
  if has_command update-grub; then
         sudo update-grub >/dev/null 2>&1
    elif has_command zypper; then
         sudo grub2-mkconfig -o /boot/grub2/grub.cfg >/dev/null 2>&1
    elif detect_os fedora ; then
         sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg >/dev/null 2>&1 &&
         sudo grub2-editenv - unset menu_auto_hide >/dev/null 2>&1
    else 
         sudo grub-mkconfig -o /boot/grub/grub.cfg >/dev/null 2>&1
    fi
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [-w|-u]
          -w  write to /etc/default/grub
          -u  update grub"
    exit 1
fi

  if [ $1 == "-w" ]; then
    echo -e '\nrewritting grub config...'; grubup_write; echo -e 'done. \n'
  elif [ $1 == "-u" ]; then
    echo -e '\nupdating grub...'; grubup; echo -e 'done. \n'
  fi


