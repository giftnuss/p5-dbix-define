  package DBIx::Define::Relationship
# **********************************
; our $VERSION = '0.01';
# **********************
; use strict; use warnings; use utf8

; sub init
    { my ($self) = @_
    ; $self->entities(0,[])
    ; $self->entities(1,[])
    ; $self->[&_is_fk] = 0
    ; $self->[&_has_many] = 0
    ; return $self
    }

; use HO::class
    _rw => name => '$',
    _rw => entities => '@',
    _ro => objectified => '$',
    _ro => is_fk => '$',
    _ro => has_many => '$'

; sub objectify
    { my ($self,$schema,$table) = @_
    ; if($self->is_fk)
        { $self->entities(0)->[0] = $table
        ; my ($reftable)
        ; unless(ref $self->entities(1)->[0])
            { $reftable =  $schema->get_table($self->entities(1)->[0])
            ; $self->entities(1)->[0] = $reftable
            }
          else
            { $reftable = $self->entities(1)->[0]
            }
        ; unless(ref $self->entities(1)->[1])
            { if(defined $self->entities(1)->[1])
                { my $colname = $self->entities(1)->[1]
                ; my $refcol = $reftable->get_column($colname)
                ; ($self->entities(1)->[1] = $refcol) or
                    Carp::croak("Referenced column '$colname' not found in table " . $reftable->name . ".")
                }
              else
                { ($self->entities(1)->[1] = [$reftable->pk]->[0]) or
                    Carp::croak("No primary key found in referenced table " . $reftable->name . ".")
                }
            }
        }
    ; $self->[&_objectified] = 1
    ; $self
    }

; 1

__END__

=head1 NAME

DBIx::Define::Relationship

=head1 SYNOPSIS

