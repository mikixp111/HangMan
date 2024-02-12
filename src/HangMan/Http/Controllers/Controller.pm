package Hangman::Http::Controllers::Controller;

use strict;
use warnings;

use Foundation::Appify;
use Data::Dumper;
use Repositories::PlayerRepository;
use HTML::Template;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub welcome {
    my $self = shift;
    my $request = shift;

    my $leaderboard = $request->{leaderboard};

    &$leaderboard();

    # my $hatsRepository = Repositories::HatsRepository->new();
    # my $allHats = $hatsRepository->selectHats();
    # my $hatId = @$allHats[3]->[0];
    # my $paramtest = 4;
    
    
    # foreach my $hat (@$allHats) {
    #     if (@$hat[0] eq $paramtest) {
    #         my $hatsId = $hatsRepository->findById($paramtest, 'getId');
    #         my $hatsName = $hatsRepository->findById($paramtest, 'getName');
    #         my $hatsPrice = $hatsRepository->findById($paramtest, 'getPrice');
    #         die Dumper($allHats, $hatsId, $hatsName, $hatsPrice);
    #     }
    # }

    my $tutorialParam = $request->{param}->{keywords};
    if (@$tutorialParam[0] eq 'tutorial') {
        app()->pushToStack('scripts', servicePath('hangman') . '/tutorial.js');
    }

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptLeaderboard.js');

    my $template = &_::template('hangman::welcome', {
        FIRST_VISIT => $request->{username} eq undef,
        USER_FIRST => $request->{userFirst} || '/',
        USER_SECOND =>  $request->{userSecond} || '/',
        USER_THIRD => $request->{userThird} || '/',
        COINS => $request->{coins} || 0,
        SKIN_COLOR => $request->{skinColor},
        HAT_ONE => $request->{hats} eq 1,
        HAT_TWO => $request->{hats} eq 2,
        HAT_THREE => $request->{hats} eq 3,
        HAT_FOUR => $request->{hats} eq 4,
        HAT_FIVE => $request->{hats} eq 5,
        HAT_SIX => $request->{hats} eq 6,
        WINS_FIRST => $request->{winsFirst} || '/',
        LOSSES_FIRST => $request->{lossesFirst} || '/',
        PLAYED_FIRST => $request->{winsFirst} + $request->{lossesFirst} || '/',
        SKINS_FIRST => $request->{skinsFirst},
        HATS_FIRST => $request->{hatsFirst},
        THEMES_FIRST => $request->{themesFirst},
        WINS_SECOND => $request->{winsSecond} || '/',
        LOSSES_SECOND => $request->{lossesSecond} || '/',
        PLAYED_SECOND => $request->{winsSecond} + $request->{lossesSecond} || '/',
        SKINS_SECOND => $request->{skinsSecond},
        HATS_SECOND => $request->{hatsSecond},
        THEMES_SECOND => $request->{themesSecond},
        WINS_THIRD => $request->{winsThird} || '/',
        LOSSES_THIRD => $request->{lossesThird} || '/',
        PLAYED_THIRD => $request->{winsThird} + $request->{lossesThird} || '/',
        SKINS_THIRD => $request->{skinsThird},
        HATS_THIRD => $request->{hatsThird},
        THEMES_THIRD => $request->{themesThird},
        TUTORIAL => @$tutorialParam[0] eq 'tutorial',
    });

    $request->{template} = $template;

    return $template->output();
}

sub play {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    my $template = &_::template('hangman::play');
    
    return $template->output();
}

sub playPost {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    print($request->redirect(
        -url => "/apps/hangman/play"
    ));
}

