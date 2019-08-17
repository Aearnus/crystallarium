#!/usr/bin/env perl6

use DBIish;

# set up the DB as if it was the first time
my $db = DBIish.connect('SQLite', :database<main.sqlite>);
$db.do(q:to/STMT/);
    CREATE TABLE users (
        name varchar(32),
        password varchar(32)
    )
    STMT
