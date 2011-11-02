# -*- perl -*-

; use Test::More tests => 7

; use Data::Section::Simple qw/ get_data_section /
; use DBIx::Define ()

; SKIP:
  { eval { require SQL::Translator } 
  ; skip 'SQL::Translator is not installed',3 if $@
  ; use_ok('DBIx::Define::Translator')

  ; my $translator = DBIx::Define::Translator->new
  ; isa_ok($translator,'DBIx::Define::Translator')
  ; isa_ok($translator,'SQL::Translator')

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

    ; $it = DBIx::Define->translate('dbschema')
    }

  ; package main

  ; foreach my $db (qw/MySQL SQLite PostgreSQL Oracle/)
    { 
      my $sql = join("\x0a",grep { $_ !~ /-- Created on/ } 
	 split(/\n/,''.$it->producer($db)->($it)) ) . "\x0a";
      is($sql,get_data_section(lc $db),"DB $db");#print ''.$it->producer($db)->($it)
    }
  }

__DATA__
@@ mysql
-- 
-- Created by SQL::Translator::Producer::MySQL
-- 
SET foreign_key_checks=0;

--
-- Table: `Pool`
--
CREATE TABLE `Pool` (
  `s_id` integer NOT NULL,
  `rand` integer(11),
  PRIMARY KEY (`s_id`)
);

--
-- Table: `Dice`
--
CREATE TABLE `Dice` (
  `s_id` integer NOT NULL,
  `type` integer(11),
  `cnt` integer(11)
);

--
-- Table: `Player`
--
CREATE TABLE `Player` (
  `s_id` integer NOT NULL,
  `name` varchar(120)
);

SET foreign_key_checks=1;
@@ postgresql
-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- 
--
-- Table: Pool
--
CREATE TABLE "Pool" (
  "s_id" integer NOT NULL,
  "rand" bigint,
  PRIMARY KEY ("s_id")
);

--
-- Table: Dice
--
CREATE TABLE "Dice" (
  "s_id" integer NOT NULL,
  "type" bigint,
  "cnt" bigint
);

--
-- Table: Player
--
CREATE TABLE "Player" (
  "s_id" integer NOT NULL,
  "name" character varying(120)
);
@@ sqlite
-- 
-- Created by SQL::Translator::Producer::SQLite
-- 

BEGIN TRANSACTION;

--
-- Table: Pool
--
CREATE TABLE Pool (
  s_id INTEGER PRIMARY KEY NOT NULL,
  rand int(11)
);

--
-- Table: Dice
--
CREATE TABLE Dice (
  s_id int NOT NULL,
  type int(11),
  cnt int(11)
);

--
-- Table: Player
--
CREATE TABLE Player (
  s_id int NOT NULL,
  name varchar(120)
);

COMMIT;
@@ oracle
-- 
-- Created by SQL::Translator::Producer::Oracle
-- 
--
-- Table: Pool
--;

CREATE TABLE "Pool" (
  "s_id" number NOT NULL,
  "rand" number(11),
  PRIMARY KEY ("s_id")
);

--
-- Table: Dice
--;

CREATE TABLE "Dice" (
  "s_id" number NOT NULL,
  "type" number(11),
  "cnt" number(11)
);

--
-- Table: Player
--;

CREATE TABLE "Player" (
  "s_id" number NOT NULL,
  "name" varchar2(120)
);

/