sub playEasy {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    my $word = $request->{wordEasy};

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptPlay.js');

    my $template = &_::template('hangman::playEasy', {
        FOUR => $request->{wordLengthEasy} > 3,
        FIVE => $request->{wordLengthEasy} > 4,
        SIX => $request->{wordLengthEasy} > 5,
        SEVEN => $request->{wordLengthEasy} > 6,
        EIGHT => $request->{wordLengthEasy} > 7,
        NINE => $request->{wordLengthEasy} > 8,
        TEN => $request->{wordLengthEasy} > 9,
        FIRST_L => substr($word, 0, 1),
        SECOND_L => substr($word, 1, 1),
        THIRD_L => substr($word, 2, 1),
        FOURTH_L => substr($word, 3, 1),
        FIFTH_L => substr($word, 4, 1),
        SIXTH_L => substr($word, 5, 1),
        SEVENTH_L => substr($word, 6, 1),
        EIGHT_L => substr($word, 7, 1),
        NINETH_L => substr($word, 8, 1),
        TENTH_L => substr($word, 9, 1),
        WORD_LENGTH => $request->{wordLengthEasy},
        WORD => $word,
        THEME_URL => $request->{themeURL},
        SKIN_COLOR => $request->{skinColor},
        DEFAULT => $request->{themes} eq 0,
        FRENCH => $request->{themes} eq 1,
        CARIBBEAN => $request->{themes} eq 2,
        NATIVE_ISLAND => $request->{themes} eq 3,
        NATIVE_JUNGLE => $request->{themes} eq 4,
        WESTERN => $request->{themes} eq 5,
        ROMAN => $request->{themes} eq 6,
        HAT_ONE => $request->{hats} eq 1,
        HAT_TWO => $request->{hats} eq 2,
        HAT_THREE => $request->{hats} eq 3,
        HAT_FOUR => $request->{hats} eq 4,
        HAT_FIVE => $request->{hats} eq 5,
        HAT_SIX => $request->{hats} eq 6,
    });
    
    return $template->output();
}

sub playEasyPost {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    print($request->redirect(
        -url => "/apps/hangman/play/easy"
    ));
}

sub playHard {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    my $word = $request->{wordHard};

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptPlay.js');

    my $template = &_::template('hangman::playHard', {
        FOUR => $request->{wordLengthHard} > 3,
        FIVE => $request->{wordLengthHard} > 4,
        SIX => $request->{wordLengthHard} > 5,
        SEVEN => $request->{wordLengthHard} > 6,
        EIGHT => $request->{wordLengthHard} > 7,
        NINE => $request->{wordLengthHard} > 8,
        TEN => $request->{wordLengthHard} > 9,
        FIRST_L => substr($word, 0, 1),
        SECOND_L => substr($word, 1, 1),
        THIRD_L => substr($word, 2, 1),
        FOURTH_L => substr($word, 3, 1),
        FIFTH_L => substr($word, 4, 1),
        SIXTH_L => substr($word, 5, 1),
        SEVENTH_L => substr($word, 6, 1),
        EIGHT_L => substr($word, 7, 1),
        NINETH_L => substr($word, 8, 1),
        TENTH_L => substr($word, 9, 1),
        WORD_LENGTH => $request->{wordLengthHard},
        WORD => $word,
        THEME_URL => $request->{themeURL},
        SKIN_COLOR => $request->{skinColor},
        DEFAULT => $request->{themes} eq 0,
        FRENCH => $request->{themes} eq 1,
        CARIBBEAN => $request->{themes} eq 2,
        NATIVE_ISLAND => $request->{themes} eq 3,
        NATIVE_JUNGLE => $request->{themes} eq 4,
        WESTERN => $request->{themes} eq 5,
        ROMAN => $request->{themes} eq 6,
        HAT_ONE => $request->{hats} eq 1,
        HAT_TWO => $request->{hats} eq 2,
        HAT_THREE => $request->{hats} eq 3,
        HAT_FOUR => $request->{hats} eq 4,
        HAT_FIVE => $request->{hats} eq 5,
        HAT_SIX => $request->{hats} eq 6,
    });
    
    return $template->output();
}

