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
        my ($attr_self) = @_;
        return sub {
            my ($self) = @_;
            $self->findvalue( $attr_self->xpath_query );
        };
    }
);

package Moose::Meta::Attribute::Custom::Trait::XPathValue;
sub register_implementation { 'IMS::Include::Attribute::XPathValue' }

1;
