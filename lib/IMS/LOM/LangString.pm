package IMS::LOM::LangString;
use Moose;

with 'IMS::Include::XMLNode',
     'IMS::Include::XPathContext';

has 'language' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_language {
    my ( $self ) = @_;
    my $language = $self->xpc->findvalue( './lom:langstring/@xml:lang', $self->node );
    return defined($language) ? $language : "";
}

has 'text' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_text {
    my ( $self ) = @_;
    my $text = $self->xpc->findvalue( './lom:langstring', $self->node );
    return defined($text) ? $text : "";
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
