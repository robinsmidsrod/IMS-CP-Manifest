package IMS::Include::findvalue;
use Moose::Role;

requires 'xpc', 'node';

sub findvalue {
    my ($self, $query) = @_;
    my $value = $self->xpc->findvalue( $query, $self->node );
    return defined($value) ? $value : "";
}

1;
