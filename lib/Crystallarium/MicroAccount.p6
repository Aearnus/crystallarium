unit module Crystallarium::MicroAccount;

use Crystallarium::DB;
use Cro::HTTP::Router;

class LoginToken {
    has Instant $.expires = now + 3600;
    has Str $.secret = (|('A'..'Z') , |('a'..'z')).roll(32).join;

    method expired { now > $!expires }
    method refresh(Int $time-till-expiry) { $!expires = now + $time-till-expiry }
}

class LoginTokener {
    has LoginToken @.tokens;

    method new-token(--> LoginToken) {
        my $tok = LoginToken.new;
        @!tokens.push: $tok; 
        $tok
    }

    method snub { @!tokens .= grep(!*.expired) }

    method validate(Str $secret --> Bool) { $secret ~~ (@!tokens.map(*.secret).any) }
}

sub login-routes() is export {
    route {
        get -> 'login' {content 'text/plain', "Lemme log ya in..!" }
        post -> 'create_account' {
            request-body -> (:$username!, :$password!) {
                create-account($username, $password)
            }
        }
    }
}

my sub create