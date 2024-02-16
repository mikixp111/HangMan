package Models::Themes;

use strict;
use warnings;

# use DataBase;
use Data::Dumper;

sub new {
    my $class = shift;
    my $attributes = shift || {};

    my $self = {
        attributes => $attributes,
        columns => [
            'id',
            'name',
            'price'
        ],
    };
    bless($self, $class);

    return $self;
}

sub getId {
    my $self = shift;

    return $self->{attributes}->{id};
}

sub getName {
    my $self = shift;

    return $self->{attributes}->{name};
}

sub getPrice {
    my $self = shift;

    return $self->{attributes}->{price};
}

sub save {
    my $self = shift;

    my %columns = map {
        $_ => 1
    } @{$self->{columns}};
    my $attributes = $self->{attributes};

    my @saveData;
    my @dataType;


    foreach my $key (keys %$attributes) {
        my $value = $attributes->{$key};
        unless ($columns{$key}) {
            next;
        }
        push(@saveData, $value);
        push(@dataType, $key);
    }

    my @insertData = join ', ', @dataType;

    my @duplicateData = map {$_ . ' = ?'} @dataType;
    @duplicateData = join ', ', @duplicateData;

    my $dataCount = @saveData;

    my $placeholder = join ', ', ('?') x $dataCount;

    my $sql = (
        "INSERT INTO themes (@insertData)
        VALUES ($placeholder) 
        ON DUPLICATE KEY UPDATE @duplicateData;"
    );

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute(@saveData, @saveData) or die $dbh->errstr;

    return;
}

1;