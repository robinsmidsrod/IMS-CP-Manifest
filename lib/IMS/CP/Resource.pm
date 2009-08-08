package IMS::CP::Resource;
use Moose;

use Encode ();

use IMS::CP::Resource::File;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';

use IMS::Include::Attribute::XPathValue;
use IMS::Include::Attribute::XPathObject;
use IMS::Include::Attribute::XPathObjectList;

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
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'files' => (
    is          => 'ro',
    isa         => 'ArrayRef[IMS::CP::Resource::File]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:file',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
