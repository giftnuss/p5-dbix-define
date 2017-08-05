  package DBIx::Define::Type
# **************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use subs qw/init/;

; use HO::class
    _ro => 'data_type'   => '$',  # string representation of the SQL data type
    _rw => 'is_nullable' => '$',
    _rw => 'default'     => '$'   # mal sehn obs passt

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; return $self
    }

; sub has_default
    { defined $_[0]->default 
    }

; 1

__END__


