  package DBIx::Define::Table
; use strict; use warnings
# ***************************
; our $VERSION  ='0.02'
; our $AUTHORITY='cpan:SKNPP'
# ***************************
; use base 'DBIx::Define::Object'
; use DBIx::Define::Schema ()
; use DBIx::Define::Key ()

; use HO::class
    init => 'hash',
    _rw => order        => '$',
    _rw => name         => '$',    # the table name
    _rw => description  => '$',    # describe purpose of the table
    _rw => columns      => '@',    # database columns
    _ro => _colidx      => '%',
    _rw => pk           => '@',    # primary keys
    _rw => keys         => '@'     # column index

; use overload
    '""' => sub { $_[0]->name },
    fallback => 1

; sub add_column
    { my ($self,$column)=@_
    ; $self->columns('<',$column)
    ; $self->[&__colidx]->{$column->name} = $column
    ; $column->order(scalar($self->columns)) unless defined $column->order
    ; $self
    }

; sub get_column
    { my ($self,$name) = @_
    ; return $self->[&__colidx]->{$name}
    }

; sub get_columns
    { sort { $a->order <=> $b->order } $_[0]->columns
    }

; sub get_column_names
    { map { $_->name } shift->get_columns
    }

; sub list_columns
    { my ($self)=@_
    ; if(wantarray)
        { return $self->columns
        }
      else
        { my $idx = 0
        ; return sub
            { return $self->columns($idx++)
            }
        }
    }

; sub add_to_primary_key
    { my ($self,$pk) = @_
    ; $self->pk('<',$pk)
    ; $self
    }

; sub add_unique_key
    { my ($self,@args) = @_
    ; my $key = DBIx::Define::Key->new(is_unique => 1,@args)
    ; $self->keys('<',$key) 
    ; $self
    }

# from zend
# - columnname:
#     * SCHEMA_NAME => string; name of database or schema
#     * TABLE_NAME  => string;
#     * COLUMN_NAME => string; column name
#     * COLUMN_POSITION => number; ordinal position of column in table
#     * DATA_TYPE   => string; SQL datatype name of column
#     * DEFAULT     => string; default expression of column, null if none
#     * NULLABLE    => boolean; true if column can have nulls
#     * LENGTH      => number; length of CHAR/VARCHAR
#     * SCALE       => number; scale of NUMERIC/DECIMAL
#     * PRECISION   => number; precision of NUMERIC/DECIMAL
#     * UNSIGNED    => boolean; unsigned property of an integer type
#     * PRIMARY     => boolean; true if column is part of the primary key
#     * PRIMARY_POSITION => integer; position of column in primary key
; sub describe
    {
    }

; 1

__END__



=head2 Methods

=over 4

=item add_column

Takes three arguments, the name of the column, the type object and
an optional hashref with additional arguments for the producer.

=item set_primary_keys



