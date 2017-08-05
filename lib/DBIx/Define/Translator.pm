  package DBIx::Define::Translator
# ********************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use Carp ()

; use parent 'SQL::Translator'
; use SQL::Translator::Schema::Constants
; use SQL::Translator::Schema::Constraint
; use SQL::Translator::Schema::Index
; use DBIx::Define::Table::DDL

# load a D::D::Schema into SQL::Translator
; sub _use_schema
    { my ($self,$schema,$tablename) = @_
    ; $schema->objectify

    ; my $to = $self->schema
    ; $to->name($schema->name)

    ; foreach my $table ($schema->get_tables)
        { if(defined $tablename)
            { next unless $tablename eq $table->name
            }
        ; my $tt = $to->add_table(name => $table->name)
        ; foreach my $column ($table->get_columns)
            { my $tc = $tt->add_field
                ( name => $column->name
                , data_type => $column->type->data_type
                )
            ; $tc->default_value($column->type->default)
                if $column->type->has_default
            ; $tc->is_nullable($column->type->is_nullable)
            ; $tc->size($column->type->size)
                if $column->type->can('size')

            ; if($column->is_fk)
        { $self->_transform_fk($tt,$column)
                }

            ; my @comments = $column->comments
            ; $tc->comments(@comments) if @comments
            }

        ; $self->_convert_keys($table => $tt)
        ; $self->_convert_pk($table => $tt)
        }
    }

; sub _convert_keys
    { my ($self, $dd_table, $st_table) = @_
    ; foreach my $key ($dd_table->keys)
        { my $type = $key->is_unique ? 'unique' : 'normal'
        ; my $idx = $st_table->add_index(
            name => $key->get_name,
            fields => [ $key->get_column_names ],
            type => $type)
        }
    }

; sub _convert_pk
    { my ($self, $dd_table, $st_table) = @_
    ; my @pk = map { $_->name } $dd_table->pk
    ; $st_table->add_constraint( type => PRIMARY_KEY, fields => \@pk)
    }

; sub _transform_fk
    { my ($self,$tt,$column) = @_
    ; my @constraints
    ; my @fk = grep {$_->is_fk} $column->get_relationships

    ; foreach my $rs (@fk)
        { $tt->add_constraint
             ( name => $rs->name
             , type => FOREIGN_KEY
             , fields => $column->name
             , reference_table => $rs->entities(1)->[0]->name
             , reference_fields => $rs->entities(1)->[1]->name
             , match_type => 'full'
             )
            or die($tt->error)
        }
    }

###############################################################################

; sub _load_schema
    { my ($self,$dbh,$schemaname) = @_
    ; my $one = $self->parser('DBI')
    ; $self->parser_args(dbh => $dbh)
    ; $self->parse
    ; return  $self->schema
    }

; 1

__END__

=head1 NAME

DBIx::Define::Translator

=head1 SYNOPSIS

