  package DBIx::Define::Type::Bigint;
# **********************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings
; use parent 'DBIx::Define::Type::Integer'

; sub init
    { my ($self,%args) = @_
    ; $self->SUPER::init(%args)
    ; $self->[$self->_data_type] = 'bigint'
    ; $self->[$self->_size] = defined($args{'size'}) ? $args{'size'} : undef
    ; return $self
    }

;1

__END__

