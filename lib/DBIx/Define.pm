  package DBIx::Define
; use strict; use warnings
# **********************
; our $VERSION='0.02'
; our $AUTHORITY='SKNPP'
# **********************
; use Carp ()
############################################################
; use Package::Subroutine
############################################################
; use DBIx::Define::Autoload
; use DBIx::Define::Column
; use DBIx::Define::Relationship
; use DBIx::Define::Schema
; use DBIx::Define::Table
; use DBIx::Define::Type
############################################################
# Import
# subclass should import it or rewrite it.
; sub import
    { my ($pack,%args) = @_
    ; my $caller = caller

    ; $pack->_package_to_table($caller,%args)
    ; export Package::Subroutine::
        (( $args{'provide_autoload'} || 'DBIx::Define::Autoload')
            => qw/AUTOLOAD/
        )
    }

; sub _package_to_table
    { my ($pack,$caller,%args) = @_

    ; $args{'schema'} = $pack->_pkg2schema($caller)
        unless exists $args{'schema'}

    ; $pack->set_current_schema($pack->register_schema(%args))
        if defined $args{'schema'}

    ; $args{'table'} = $pack->_pkg2table($caller)
        unless exists $args{'table'}

    ; $pack->set_current_table($pack->register_table(%args))
        if defined $args{'table'}

    ; my $base = $args{'provide_base'} || 'DBIx::Define::Table';
    ; eval "push \@${caller}::ISA, '${base}'"
        unless $caller->isa($base)
    }

; sub table
    { my ($pack,%args) = @_
    ; my $caller = caller

    ; $pack->_package_to_table($caller,%args)
    ; export Package::Subroutine::
        (( $args{'provide_autoload'} || 'DBIx::Define::Autoload')
            => qw/AUTOLOAD/
        )
    }

; my %schema
; my $currentschema # default schema for Operations

; sub register_schema
    { my ($self,%args) = @_
    ; $args{'schema'} = 'default' unless $args{'schema'}

    ; return $schema{$args{'schema'}} if $schema{$args{'schema'}}
    ; return $schema{$args{'schema'}} = $self->new_schema(%args)
    }

; sub new_schema
    { my ($self,%args) = @_
    ; my $class = $args{'schema_class'} || 'DBIx::Define::Schema'
    ; my %setup = ('name' => $args{'schema'})
    ; return $class->new(%setup)
    }

; sub set_current_schema
    { my ($self,$schema) = @_
    ; $schema{$schema->name} = $schema
        unless exists $schema{$schema->name}
    ; $currentschema = $schema
    }

; sub current_schema
    { $currentschema
    }

; sub get_schema
    { $schema{$_[1]} or Carp::croak "No such schema '${_[1]}'."
    }

############################################################
# Tables
; my $currenttable
; sub register_table
    { my ($self,%args) = @_
    ; my $name = $args{'table'} or
         Carp::croak "Argument 'table' is required."
    ; my $schema = $self->current_schema
    ; if($schema->has_table($name))
        { return $schema->get_table($name)
        }

    ; my $table = $self->new_table(%args)
    ; $schema->add_table($table)
    ; return $table
    }

; sub set_current_table
    { my ($self,$table) = @_
    ; my $schema = $self->current_schema
    ; $schema->add_table($table) 
        unless $schema->has_table($table->name)
    ; $currenttable = $table
    }

; sub new_table
    { my ($self,%args) = @_
    ; my $class = $args{'table_class'} || 'DBIx::Define::Table'
    ; my %setup = ('name' => $args{'table'})
    ; return $class->new(%setup)
    }

; sub current_table
    { $currenttable
    }

################################################################################
# Translator Object
; sub translate
    { my ($self,$schema) = @_
    ; $schema = $self->get_schema($schema)
        unless ref($schema) && $schema->isa('DBIx::Define::Schema')

    ; require DBIx::Define::Translator
    ; my $translator = new DBIx::Define::Translator::

    ; $translator->_use_schema($schema)

    ; $translator
    }

; sub load_schema
    { my ($self,$dbh) = @_
    ; require DBIx::Define::Translator
    ; my $translator = new DBIx::Define::Translator::

    ; $translator->_load_schema($dbh)
; use Data::Dumper
; print Dumper($translator)
    }

################################################################################
# Retrieves a sorted list of all used schema names
; sub list_schema_names
    { sort keys %schema
    }

# Retrieves a table object by name
; sub get_table
    { my ($self,%args)=@_
    ; my $schema = $args{'schema'} || $currentschema->name()

    # get table by class name
    ; if( $args{'class'} )
        { #return $tblstore{$schema}->{$args{'class'}}
        }

    ; return undef unless defined (my $table=$args{'name'})

    ; return $schema{$schema}->get_table($table)
    }

#############################################################
# simple protected utility functions
#############################################################
# das wird sicher auch gebraucht
; sub _pkg2schema
    { shift
    ; my @sl = split /::|'/, $_[0]
    ; pop @sl
    ; @sl > 0 ? lc($sl[$#sl]) : 'default'
    }

# das ist nur damit eine etwas sinnvolle Vorbelegung existiert.
; sub _pkg2table
    { shift
    ; my @sl = split /::|'/, $_[0]
    ; pop @sl
    }

# should be improved
; use Data::Dumper ()
; sub dumper
    { my ($self,%args) = @_
    ; print Data::Dumper::Dumper(\%schema)
    }

; 1

__END__

=head1 NAME

DBIx::Define

=head1 SYNOPSIS


=head1 DESCRIPTION

=head2 import

This module should be used with it's import routine. It recognizes some
named parameter.

=over 4

=item provide_column => 'package'

The given package should provide a column function, which is exported
instead of the function from DBIx::Define. The given class needs to be 
loaded manualy before the import call.

=item provide_tblindex

=item schema => 'name'

Start with this schema. The name 'default' is special. It means the
default schema for a given dbms. If this parameter is not given the
second lastpart of the current package is used to determine the
schema name. If a simple dot '.' is used as name, means no schema will
be used at this time. You have to define the schema later with the
schema function.

=back

