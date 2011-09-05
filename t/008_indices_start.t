# -*- perl -*-

; use lib '../lib';
; use Test::More tests => 5

; use Data::Section::Simple qw/ get_data_section /
; use Data::Dumper

; SKIP:
  { BEGIN:
     { eval { require SQL::Translator } 
     ; skip 'SQL::Translator is not installed',3 if $@
     ; use_ok('DBIx::Define::Translator')
     }

  ; package GoodStart::Define
  ; use DBIx::Define table => undef

  ; table('project');
  ; column(project_id => &recordid)->pk();
  ; column(name => &word)->unique();

  ; package main
  ; my $it = DBIx::Define->translate('goodstart')

  ; foreach my $db (qw/MySQL SQLite PostgreSQL Oracle/)
    { 
      my $sql = join("\x0a",grep { $_ !~ /-- Created on/ } 
	 split(/\n/,''.$it->producer($db)->($it)) ) . "\x0a";
      is($sql,get_data_section(lc $db),"DB $db");#print $sql
    }
  }

__DATA__
@@ mysql
-- 
-- Created by SQL::Translator::Producer::MySQL
-- 
SET foreign_key_checks=0;

--
-- Table: `project`
--
CREATE TABLE `project` (
  `project_id` integer NOT NULL,
  `name` varchar(32),
  UNIQUE INDEX `name_idx` (`name`),
  PRIMARY KEY (`project_id`)
);

SET foreign_key_checks=1;
@@ oracle
-- 
-- Created by SQL::Translator::Producer::Oracle
-- 
--
-- Table: project
--;

CREATE TABLE "project" (
  "project_id" number NOT NULL,
  "name" varchar2(32),
  PRIMARY KEY ("project_id")
);

CREATE UNIQUE INDEX "name_idx" on "project" ("name");

/
@@ sqlite
-- 
-- Created by SQL::Translator::Producer::SQLite
-- 

BEGIN TRANSACTION;

--
-- Table: project
--
CREATE TABLE project (
  project_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(32)
);

CREATE UNIQUE INDEX name_idx ON project (name);

COMMIT;
@@ postgresql
-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- 
--
-- Table: project
--
CREATE TABLE "project" (
  "project_id" integer NOT NULL,
  "name" character varying(32),
  CONSTRAINT "name_idx" UNIQUE ("name"),
  PRIMARY KEY ("project_id")
);
