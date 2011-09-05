# -*- perl -*-

# t/009_unit_key.t - unit tests for DBIx::Define::Key

; use strict; use warnings
; use Test::More tests => 4
; BEGIN {
   use_ok('DBIx::Define::Key');
   use_ok('DBIx::Define::Column');
};

use Data::Dumper;

my $testkey = DBIx::Define::Key->new;

isa_ok($testkey,'DBIx::Define::Key');

my $col1 = DBIx::Define::Column->new('col1');

$testkey->columns('<',$col1);

is($testkey->get_name,'col1_idx','simple name');