sub playHardPost {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    print($request->redirect(
        -url => "/apps/hangman/play/hard"
    ));
}

sub inventory {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    my $template = &_::template('hangman::inventory', {
        USERNAME => $request->{username},
        WELCOME => 1,
    });
    
    return $template->output();
}

sub inventorySkins {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptInventory.js');

    my $template = &_::template('hangman::inventory', {
        SKINS => 1,
        SKIN_ONE => $request->{skinsIdOne} eq 0,
        SKIN_TWO => $request->{skinsIdTwo} eq 0,
        SKIN_THREE => $request->{skinsIdThree} eq 0,
        SKIN_FOUR => $request->{skinsIdFour} eq 0,
        SKIN_FIVE => $request->{skinsIdFive} eq 0,
        SKIN_SIX => $request->{skinsIdSix} eq 0,
        ALREADY_EQUIPPED => $request->{alreadyEquipped} eq 1,
        NONE_BOUGHT => $request->{skinsCollection} eq 0,
        ZERO_EQ => $request->{skins} eq 0,
        ONE_EQ => $request->{skins} eq 1,
        TWO_EQ => $request->{skins} eq 2,
        THREE_EQ => $request->{skins} eq 3,
        FOUR_EQ => $request->{skins} eq 4,
        FIVE_EQ => $request->{skins} eq 5,
        SIX_EQ => $request->{skins} eq 6,
    });
    
    return $template->output();
}

sub inventorySkinsEquipped {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();
    
    return $self->inventorySkins($request);
}

sub inventoryHats {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptInventory.js');

    my $template = &_::template('hangman::inventory', {
        HATS => 1,
        HAT_ONE => $request->{hatsIdOne} eq 0,
        HAT_TWO => $request->{hatsIdTwo} eq 0,
        HAT_THREE => $request->{hatsIdThree} eq 0,
        HAT_FOUR => $request->{hatsIdFour} eq 0,
        HAT_FIVE => $request->{hatsIdFive} eq 0,
        HAT_SIX => $request->{hatsIdSix} eq 0,
        ALREADY_EQUIPPED => $request->{alreadyEquipped} eq 1,
        NONE_BOUGHT => $request->{hatsCollection} eq 0,
        ZERO_EQ => $request->{hats} eq 0,
        ONE_EQ => $request->{hats} eq 1,
        TWO_EQ => $request->{hats} eq 2,
        THREE_EQ => $request->{hats} eq 3,
        FOUR_EQ => $request->{hats} eq 4,
        FIVE_EQ => $request->{hats} eq 5,
        SIX_EQ => $request->{hats} eq 6,
    });
    
    return $template->output();
}

sub inventoryHatsEquipped {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    return $self->inventoryHats($request);
}

sub inventoryThemes {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptInventory.js');

    my $template = &_::template('hangman::inventory', {
        THEMES => 1,
        THEME_ONE => $request->{themesIdOne} eq 0,
        THEME_TWO => $request->{themesIdTwo} eq 0,
        THEME_THREE => $request->{themesIdThree} eq 0,
        THEME_FOUR => $request->{themesIdFour} eq 0,
        THEME_FIVE => $request->{themesIdFive} eq 0,
        THEME_SIX => $request->{themesIdSix} eq 0,
        ALREADY_EQUIPPED => $request->{alreadyEquipped} eq 1,
        NONE_BOUGHT => $request->{themesCollection} eq 0,
        ZERO_EQ => $request->{themes} eq 0,
        ONE_EQ => $request->{themes} eq 1,
        TWO_EQ => $request->{themes} eq 2,
        THREE_EQ => $request->{themes} eq 3,
        FOUR_EQ => $request->{themes} eq 4,
        FIVE_EQ => $request->{themes} eq 5,
        SIX_EQ => $request->{themes} eq 6,
    });
    
    return $template->output();
}

sub inventoryThemesEquipped {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();
    
    return $self->inventoryThemes($request);
}

