

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

  ; my @drop = (
      'DROP TABLE "Pool";',
      'DROP TABLE "Dice";',
      'DROP TABLE "Player";'
    );
  ; my @create = (
'CREATE TABLE "Pool" (
  "s_id" INTEGER PRIMARY KEY NOT NULL,
  "rand" int(11)
);',
'CREATE TABLE "Dice" (
  "s_id" int NOT NULL,
  "type" int(11),
  "cnt" int(11)
);',
'CREATE TABLE "Player" (
  "s_id" int NOT NULL,
  "name" varchar(120)
);')

  ; my $dbh = DBI->connect('dbi:SQLite:dbname=:memory:',
      { RaiseError => 1});

  ; for my $i (0..2)
      { my $ddl = $it->()
      ; is($ddl->drop, $drop[$i],'drop ' . $ddl->name)
      ; is($ddl->create, $create[$i],'create ' . $ddl->name)
      ; my $sth = $dbh->prepare($ddl->create)
      ; ok($sth->execute,"execute create")
      }

  #; say $dbh->get_info( $DBI::Const::GetInfoType::GetInfoType{SQL_DATABASE_NAME} );
  #; say $dbh->get_info( $DBI::Const::GetInfoType::GetInfoType{SQL_CATALOG_NAME} );
  #; say $dbh->get_info( $DBI::Const::GetInfoType::GetInfoType{SQL_DATA_SOURCE_NAME} );

  ; my $schema2 = DBIx::Define->load_schema($dbh)

  ; my $it2 = DBIx::Define->translate($schema2)
  ; say $it2->producer('SQLite')->($it2)
  #; say Dumper($schema2)
  }

; done_testing()
