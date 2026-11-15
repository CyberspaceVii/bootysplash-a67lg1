#!/system/bin/sh
ui_print "Bootysplash CyberspaceVII"
ui_print " "

[ "$(getprop ro.product.device)" = A67L ] || abort "Fail! This module is for the Foxxd A67L Gen 1."
[ "$KSU" = true ] || abort "Fail! KernelSU Next is required."



ui_print "Installing boot logo, animation and sound..."

BMP="$MODPATH/logo.bmp"
BK=/data/adb/cyberspacevii/bootysplash-a67lg1
[ -f "$BMP" ] || abort "Fail! logo.bmp missing."
SZ=$(stat -c %s "$BMP")
want=$(sha256sum "$BMP" | cut -d' ' -f1)
mkdir -p "$BK"

for p in logo fbootlogo; do
  dev=/dev/block/by-name/$p
  [ -b "$dev" ] || abort "Fail! No $p partition."
  [ "$(blockdev --getsize64 "$dev")" -ge "$SZ" ] || abort "Fail! $p partition too small."
  hdr=$(dd if="$dev" bs=30 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n')
  case "$hdr" in 424d*) ;; *) abort "Fail! Unexpected $p partition." ;; esac
  [ "$(echo "$hdr" | cut -c37-60)" = d00200004006000001000800 ] || abort "Fail! Unsupported display."
done

ok=1
for p in logo fbootlogo; do
  dev=/dev/block/by-name/$p
  if [ ! -s "$BK/$p.img" ]; then
    dd if="$dev" of="$BK/$p.img" bs=1M 2>/dev/null || abort "Fail! Could not back up $p."
  fi
  dd if="$BMP" of="$dev" bs=4096 conv=fsync,notrunc 2>/dev/null
  [ "$(head -c "$SZ" "$dev" | sha256sum | cut -d' ' -f1)" = "$want" ] || ok=0
done
rm -f "$BMP"

[ "$ok" = 1 ] && ui_print "Success!" || ui_print "Fail!"
