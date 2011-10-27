  package DBIx::Define::Type::Bigint;
# **********************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings
; use parent 'DBIx::Define::Type::Integer'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'bigint'
    ; $self->SUPER::init(%args)
    }

;1

__END__

