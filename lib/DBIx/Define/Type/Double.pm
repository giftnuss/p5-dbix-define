  package DBIx::Define::Type::Double;
# **********************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings

; use parent 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->SUPER::init(%args)
    ; $self->[$self->_data_type] = 'double'
    ; return $self
    }

;1

__END__

