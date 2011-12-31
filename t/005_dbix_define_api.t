# -*- perl -*-
; use strict; use warnings
; use Test::More tests => 17

; use DBIx::Define

; SKIP:
    { eval { require Test::ClassAPI }
    ; skip "Test::ClassAPI not installed.",17 if $@

    ; Test::ClassAPI->execute('complete')
    }

; # end of coding

__DATA__

DBIx::Define=class

[DBIx::Define]
current_schema=method
current_table=method
dumper=method
get_schema=method
get_table=method
import=method
list_schema_names=method
load_schema=method
new_schema=method
new_table=method
register_schema=method
register_table=method
set_current_schema=method
set_current_table=method
table=method
translate=method
