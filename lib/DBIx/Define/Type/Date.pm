  package DBIx::Define::Type::Date;
# ********************************;
  our $VERSION = '0.01';
# **********************
; use strict; use warnings
; use base 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'date'
    ; $self->SUPER::init(%args)
    }

;1

__END__

