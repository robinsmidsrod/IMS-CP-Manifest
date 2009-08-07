package IMS::Include::Attribute::XPathValue;
use Moose::Role;

has 'xpath_query' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has '+lazy' => (
    default => 1,
);

has '+default' => (
    default => sub {
        my ($attr) = @_;
        return sub {
            my ($self) = @_;
            unless ( $self->can('node') ) {
                confess(ref($self) . " has no method 'node'")
            }
            unless ( $self->can('xpc') ) {
                confess(ref($self) . " has no method 'xpc'");
            }
            my $value = $self->xpc->findvalue( $attr->xpath_query, $self->node );
            return defined($value) ? $value : "";
        };
    }
);

package Moose::Meta::Attribute::Custom::Trait::XPathValue;
sub register_implementation { 'IMS::Include::Attribute::XPathValue' }

1;
