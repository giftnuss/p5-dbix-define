# -*- perl -*-

; use strict; use warnings
; use Test::More
; BEGIN { use_ok('DBIx::Define::Types') }

; my %default_types = %DBIx::Define::Types::CONSTR

; foreach my $type (keys %default_types)
    { $obj = DBIx::Define::Types->get_type_object($type)
    ; isa_ok($obj, 'DBIx::Define::Type')
	  if $default_types{$type} =~ /^DBIx::Define::Type::/
    ; isa_ok($obj, $default_types{$type})
    }

; done_testing()
