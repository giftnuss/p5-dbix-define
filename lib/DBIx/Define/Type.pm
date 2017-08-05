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

############################################

############################################

############################################

############################################


############################################

; package DBIx::Define::Type::Char
; use base 'DBIx::Define::Type'

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

############################################

; package DBIx::Define::Type::Identifier
; use base 'DBIx::Define::Type::Varchar'

; our $defaultsize = 64

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }

; package DBIx::Define::Type::Word
; use base 'DBIx::Define::Type::Varchar'

; our $defaultsize = 32

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }

############################################

; package DBIx::Define::Type::Sentence
; use base 'DBIx::Define::Type::Varchar'

; our $defaultsize = 254

; sub init
    { my ($self,%args) = @_
    ; $args{'size'} = $defaultsize unless defined $args{'size'}
    ; $self->SUPER::init(%args)
    }


############################################

; package DBIx::Define::Type::Text
; use base 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'text'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self
    }

############################################

; 1

__END__


