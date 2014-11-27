use Test::More;
use Test::Fatal;

use_ok 'Cafepress::Api';

like exception { Cafepress::Api->new },
  qr/Attribute \(key\) is required at constructor/,
  'Require key in constructor';

my $api = Cafepress::Api->new( key => '123' );
ok exception { $api->call() },
  'api->call should die when called without method';

done_testing;
