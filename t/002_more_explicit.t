# -*- perl -*-

# t/02_more_explicit.t - define a table explicit

; use Test::More tests => 6

; BEGIN {
        ; package Masa::Epha
        ; Test::More::use_ok( 
          'DBIx::Define', schema => undef,table => undef)

        ; schema('tour')
	; table('miko')
        ; column(sid  => &recordid)
        ; column(city => &integer)
        ; column(date_arrival => &date)
        }

; my ($scmn) = DBIx::Define->list_schema_names
; is($scmn,'tour','schema explicit')

; my $schema = DBIx::Define->get_schema('tour')
; isa_ok($schema,'DBIx::Define::Schema')

; my $table = $schema->get_table('miko')
; isa_ok($table,'DBIx::Define::Table')
; is($table->name,'miko',"table name")

; my @cols = $table->list_columns
; ok(@cols==3,'correct column count')

