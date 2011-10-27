  package DBIx::Define::Types;
# ***************************;
  our $VERSION = '0.01';
# *********************;
; use strict; use warnings; use utf8
; use Class::Load ()

; our %CONSTR

; my %default_types =
   ( schema     => 'DBIx::Define::Schema'
    , table      => 'DBIx::Define::Table'
    , column     => 'DBIx::Define::Column'
    , key        => 'DBIx::Define::Key'

    , recordid   => 'DBIx::Define::Type::Recordid'
    , integer    => 'DBIx::Define::Type::Integer'
    , smallint   => 'DBIx::Define::Type::Smallint'
    , bigint     => 'DBIx::Define::Type::Bigint'

    , number     => 'DBIx::Define::Type::Number'
    , double     => 'DBIx::Define::Type::Double'
    , decimal    => 'DBIx::Define::Type::Decimal'
    , money      => 'DBIx::Define::Type::Money'

    , char       => 'DBIx::Define::Type::Char'
    , varchar    => 'DBIx::Define::Type::Varchar'
    , identifier => 'DBIx::Define::Type::Identifier'
    , sentence   => 'DBIx::Define::Type::Sentence'
    , text       => 'DBIx::Define::Type::Text'
    , word     => 'DBIx::Define::Type::Word'

    , date     => 'DBIx::Define::Type::Date'
    , time     => 'DBIx::Define::Type::Time'
    , datetime => 'DBIx::Define::Type::Datetime'
    )


; while(my ($name,$class) = each %default_types)
    { __PACKAGE__->register_type($name,$class) }


# diagnostics?
; sub get_type_object
    { my ($pack,$type,%args)=@_
    ; (my $class = $CONSTR{$type}) or
      Carp::croak("Datatype '$type' is not registered. "
                 ."Use set_type_class to register one.")
    ; return $class->new(%args)
    }

; sub register_type
    { my ($self,$type,$class) = @_
    ; Class::Load::load_class($class)
    ; $CONSTR{$type} = $class
    }

; 1

__END__

