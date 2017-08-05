  package DBIx::Define::Schema
# ****************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use Carp ()

; use HO::class
    init => 'hash',
    _ro => name   => '$',
    _ro => tables => '@',
    _ro => tblidx => '%'

; use overload
    '""' => sub { $_[0]->name },
    fallback => 1

; sub add_table
    { my ($self,$table) = @_
    ; my $name = $table->name

    ; unless($self->has_table($name))
        { my $order = push @{$self->[$self->_tables]},$table
        ; $self->[$self->_tblidx]->{$name} = $table
        ; $table->order($order) unless defined $table->order
        }
      else
        { my $schemaname = $self->name
        ; Carp::carp "Table '$name' already exists in schema '$schemaname'."
        }
    }

; sub has_table
    { my ($self,$tablename) = @_
    ; ref($tablename) && ($tablename = $tablename->name)
    ; exists $self->[$self->_tblidx]->{$tablename}
    }

; sub get_table
    { my ($self,$tablename) = @_
    ; $self->tblidx($tablename)
    }

; sub get_tables
    { sort { $a->order <=> $b->order } $_[0]->tables
    }

################################################################################

; sub objectify
    { my ($self) = @_
    ; foreach my $table ($self->get_tables)
        { foreach my $column ($table->get_columns)
            { foreach my $relationship ($column->get_relationships)
                { next if $relationship->objectified
                ; $relationship->objectify($self,$table)
                }
            }
        }
    }

################################################################################

; sub _build_schema
    { my ($self,$dbschema) = @_
    ; foreach my $dbtable ($dbschema->get_tables)
        { my $table = DBIx::Define->new_table(table => $dbtable->name)
        ; foreach my $dbcolumn ($dbtable->get_fields)
            { my $sub = 'text'
            ; my $type = DBIx::Define::Types->get_type_object($sub)
            ; my @args = ($dbcolumn->name,$type)
            ; my $col = DBIx::Define::Types->get_type_object('column',@args)
            ; $table->add_column($col)
            }
        ; $self->add_table($table)
        }

    }

; 1

__END__

