

; use strict; use warnings
; use Test::More

; BEGIN {  }

; package T::Custom::Autoload

; sub AUTOLOAD
    {
    }

; package main

; use_ok('DBIx::Define', provide_autoload => 'T::Custom::Autoload')

; done_testing()
