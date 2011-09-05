  package DBIx::Define::Key;
# **************************
  our $VERSION = '0.01';
# **********************

; use HO::class
    init => 'hash',
    _ro => name => '$',
    _rw => columns => '@',
    _ro => is_unique => '$'

; sub get_name
    { my ($self) = @_
    ; return $self->name if (length $self->name)
    ; my @parts = map { $_->name } $self->columns
    ; $self->[_name] = join "_", (@parts,'idx')
    ; $self->name        
    }

; sub get_column_names
    { my ($self) = @_
    ; map { $_->name } $self->columns 
    }

; 1

__END__

=head1 NAME

DBIx::Define::Key - class representing indices

=head1 DESCRIPTION

=head2 Constructors

=over 4

=item new

Normal auto generated constructor.

=back

=head2 Properties

=over 4

=item name - ro scalar

=item columns - rw array

=item is_unique - ro scalar

=back

=head2 Methods

=over 4

=item get_name

Returns the name property or generate one from column names.

=back

