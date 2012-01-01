# -*- perl -*-

; use strict; use warnings
; use Test::More

; use DBIx::Define ()
; BEGIN { use_ok('DBIx::Define::Types') }

; my %default_types = %DBIx::Define::Types::CONSTR

; foreach my $type (keys %default_types)
    { my $obj = DBIx::Define::Types->get_type_object($type)
    ; isa_ok($obj, 'DBIx::Define::Type')
	  if $default_types{$type} =~ /^DBIx::Define::Type::/
    ; isa_ok($obj, $default_types{$type})
    }

; SKIP:
  { eval { require SQL::Translator } 
  ; skip 'SQL::Translator is not installed',3 if $@
  ; use_ok('DBIx::Define::Translator')

  ; my $it
  ; { package DbSchema::Types
    ; DBIx::Define->import

    ; column( s_id => &recordid )->pk()
    ; column( rand => &integer )
    ; column( level => &smallint )
    ; column( agents => &bigint )

    ; column( growth => &number )
    ; column( length => &double )
    ; column( spreed => &decimal )
    ; column( amount => &money )

    ; column( start => &datetime )
    ; column( meeting => &time )
    ; column( event => &date )

    ; column( name => &varchar )
    ; column( description => &text )

    ; $it = DBIx::Define->translate('dbschema')
    }

  ;    print scalar $it->producer('SQLite')->($it)
  }
; done_testing()
