package Repositories::PlayerRepository;

use strict;
use warnings;

use Models::Player;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless($self, $class);
    return $self;
}

sub findByUserId {
    my $self = shift;
    my $userId = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM players WHERE user_id = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $player = Models::Player->new($fields);

    return $player->$searchFor();
}

sub findByUsername {
    my $self = shift;
    my $username = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM players WHERE username = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($username) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $player = Models::Player->new($fields);

    return $player->$searchFor();
}

sub create {
    my $self = shift;    
    my $attributes = shift;

    my $player = Models::Player->new($attributes);

    return $player->save();
}

sub sortByWins {
    my $self = shift;
    
    my $sql = "SELECT username, wins, losses FROM (SELECT username, wins, losses FROM players WHERE wins != 0 OR losses != 0) AS dummy ORDER BY wins DESC, losses LIMIT 3 ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute();

    my $highscores = $sth->fetchall_arrayref();

    return $highscores;
}

sub count {
    my $self = shift;

    my $sql = "SELECT COUNT(*) as count FROM players WHERE wins != 0 OR losses != 0 ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute() or die $dbh->errstr;

    my $count = $sth->fetchrow_hashref();

    return $count;
}

sub getRank {
    my $self = shift;
    my $email = shift;

    my $sql = "SELECT ranking FROM (SELECT username, wins, losses, RANK() over (ORDER BY wins DESC, losses, id) AS ranking FROM players WHERE wins != 0 OR losses != 0) AS dummy WHERE username =  ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($email) or die $dbh->errstr;

    my $rankings = $sth->fetchrow_hashref();

    return $rankings;
}

1;