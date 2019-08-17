unit module Crystallarium::MicroAccount;

use Crystallarium::DB;
use Cro::HTTP::Router;

sub login-routes() is export {
    route {
        get -> 'login' {content 'text/plain', "Lemme log ya in..!" }
        post -> 'create_account' {
            request-body -> (:$username!, :$password!) {
                
            }
        }
    }
}