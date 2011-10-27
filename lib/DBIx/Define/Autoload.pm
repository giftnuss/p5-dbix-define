  package DBIx::Define::Autoload
# ******************************
; our $VERSION='0.01'
# *******************

; use DBIx::Define::Types
# this is a placeholder for a more specialized and flexible
# solution.

; our $AUTOLOAD

; sub AUTOLOAD
    { my $sub = $AUTOLOAD
    ; $sub =~ s/.*:://
    ; return if $sub eq 'DESTROY';#'end'

    ; unshift(@_ => 'name') if @_%2
    ; my $type = DBIx::Define::Types->get_type_object($sub,@_)

    ; my $objects = 
        { 'column' => sub
            { DBIx::Define->current_table->add_column($type)
            ; return
            }
        , 'table' => sub
	    { DBIx::Define->set_current_table($type)
            ; return
            }
        , 'schema' => sub
	    { DBIx::Define->set_current_schema($type)
            }
        }
    ; $objects->{$sub}->() if ref($objects->{$sub}) eq 'CODE'
    ; return $type
    }

; 1

__END__


