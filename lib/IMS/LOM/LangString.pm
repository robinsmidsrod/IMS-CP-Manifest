package IMS::LOM::LangString;
use Moose;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::findvalue';

has 'language' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_language {
    my ( $self ) = @_;
    return $self->findvalue( './lom:langstring/@xml:lang' );
}

has 'text' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_text {
    my ( $self ) = @_;
    return $self->findvalue( './lom:langstring' );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
