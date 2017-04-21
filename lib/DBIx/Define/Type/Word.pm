  package DBIx::Define::Type::Word;
# *********************************
  our $VERSION ='0.01';
# *********************
; use strict; use warnings
; use base 'DBIx::Define::Type::Varchar'

; our $defaultsize = 32

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }

; 1

__END__
