  package DBIx::Define::Type
# **************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use subs 'init' # makes this class abstract

; use HO::class
    _ro => 'data_type'   => '$',  # string representation of the SQL data type
    _ro => 'is_nullable' => '$',
    _rw => 'default'     => '$'   # mal sehn obs passt

; our %CONSTR =
    ( schema     => 'DBIx::Define::Schema'
    , table      => 'DBIx::Define::Table'
    , column     => 'DBIx::Define::Column'
    , key        => 'DBIx::Define::Key'

    , recordid   => 'DBIx::Define::Type::Recordid'
    , integer    => 'DBIx::Define::Type::Integer'
    , smallint   => 'DBIx::Define::Type::Smallint'
    , number     => 'DBIx::Define::Type::Number'
    , char       => 'DBIx::Define::Type::Char'
    , varchar    => 'DBIx::Define::Type::Varchar'
    , identifier => 'DBIx::Define::Type::Identifier'
    , sentence   => 'DBIx::Define::Type::Sentence'
    , text       => 'DBIx::Define::Type::Text'
    , word     => 'DBIx::Define::Type::Word'
    , date     => 'DBIx::Define::Type::Date'
    , time     => 'DBIx::Define::Type::Time'
    )

# diagnostics?
; sub get_type_object
    { my ($pack,$type,%args)=@_
    ; (my $class = $CONSTR{$type}) or
      Carp::croak("Datatype '$type' is not registered. "
                 ."Use set_type_class to register one.")
    ; return $class->new(%args)
    }

; sub set_type_class
    { my ($self,$type,$class) = @_
    ; $CONSTR{$type} = $class
    }

; sub has_default
    { defined $_[0]->default 
    }

############################################

; package DBIx::Define::Type::Recordid
; use base 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'int'
    ; $self->[$self->_is_nullable] = 0
    ; $self
    }

############################################

; package DBIx::Define::Type::Integer
; use base 'DBIx::Define::Type'

; use HO::class
    _ro => size              => '$',
    _ro => is_auto_increment => '$',
    _ro => unsigned          => '$'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'int'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->[$self->_unsigned] = defined($args{'unsigned'})
        ? $args{'unsigned'} : !1
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self->[$self->_size] = defined($args{'size'})
        ? $args{'size'} : 11
    ; $self->[$self->_is_auto_increment] = defined($args{'is_auto_increment'})
        ? $args{'is_auto_increment'} : 0
    ; $self
    }

; package DBIx::Define::Type::Smallint
; use base 'DBIx::Define::Type::Integer'



############################################

; package DBIx::Define::Type::Date
; use base 'DBIx::Define::Type'

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'date'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self
    }

############################################

; package DBIx::Define::Type::Varchar
; use base 'DBIx::Define::Type'

; use HO::class
    _ro => size => '$'

; our $defaultsize = 120

; sub init
    { my ($self,%args) = @_
    ; $self->[$self->_data_type] = 'varchar'
    ; $self->[$self->_is_nullable] = defined($args{'is_nullable'})
        ? $args{'is_nullable'} : 1
    ; $self->[$self->_size] = defined($args{'size'})
        ? $args{'size'} : $defaultsize
    ; $self->default($args{'default'}) if defined($args{'default'})
    ; $self
    }


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


