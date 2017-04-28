use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'DBIx::Define',
      dist_version    => '0.03',
      dist_author     => 'Sebastian Knapp <rock@ccls-online.de>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'abstract DDL statements with ORM support',

      requires =>
          { perl => 5.006,
            'HO::class' => '0.05',
            'Package::Subroutine' => '0.14.000',
            'Class::Load' => 0,
            'parent' => 0,
        'SQL::Translator' => '0.11021'
      },
      build_requires =>
          { 'Test::More' => 0,
            'Data::Section::Simple' => '0.02',
        'Test::Exception' => '0.43',
        'DBI' => '1.636',
        'DBD::SQLite' => '1.54'
          }
    )->create_build_script;