sub shop {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    my $template = &_::template('hangman::shop', {
        USERNAME => $request->{username},
        COINS => $request->{coins},
        WELCOME => 1,
    });
    
    return $template->output();
}

sub shopSkins {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptShop.js');

    my $template = &_::template('hangman::shop', {
        SKINS => 1,
        COINS => $request->{coins},
        SKIN_ONE => $request->{skinsIdOne} eq 1,
        SKIN_TWO => $request->{skinsIdTwo} eq 1,
        SKIN_THREE => $request->{skinsIdThree} eq 1,
        SKIN_FOUR => $request->{skinsIdFour} eq 1,
        SKIN_FIVE => $request->{skinsIdFive} eq 1,
        SKIN_SIX => $request->{skinsIdSix} eq 1,
        NOT_ENOUGH_COINS => $request->{notEnoughCoins} eq 1,
        ALL_BOUGHT => $request->{skinsCollection} eq 6,
    });
    
    return $template->output();
}

sub shopSkinsBought {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    return $self->shopSkins($request);
}

sub shopHats {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptShop.js');

    my $template = &_::template('hangman::shop', {
        HATS => 1,
        COINS => $request->{coins},
        HAT_ONE => $request->{hatsIdOne} eq 1,
        HAT_TWO => $request->{hatsIdTwo} eq 1,
        HAT_THREE => $request->{hatsIdThree} eq 1,
        HAT_FOUR => $request->{hatsIdFour} eq 1,
        HAT_FIVE => $request->{hatsIdFive} eq 1,
        HAT_SIX => $request->{hatsIdSix} eq 1,
        NOT_ENOUGH_COINS => $request->{notEnoughCoins} eq 1,
        ALL_BOUGHT => $request->{hatsCollection} eq 6,
    });
    
    return $template->output();
}

sub shopHatsBought {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    return $self->shopHats($request);
}

sub shopThemes {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    app()->pushToStack('scripts', servicePath('hangman') . '/scriptShop.js');

    my $template = &_::template('hangman::shop', {
        THEMES => 1,
        COINS => $request->{coins},
        THEME_ONE => $request->{themesIdOne} eq 1,
        THEME_TWO => $request->{themesIdTwo} eq 1,
        THEME_THREE => $request->{themesIdThree} eq 1,
        THEME_FOUR => $request->{themesIdFour} eq 1,
        THEME_FIVE => $request->{themesIdFive} eq 1,
        THEME_SIX => $request->{themesIdSix} eq 1,
        NOT_ENOUGH_COINS => $request->{notEnoughCoins} eq 1,
        ALL_BOUGHT => $request->{themesCollection} eq 6,
    });
    
    return $template->output();
}

sub shopThemesBought {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();

    return $self->shopThemes($request);
}

sub profile {
    my $self = shift;
    my $request = shift;

    my $IfFirstVisit = $request->{IfFirstVisit};

    &$IfFirstVisit();
    
    my $template = &_::template('hangman::profile', {
        USERNAME => $request->{username},
        WINS => $request->{wins},
        LOSSES => $request->{losses},
        PLAYED => $request->{wins} + $request->{losses},
        RANK => $request->{rank} || '/',
        SKINS => $request->{skinsCollection} || 0,
        HATS => $request->{hatsCollection} || 0,
        THEMES => $request->{themesCollection} || 0,
        COINS => $request->{coins},
        FIRST => $request->{rank} eq 1,
        SECOND => $request->{rank} eq 2,
        THIRD => $request->{rank} eq 3,
    });
    
    return $template->output();
}

sub dashboard {
    my $self = shift;
    my $request = shift;

    # TODO: Do something useful.


    my $template = &_::template('hangman::dashboard', {
        #
    });

    return $template->output();
}

sub showMessage {
    my $self = shift;
    my $request = shift;

    # TODO: Do something useful.

    return $self->welcome($request);
}

1;
