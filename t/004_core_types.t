# -*- perl -*-

; use Test::More tests => 3
; BEGIN { use_ok('DBIx::Define::Type') }

; $id = DBIx::Define::Type->get_type_object('recordid')

; isa_ok($id,'DBIx::Define::Type')
; isa_ok($id,'DBIx::Define::Type::Recordid')

; use Data::Dumper
; print Dumper ($id)