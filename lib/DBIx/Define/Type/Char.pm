  package DBIx::Define::Type::Char;
# *********************************
  our $VERSION = '0.01';
# **********************
; use strict; use warnings
; use parent 'DBIx::Define::Type'

; use HO::class
    _ro => size => '$'

; our $defaultsize = 120

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'char'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->[$self->_size] = defined($args{'size'})
        ? $args{'size'} : $defaultsize
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self    
    }

; 1

__END__

