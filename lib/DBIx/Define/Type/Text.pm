  package DBIx::Define::Type::Text;
# *********************************
  our $VERSION = '0.01';
# **********************
; use strict; use warnings
; use base 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'text'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self
    }
    
; 1

__END__

