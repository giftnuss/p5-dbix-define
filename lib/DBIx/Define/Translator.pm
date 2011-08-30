  package DBIx::Define::Translator
# ********************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use Carp ()

; use base 'SQL::Translator'
; use SQL::Translator::Schema::Constants
; use SQL::Translator::Schema::Constraint

# load a D::D::Schema into SQL::Translator
; sub _use_schema
    { my ($self,$schema) = @_
    ; $schema->objectify

    ; my $to = $self->schema
    ; $to->name($schema->name)

    ; foreach my $table ($schema->get_tables)
        { my $tt = $to->add_table(name => $table->name)
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
        ; my @pk = map { $_->name } $table->pk
        ; my $pk = $tt->add_constraint(
            # name => 'primary_key',
             type => PRIMARY_KEY,
             fields => \@pk);
        }
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

; sub only_for_table
    { my ($self,$keep) = @_
    ; my $filter = sub
        { my $schema = shift
        ; foreach my $table ($schema->get_tables)
            { $schema->drop_table($table) unless
                $table->name eq $keep
            }
        }
    ; $self->filters($filter)
    ; $self->producer_args->{no_transaction} = 1
    ; return $self
    }

###############################################################################

; sub _load_schema
    { my ($self,$dbh) = @_
    ; my $one = $self->parser('DBI')
    ; $self->parser_args(dbh => $dbh)
    ; $self->parse
    }

; 1

__END__

=head1 NAME

DBIx::Define::Translator

=head1 SYNOPSIS

