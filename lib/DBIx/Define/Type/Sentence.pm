  package DBIx::Define::Type::Sentence;
# *************************************
  our $VERSION = '0.01';
# **********************
; use strict; use warnings
; use parent 'DBIx::Define::Type::Varchar'

; our $defaultsize = 254

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }

; 1

__END__

