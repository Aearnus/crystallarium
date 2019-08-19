use v6;
use DBIish;

class Build {
    method build($dist) {
        my $db = DBIish.connect('SQLite', :database<main.sqlite>);
        $db.do(q:to/STMT/);
            CREATE TABLE IF NOT EXISTS users (
                name varchar(32),
                password varchar(128)
            )
            STMT
    }
}