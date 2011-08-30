# -*- perl -*-

# t/001_load.t - check module loading and basic functionality

; use Test::More tests => 9

; BEGIN {
        ; package Kasa::Modo
        ; Test::More::use_ok( 'DBIx::Define' )

        ; column( sid    => &recordid )
        ; column( points => &integer )
        }

; my ($scmn) = DBIx::Define->list_schema_names
; is($scmn,'kasa','pkg as schema')

; my ($table) = DBIx::Define->get_table(name => 'Modo')
; isa_ok($table,'DBIx::Define::Table')
; is($table->name,'Modo',"table name")

; my @cols = $table->list_columns
; ok(@cols==2,'columns defined count')
; is($cols[0]->name,'sid','column 1')
; is($cols[1]->name,'points',"correct column names 2")

# get iterator in scalar context
; my $coliter = $table->list_columns
; is($coliter->()->name,$cols[0]->name,'col1 from iterator')
; is($coliter->()->name,$cols[1]->name,'col2 from iterator') 


