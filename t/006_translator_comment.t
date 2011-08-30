# -*- perl -*-

; use Test::More tests => 7

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

    ; column( s_id => &recordid )->pk()->comment('a unique number')
    ; column( rand => &integer )->comment('a random number')

    ; $it = DBIx::Define->translate('dbschema')
    ; $it->no_comments(1)
    }

  ; package main
  # if print, don't forget to force scalar context

  ; my $mysql = $it->producer('MySQL')->($it)
  ; my $expect_mysql = <<__SQL__
SET foreign_key_checks=0;

CREATE TABLE `Pool` (
  `s_id` integer NOT NULL comment 'a unique number',
  `rand` integer(11) comment 'a random number',
  PRIMARY KEY (`s_id`)
);

SET foreign_key_checks=1;

__SQL__
  ; is($mysql,$expect_mysql,'MySQL')

  ; $sqlite = $it->producer('SQLite')->($it)

  ; my $expect_sqlite = <<__SQL__
BEGIN TRANSACTION;

CREATE TABLE Pool (
  -- a unique number
  s_id INTEGER PRIMARY KEY NOT NULL,
  -- a random number
  rand int(11)
);

COMMIT;
__SQL__
  ; is($sqlite,$expect_sqlite,'SQLite')

  ; $postgresql = $it->producer('PostgreSQL')->($it)
  ; $expect_postgresql = <<__SQL__
CREATE TABLE "Pool" (
  -- a unique number
  "s_id" integer NOT NULL,
  -- a random number
  "rand" bigint,
  PRIMARY KEY ("s_id")
);

__SQL__
  ; is($postgresql,$expect_postgresql,'PostgreSQL')
  
  # don't know what the / means and if it is correct
  ; my $oracle = $it->producer('Oracle')->($it)
  ; $expect_oracle = <<__SQL__
CREATE TABLE "Pool" (
  "s_id" number NOT NULL,
  "rand" number(11),
  PRIMARY KEY ("s_id")
);

/

__SQL__
  ; is($oracle,$expect_oracle,'Oracle')
  }


