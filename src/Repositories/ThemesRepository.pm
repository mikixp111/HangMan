package Repositories::ThemesRepository;

use strict;
use warnings;

use Models::Themes;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless($self, $class);
    return $self;
}

sub findById {
    my $self = shift;
    my $id = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM themes WHERE id = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($id) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $themes = Models::Themes->new($fields);

    return $themes->$searchFor();
}

sub findByName {
    my $self = shift;
    my $name = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM themes WHERE name = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($name) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $themes = Models::Themes->new($fields);

    return $themes->$searchFor();
}

sub selectThemes {
    my $self = shift;

    my $sql = "SELECT name FROM themes ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute() or die $dbh->errstr;

    my $themes = $sth->fetchall_arrayref(0);

    return $themes;
}

# sub create {
#     my $self = shift;    
#     my $attributes = shift;

#     my $themes = Models::Themes->new($attributes);

#     return $themes->save();
# }

1;