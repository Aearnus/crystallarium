#!/usr/bin/env perl6

unit module Crystallarium;

use Crystallarium::DB;
use Crystallarium::MicroAccount;
use Cro::HTTP::Router;
use Cro::HTTP::Server;

my $application = route {
    include login-routes;
    get -> 'greet', $name {
        content 'text/plain', "Hello, $name!";
    }
}
my Cro::Service $hello = Cro::HTTP::Server.new:
    :host<localhost>, :port<10000>, :$application;
$hello.start;
react whenever signal(SIGINT) { $hello.stop; exit; }