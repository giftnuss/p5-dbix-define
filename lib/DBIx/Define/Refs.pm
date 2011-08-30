  package DBIx::Define::Refs
# **************************
; our $VERSION = '0.01'
# *********************
; use strict; use warnings; use utf8

; use DBIx::Define::Relationship

; sub init
    { my ($self,$entity) = @_
    ; $self->[&_entity] = $entity
    ; return $self
    }

; use HO::class
    _ro => entity => '$',
    _rw => relationships => '@'

; sub foreign_key
    { my ($self,$table,$column) = @_
    ; my $rs = new DBIx::Define::Relationship::
    ; $rs->[$rs->_is_fk] = 1
    ; $rs->entities(0)->[1] = $self->entity
    ; $rs->entities(1)->[0] = $table
    ; $rs->entities(1)->[1] = $column

    ; $self->relationships('<',$rs)
    ; $self
    }

; sub has_many
    {
    }

; 1

__END__

=head1 NAME

DBIx::Define::Refs

=head1 SYNOPSIS

=head1 DESCRIPTION

Manager object for relationships.
