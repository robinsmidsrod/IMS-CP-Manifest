package IMS::CP::Resource;
use Moose;

use Encode ();

use IMS::CP::Resource::File;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::findvalue';
with 'IMS::Include::find';
with 'IMS::Include::findnodes';

use IMS::Include::Attribute::XPathValue;

has 'href' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

sub found {
    my ($self) = @_;
    my $filename = Encode::encode_utf8( $self->href );
    return -r $filename; 
}

has 'title' => (
    is         => 'ro',
    isa        => 'IMS::LOM::LangString',
    lazy_build => 1,
);

sub _build_title {
    my ( $self ) = @_;
    return $self->find(
        './cp:metadata/lom:lom/lom:general/lom:title',
        'IMS::LOM::LangString'
    );
}

has 'files' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Resource::File]',
    lazy_build => 1,
);

sub _build_files {
    my ($self) = @_;
    return $self->findnodes(
        './cp:file',
        'IMS::CP::Resource::File',
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
