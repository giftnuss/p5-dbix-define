  package DBIx::Define::Type::Recordid;
# ************************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings
; use parent 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'int'
    ; $self->[$self->_is_nullable] = 0
    ; $self
    }

;1

__END__


