  package DBIx::Define::Table::DDL
; use strict; use warnings
# ********************************
; our $VERSION  ='0.01'
; our $AUTHORITY='cpan:SKNPP'
# ***************************
; use DBIx::Define::Schema ()
; use DBIx::Define::Key ()

; use HO::class
    init => 'hash',
    _ro => table => '$',
    _ro => drop => '$',
    _ro => create => '$'
    
; ; use overload
    '""' => "name",
    fallback => 1
    
; sub name { $_[0]->table->name }

; 1

__END__
