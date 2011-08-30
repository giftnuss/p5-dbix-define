use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'DBIx::Define',
      dist_version    => '0.01',
      dist_author     => 'Sebastian Knapp <sk@computer-leipzig.com>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'abstract DDL statements with ORM support',

      requires =>
          { perl => 5.006,
            'HO::class' => '0.60',
            'Package::Subroutine' => '0.14'
	  },
      build_requires =>
          { 'Data::Section::Simple' => '0.02'
          }
      recommends =>
          { 'SQL::Translator' => '0.11008'
          }
    )->create_build_script;