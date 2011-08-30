  package DBIx::Define::Column
# *****************************
; our $VERSION='0.03'
; our $AUTHORITY='cpan:SKNPP'
# ***************************
; use strict; use warnings; use utf8

; use DBIx::Define::Refs

; use subs 'init'

; use HO::class
   _rw => order    => '$',
   _ro => name     => '$',
   _ro => type     => '$',
   _rw => comments => '@',
   _ro => refs     => '$'

; use overload
    '""' => sub { $_[0]->name },
    fallback => 1

; sub init
    { my ($self,$name,$type,%args) = @_
    ; $self->[$self->_name] = $name
    ; $self->[$self->_type] = $type
    ; while(my ($key,$val) = each(%args))
        { $self->$key($val)
        }
    ; $self
    }

; sub pk
    { my ($self) = @_
    ; DBIx::Define->current_table->add_primary_key($self)
    ; $self
    }
	
; sub fk
    { my ($self,$table,$column) = @_
    ; $self->[&_refs] = new DBIx::Define::Refs:: ($self) unless $self->refs
	; $self->refs->foreign_key($table,$column)
	; return $self
	}
	
; sub is_fk
    { my ($self) = @_
	; return 0 + grep {$_->is_fk} $self->get_relationships
	}

; sub comment
    { my ($self,$comment) = @_
    ; $self->comments("<",$comment)
    ; $self
    }

; sub get_relationships
    { my ($self) = @_
    ; return unless $self->refs
    ; return $self->refs->relationships
    }

; 1

__END__

=head1 NAME

DBIx::Define::Column

=head1 SYNOPSIS

=head1 DESCRIPTION

