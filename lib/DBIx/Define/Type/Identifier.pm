  package DBIx::Define::Type::Identifier;
# ***************************************
  our $VERSION = '0.01';
# **********************
; use strict; 
; use parent 'DBIx::Define::Type::Varchar'

; our $defaultsize = 64

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }
    
; 1

__END__

