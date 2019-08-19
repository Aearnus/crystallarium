unit module Crystallarium::DB;

use DBIish;
use Crypt::Argon2;

our $db = DBIish.connect('SQLite', :database<main.sqlite>);

my sub log-db(Str $str) {
    "CRYSTALLARIUM DB ACTION: $str".say;
}

sub create-account(Str $username, Str $password) is export {
    my $hashed-password = argon2-hash($password, :hashlen(64));
    log-db("Creating account $username with hash $hashed-password");
    $db.prepare(q:to/STMT/).execute($username, $hashed-password)
        INSERT INTO users (name, password)
        VALUES ( ?, ? ) 
        STMT
}