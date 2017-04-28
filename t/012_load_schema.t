

; use strict; use warnings
; use Test::More
; use Data::Dumper

; use 5.014

; BEGIN {  
    use_ok('DBIx::Define');
}

; SKIP:
  { local $@
  ; my $skip = 3
  ; eval { require SQL::Translator } 
  ; skip 'SQL::Translator is not installed', $skip if $@
  ; eval { require DBI }
  ; skip 'DBI is not installed', $skip if $@
  ; eval { require DBD::SQLite }
  ; skip 'DBD::SQLite is not installed', $skip if $@
  
  ; use_ok('DBIx::Define::Translator')

  ; my $translator = DBIx::Define::Translator->new

  ; my $it
  ; { package DbSchema::Pool
    ; DBIx::Define->table

    ; column( s_id => &recordid )->pk()
    ; column( rand => &integer )

    ; package DbSchema::Dice
    ; DBIx::Define->table

    ; column ( s_id => &recordid )
    ; column ( type => &integer )
    ; column ( cnt  => &integer )

    ; package DbSchema::Player
    ; DBIx::Define->table

    ; column ( s_id => &recordid )
    ; column ( name => &varchar(64) )

    ; $it = DBIx::Define->table_iterator('dbschema','SQLite')
    }

  ; package main
  
  ; my $dbh = DBI->connect('dbi:SQLite:dbname=:memory:',
      { RaiseError => 1});

  ; while(my $ddl = $it->())
      { my $sth = $dbh->prepare($ddl->create)
      ; $sth->execute
      }
      
  ; my $schema2 = DBIx::Define->load_schema($dbh)
  ; say Dumper($schema2)
  }
  
; done_testing()
