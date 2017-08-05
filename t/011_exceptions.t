

; use strict; use warnings
; use Test::More
; use Test::Exception

; BEGIN {  
    use_ok('DBIx::Define');
}

throws_ok { DBIx::Define->register_table }
 qr/Argument 'table' is required/, 'missing table argument error';

; done_testing()
