#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.swap_quote_and_shiftquote 1
/bin/echo -n .
$cli set remap.jis_unify_eisuu_to_kana 1
/bin/echo -n .
$cli set remap.jis_eisuu2optionL 1
/bin/echo -n .
$cli set remap.optionL2controlL 1
/bin/echo -n .
$cli set remap.jis_yen2backslash 1
/bin/echo -n .
/bin/echo
