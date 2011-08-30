# -*- perl -*-

; use Test::More tests => 3

; use Data::Dumper

  ; use DBIx::Define ()

; SKIP:
  { eval { require SQL::Translator } 
  ; skip 'SQL::Translator is not installed',3 if $@
  ; use_ok('DBIx::Define::Translator')

  ; my $translator = new DBIx::Define::Translator
  ; isa_ok($translator,'DBIx::Define::Translator')
  ; isa_ok($translator,'SQL::Translator')

  ; my $it
  ; { package DbSchema::Pool
    ; DBIx::Define->table

    ; column( s_id => &recordid )->pk()
	; column( player => &recordid )->fk('Player')
    ; column( rand => &integer )

    ; package DbSchema::Dice
    ; DBIx::Define->table

    ; column ( s_id => &recordid )->pk()
    ; column ( type => &integer )
    ; column ( cnt  => &integer )

    ; package DbSchema::Player
    ; DBIx::Define->table

    ; column ( s_id => &recordid )->pk()
    ; column ( name => &varchar(64) )

    ; $it = DBIx::Define->translate('dbschema')
    }

  ; package main
  #; print $it->producer('MySQL')->($it),"\n"
  #; print $it->producer('SQLite')->($it),"\n"
  ; print $it->producer('PostgreSQL')->($it),"\n"
  #; print $it->producer('Oracle')->($it),"\n"

   # ; print DBIx::Define->dumper
  }

