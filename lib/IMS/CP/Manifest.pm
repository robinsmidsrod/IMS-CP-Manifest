package IMS::CP::Manifest;
use Moose;
extends 'Rabbit::RootNode';

use 5.008; # According to Perl::MinimumVersion
our $VERSION = '0.01';

### Namespace mapping (xmlns)

has 'namespace_map' => (
    is         => 'ro',
    isa        => 'HashRef[Str]',
    lazy_build => 1,
);

sub _build_namespace_map {
    return {
        'cp'  => 'http://www.imsglobal.org/xsd/imscp_v1p1',
        'lom' => 'http://www.imsglobal.org/xsd/imsmd_v1p2',
    };
}

### Attributes

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'organizations' => (
    is          => 'ro',
    isa         => 'ArrayRef[IMS::CP::Organization]',
    traits      => [qw/XPathObjectList/],
    xpath_query => '/cp:manifest/cp:organizations/*',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
