  package DBIx::Define::Types;
# ***************************;
  our $VERSION = '0.02';
# *********************;
; use strict; use warnings; use utf8

; use DBIx::Define::Schema ()
; use DBIx::Define::Table  ()
; use DBIx::Define::Column ()
; use DBIx::Define::Key    ()

; use DBIx::Define::Type::Recordid ()
; use DBIx::Define::Type::Integer  ()
; use DBIx::Define::Type::Smallint ()
; use DBIx::Define::Type::Bigint   ()

; use DBIx::Define::Type::Number  ()
; use DBIx::Define::Type::Double  ()
; use DBIx::Define::Type::Decimal ()
; use DBIx::Define::Type::Money   ()

; use DBIx::Define::Type::Char       ()
; use DBIx::Define::Type::Varchar    ()
; use DBIx::Define::Type::Identifier ()
; use DBIx::Define::Type::Sentence   ()
; use DBIx::Define::Type::Text       ()
; use DBIx::Define::Type::Word       ()

; use DBIx::Define::Type::Date     ()
; use DBIx::Define::Type::Time     ()
; use DBIx::Define::Type::Datetime ()

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
    , word       => 'DBIx::Define::Type::Word'

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
    ; $CONSTR{$type} = $class
    }

; 1

__END__

