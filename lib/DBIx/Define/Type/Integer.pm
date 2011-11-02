  package DBIx::Define::Type::Integer;
# ***********************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings
; use parent 'DBIx::Define::Type'

; use HO::class
    _ro => size              => '$',
    _ro => is_auto_increment => '$',
    _ro => unsigned          => '$'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'int'
    ; $self->[$self->_unsigned] = defined($args{'unsigned'})
        ? $args{'unsigned'} : !1

    ; $self->[$self->_size] = defined($args{'size'}) ? $args{'size'} : 11

    ; $self->[$self->_is_auto_increment] = defined($args{'is_auto_increment'})
        ? $args{'is_auto_increment'} : 0
    ; $self->SUPER::init(%args)
    }

;1

__END__
