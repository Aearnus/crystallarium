unit module Crystallarium::DB;

use DBIish;

our $db = DBIish.connect('SQLite', :database<main.sqlite>);

sub create-account(Str $username, Str $password) is export {
    $db.prepare(q:to/STMT/).execute($username, $password)
        INSERT INTO users (name, password)
        VALUES ( ?, ? ) 
        STMT
}