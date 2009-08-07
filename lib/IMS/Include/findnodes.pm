package IMS::Include::findnodes;
use Moose::Role;

requires 'xpc','node';

sub findnodes {
    my ($self, $query, $class ) = @_;
    Class::MOP::load_class($class) if defined($class);
    my @nodes;
    foreach my $node ( $self->xpc->findnodes( $query, $self->node ) ) {
        my $instance = $class ? $class->new( node => $node, xpc => $self->xpc ) : $node;
        push @nodes, $instance;
    }
    return \@nodes;
}

1;
