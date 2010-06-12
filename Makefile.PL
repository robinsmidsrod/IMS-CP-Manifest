use inc::Module::Install 0.99;

name            'IMS-CP-Manifest';
abstract        'IMS Content Packaging Manifest XML parser';
author          'Robin Smidsrød <robin@smidsrod.no>';
license         'perl';
all_from        'lib/IMS/CP/Manifest.pm';

requires        'Moose'         => '0.88';
requires        'XML::Rabbit'   => '0.0.1';

test_requires   'utf8'          => '1.06';
test_requires   'Test::More'    => '0.88';

WriteAll;
