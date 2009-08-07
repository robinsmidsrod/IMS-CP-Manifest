package IMS::Include::find;
use Moose::Role;

requires 'xpc','node';

sub find {
    my ( $self, $query, $class ) = @_;
    my $node = $self->xpc->find( $query, $self->node )->shift();
    return $node unless defined($class);

    Class::MOP::load_class($class);
    my $instance = $class->new( xpc => $self->xpc, node => $node );
    return $instance;    
}

1;
