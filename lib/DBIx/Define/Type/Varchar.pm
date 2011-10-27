  package DBIx::Define::Type::Varchar;
# ***********************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings
; use base 'DBIx::Define::Type'

; use HO::class
    _ro => size => '$'

; our $defaultsize = 120

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'varchar'
    ; $self->[$self->_size] = defined($args{'size'})
        ? $args{'size'} : $defaultsize
    ; $self->SUPER::init(%args)
    }

;1

__END__
