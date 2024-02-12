#!/usr/bin/perl

use strict;
use warnings;

use Http::Route;
use Hangman::Http::Controllers::Controller;
use Foundation::Appify;
use Repositories::PlayerRepository;
use Repositories::PlayerThemesRepository;
use Repositories::PlayerSkinsRepository;
use Repositories::PlayerHatsRepository;
use Repositories::HatsRepository;


Http::Route::group({

    middlewares => [

        # Check if the visitor is signed in.
        'Http::Middlewares::Auth',
        
        # TODO: Implement service middleware classes instead of only using
        # TODO: closures.
        sub {
            my $request = shift;
            my $next = shift;
            
            # Player
            my $playerRepository = Repositories::PlayerRepository->new();
            
            my $userId = user()->get('id');
            my $username = $playerRepository->findByUserId($userId, 'getUsername');
            my $wins = $playerRepository->findByUserId($userId, 'getWins');
            my $losses = $playerRepository->findByUserId($userId, 'getLosses');
            my $themes = $playerRepository->findByUserId($userId, 'getThemes');
            my $skins = $playerRepository->findByUserId($userId, 'getSkins');
            my $hats = $playerRepository->findByUserId($userId, 'getHats');
            my $coins = $playerRepository->findByUserId($userId, 'getCoins');
            my $rank = $playerRepository->getRank($username);
            my $highscores = $playerRepository->sortByWins();
            my $player = {
                'user_id' => $userId,
                'username' => $username,
                'wins' => $wins,
                'losses' => $losses,
                'themes' => $themes,
                'skins' => $skins,
                'hats' => $hats,
                'coins' => $coins,
            };
            my $skinColor = 'black';
            if ($skins eq 1) {
                $skinColor = 'red';
            };
            if ($skins eq 2) {
                $skinColor = 'blue';
            };
            if ($skins eq 3) {
                $skinColor = 'yellow';
            };
            if ($skins eq 4) {
                $skinColor = 'green';
            };
            if ($skins eq 5) {
                $skinColor = 'orange';
            };
            if ($skins eq 6) {
                $skinColor = 'purple';
            };

            $request->{skinColor} = $skinColor;
            $request->{wins} = $wins;
            $request->{losses} = $losses;
            $request->{username} = $username;
            $request->{highscores} = $highscores;
            $request->{coins} = $coins;
            $request->{rank} = $rank->{ranking};
            $request->{player} = $player;
            $request->{skins} = $skins;
            $request->{hats} = $hats;
            $request->{themes} = $themes;


            # Player Themes
            my $playerThemesRepository = Repositories::PlayerThemesRepository->new();

            my $themesIdZero = 1;
            my $themesIdOne = $playerThemesRepository->findByUsername($username, 'getIdOne');
            my $themesIdTwo = $playerThemesRepository->findByUsername($username, 'getIdTwo');
            my $themesIdThree = $playerThemesRepository->findByUsername($username, 'getIdThree');
            my $themesIdFour = $playerThemesRepository->findByUsername($username, 'getIdFour');
            my $themesIdFive = $playerThemesRepository->findByUsername($username, 'getIdFive');
            my $themesIdSix = $playerThemesRepository->findByUsername($username, 'getIdSix');

            $request->{themesIdOne} = $themesIdOne;
            $request->{themesIdTwo} = $themesIdTwo;
            $request->{themesIdThree} = $themesIdThree;
            $request->{themesIdFour} = $themesIdFour;
            $request->{themesIdFive} = $themesIdFive;
            $request->{themesIdSix} = $themesIdSix;
            my $playerThemes = {
                'username' => $username,
                'id_0' => 1,
                'id_1' => $themesIdOne,
                'id_2' => $themesIdTwo,
                'id_3' => $themesIdThree,
                'id_4' => $themesIdFour,
                'id_5' => $themesIdFive,
                'id_6' => $themesIdSix,
            };
            $request->{themesCollection} = $themesIdOne + $themesIdTwo + $themesIdThree + $themesIdFour + $themesIdFive + $themesIdSix;


            # Player Skins
            my $playerSkinsRepository = Repositories::PlayerSkinsRepository->new();

            my $skinsIdZero = 1;
            my $skinsIdOne = $playerSkinsRepository->findByUsername($username, 'getIdOne');
            my $skinsIdTwo = $playerSkinsRepository->findByUsername($username, 'getIdTwo');
            my $skinsIdThree = $playerSkinsRepository->findByUsername($username, 'getIdThree');
            my $skinsIdFour = $playerSkinsRepository->findByUsername($username, 'getIdFour');
            my $skinsIdFive = $playerSkinsRepository->findByUsername($username, 'getIdFive');
            my $skinsIdSix = $playerSkinsRepository->findByUsername($username, 'getIdSix');

            $request->{skinsIdOne} = $skinsIdOne;
            $request->{skinsIdTwo} = $skinsIdTwo;
            $request->{skinsIdThree} = $skinsIdThree;
            $request->{skinsIdFour} = $skinsIdFour;
            $request->{skinsIdFive} = $skinsIdFive;
            $request->{skinsIdSix} = $skinsIdSix;
            my $playerSkins = {
                'username' => $username,
                'id_0' => 1,
                'id_1' => $skinsIdOne,
                'id_2' => $skinsIdTwo,
                'id_3' => $skinsIdThree,
                'id_4' => $skinsIdFour,
                'id_5' => $skinsIdFive,
                'id_6' => $skinsIdSix,
            };
            $request->{skinsCollection} = $skinsIdOne + $skinsIdTwo + $skinsIdThree + $skinsIdFour + $skinsIdFive + $skinsIdSix;


            # Player Hats
            my $playerHatsRepository = Repositories::PlayerHatsRepository->new();

            my $hatsIdZero = 1;
            my $hatsIdOne = $playerHatsRepository->findByUsername($username, 'getIdOne');
            my $hatsIdTwo = $playerHatsRepository->findByUsername($username, 'getIdTwo');
            my $hatsIdThree = $playerHatsRepository->findByUsername($username, 'getIdThree');
            my $hatsIdFour = $playerHatsRepository->findByUsername($username, 'getIdFour');
            my $hatsIdFive = $playerHatsRepository->findByUsername($username, 'getIdFive');
            my $hatsIdSix = $playerHatsRepository->findByUsername($username, 'getIdSix');

            $request->{hatsIdOne} = $hatsIdOne;
            $request->{hatsIdTwo} = $hatsIdTwo;
            $request->{hatsIdThree} = $hatsIdThree;
            $request->{hatsIdFour} = $hatsIdFour;
            $request->{hatsIdFive} = $hatsIdFive;
            $request->{hatsIdSix} = $hatsIdSix;
            my $playerHats = {
                'username' => $username,
                'id_0' => 1,
                'id_1' => $hatsIdOne,
                'id_2' => $hatsIdTwo,
                'id_3' => $hatsIdThree,
                'id_4' => $hatsIdFour,
                'id_5' => $hatsIdFive,
                'id_6' => $hatsIdSix,
            };
            $request->{hatsCollection} = $hatsIdOne + $hatsIdTwo + $hatsIdThree + $hatsIdFour + $hatsIdFive + $hatsIdSix;


            # Hats
            # my $hatsRepository = Repositories::HatsRepository->new();
            # my $hatId = 1;
            # my $hatsId = $hatsRepository->findById($hatId, 'getId');
            # my $hatsName = $hatsRepository->findById($hatId, 'getName');
            # my $hatsPrice = $hatsRepository->findById($hatId, 'getPrice');

            # $request->{hatsId} = $hatsId;
            # $request->{hatsName} = $hatsName;
            # $request->{hatsPrice} = $hatsPrice;
            # my $hats = {
            #     'id' => $hatsId,
            #     'name' => $hatsName,
            #     'price' => $hatsPrice,
            # };


            # Create Player and Players Inventory
            my $usernameExists = $playerRepository->findByUsername($request->param('username'), 'getUsername');

            $request->{usernameExists} = $usernameExists;

            my $playerCreate = {
                'user_id' => $userId,
                'username' => $request->param('username'),
                'wins' => 0,
                'losses' => 0,
                'themes' => 0,
                'skins' => 0,
                'hats' => 0,
                'coins' => 0,
            };

            my $inventoryCreate = {
                'username' => $request->param('username'),
                'id_0' => 1,
                'id_1' => 0,
                'id_2' => 0,
                'id_3' => 0,
                'id_4' => 0,
                'id_5' => 0,
                'id_6' => 0,
            };

            if ($request->param('username') ne undef) {
                unless ($usernameExists) {
                    $playerRepository->create($playerCreate);
                    $playerThemesRepository->create($inventoryCreate);
                    $playerSkinsRepository->create($inventoryCreate);
                    $playerHatsRepository->create($inventoryCreate);
                    $request->{tutorial} = 1;
                    print $request->redirect('https://apps.test/apps/hangman?tutorial');
                }
            };


            # Play
            my $getFolder = sub {
                return join ('/', splice(@{[split(/\//, __FILE__)]},
                0,
                scalar @{[split(/\//, __FILE__)]} -1)) . "/";
            };

            my $filenameEasy = &$getFolder . '../lists/easyWords.txt';
            open(my $fh, '<', $filenameEasy) or die $!;
            my @linesEasy = <$fh>;
            close $fh;

            my $filenameHard = &$getFolder . '../lists/hardWords.txt';
            open(my $fh, '<', $filenameHard) or die $!;
            my @linesHard = <$fh>;
            close $fh;

            my $randNumber = int(rand(50));

            my $wordEasy = @linesEasy[$randNumber];
            my $wordHard = @linesHard[$randNumber];

            $request->{wordEasy} = uc($wordEasy);
            $request->{wordHard} = uc($wordHard);

            $request->{wordLengthEasy} = (length($wordEasy) - 1);
            $request->{wordLengthHard} = (length($wordHard) - 1);


            # Shop/Inventory
            my $isItemOwned = 0;
            my $itemId = 0;
            my $itemName = '';
            my $itemPrice = 0;
            my $itemType = '';
            my $currentItem = 0;
            my $itemRepository = 0;
            my $itemList = 0;

            my @cgiParam = $request->param();


            # Skins -> Shop/Inventory
            if ($cgiParam[0] eq 'defaultSkin' || $cgiParam[0] eq 'red' || $cgiParam[0] eq 'blue' || $cgiParam[0] eq 'yellow' || $cgiParam[0] eq 'green' || $cgiParam[0] eq 'orange' || $cgiParam[0] eq 'purple') {
                $itemType = 'skins';
                $currentItem = $skins;
                $itemList = $playerSkins;
                $itemRepository = $playerSkinsRepository;
            }
            if ($cgiParam[0] eq 'defaultSkin') {
                $isItemOwned = $skinsIdZero;
                $itemName = 'defaultSkin';
            }
            if ($cgiParam[0] eq 'red') {
                $itemName = 'red';
                $itemId = 1;
                $itemPrice = 12;
                $isItemOwned = $skinsIdOne;
            }
            if ($cgiParam[0] eq 'blue') {
                $itemName = 'blue';
                $itemId = 2;
                $itemPrice = 12;
                $isItemOwned = $skinsIdTwo;
            }
            if ($cgiParam[0] eq 'yellow') {
                $itemName = 'yellow';
                $itemId = 3;
                $itemPrice = 12;
                $isItemOwned = $skinsIdThree;
            }
            if ($cgiParam[0] eq 'green') {
                $itemName = 'green';
                $itemId = 4;
                $itemPrice = 12;
                $isItemOwned = $skinsIdFour;
            }
            if ($cgiParam[0] eq 'orange') {
                $itemName = 'orange';
                $itemId = 5;
                $itemPrice = 12;
                $isItemOwned = $skinsIdFive;
            }
            if ($cgiParam[0] eq 'purple') {
                $itemName = 'purple';
                $itemId = 6;
                $itemPrice = 12;
                $isItemOwned = $skinsIdSix;
            }


            # Themes -> Shop/Inventory
            if ($cgiParam[0] eq 'defaultTheme' || $cgiParam[0] eq 'french' || $cgiParam[0] eq 'caribbean' || $cgiParam[0] eq 'nativeIsland' || $cgiParam[0] eq 'nativeJungle' || $cgiParam[0] eq 'western' || $cgiParam[0] eq 'roman') {
                $itemType = 'themes';
                $currentItem = $themes;
                $itemList = $playerThemes;
                $itemRepository = $playerThemesRepository;
            }
            if ($cgiParam[0] eq 'defaultTheme') {
                $isItemOwned = $themesIdZero;
                $itemName = 'defaultTheme';
            }
            if ($cgiParam[0] eq 'french') {
                $itemName = 'french';
                $itemId = 1;
                $itemPrice = 20;
                $isItemOwned = $themesIdOne;
            }
            if ($cgiParam[0] eq 'caribbean') {
                $itemName = 'caribbean';
                $itemId = 2;
                $itemPrice = 18;
                $isItemOwned = $themesIdTwo;
            }
            if ($cgiParam[0] eq 'nativeIsland') {
                $itemName = 'nativeIsland';
                $itemId = 3;
                $itemPrice = 16;
                $isItemOwned = $themesIdThree;
            }
            if ($cgiParam[0] eq 'nativeJungle') {
                $itemName = 'nativeJungle';
                $itemId = 4;
                $itemPrice = 15;
                $isItemOwned = $themesIdFour;
            }
            if ($cgiParam[0] eq 'western') {
                $itemName = 'western';
                $itemId = 5;
                $itemPrice = 18;
                $isItemOwned = $themesIdFive;
            }
            if ($cgiParam[0] eq 'roman') {
                $itemName = 'roman';
                $itemId = 6;
                $itemPrice = 22;
                $isItemOwned = $themesIdSix;
            }


            # Hats -> Shop/Inventory
            if ($cgiParam[0] eq "defaultHat" || $cgiParam[0] eq 'crown' || $cgiParam[0] eq 'pirateHat' || $cgiParam[0] eq 'baseballCap' || $cgiParam[0] eq 'gladiatorHelmet' || $cgiParam[0] eq 'vikingHelmet' || $cgiParam[0] eq 'strawHat') {
                $itemType = 'hats';
                $currentItem = $hats;
                $itemList = $playerHats;
                $itemRepository = $playerHatsRepository;
            }
            if ($cgiParam[0] eq 'defaultHat') {
                $isItemOwned = $hatsIdZero;
                $itemName = 'defaultHat';
            }
            if ($cgiParam[0] eq 'crown') {
                $itemName = 'crown';
                $itemId = 1;
                $itemPrice = 18;
                $isItemOwned = $hatsIdOne;
            }
            if ($cgiParam[0] eq 'pirateHat') {
                $itemName = 'pirateHat';
                $itemId = 2;
                $itemPrice = 16;
                $isItemOwned = $hatsIdTwo;
            }
            if ($cgiParam[0] eq 'baseballCap') {
                $itemName = 'baseballCap';
                $itemId = 3;
                $itemPrice = 12;
                $isItemOwned = $hatsIdThree;
            }
            if ($cgiParam[0] eq 'gladiatorHelmet') {
                $itemName = 'gladiatorHelmet';
                $itemId = 4;
                $itemPrice = 20;
                $isItemOwned = $hatsIdFour;
            }
            if ($cgiParam[0] eq 'vikingHelmet') {
                $itemName = 'vikingHelmet';
                $itemId = 5;
                $itemPrice = 14;
                $isItemOwned = $hatsIdFive;
            }
            if ($cgiParam[0] eq 'strawHat') {
                $itemName = 'strawHat';
                $itemId = 6;
                $itemPrice = 18;
                $isItemOwned = $hatsIdSix;
            }


            # inventory
            if ($isItemOwned eq 1 && $request->param($itemName) eq 1) {
                if ($currentItem ne $itemId) {
                    $player->{$itemType} = $itemId;
                    $playerRepository->create($player);
                    print($request->redirect(
                        -url => "/apps/hangman/inventory/$itemType"
                    ));
                }
                else {
                    $request->{alreadyEquipped} = 1;
                }
            }


            # shop
            if ($isItemOwned eq 0 && $request->param($itemName) eq $itemPrice) {
                if ($coins >= $itemPrice) {
                    $itemList->{'id_' . $itemId} = 1;
                    $itemRepository->create($itemList);
                    $player->{'coins'} = $coins - $itemPrice;
                    $playerRepository->create($player);
                    print($request->redirect(
                        -url => "/apps/hangman/shop/$itemType"
                    ));
                }
                else {
                    $request->{notEnoughCoins} = 1;
                }
            }


            # Finish Game
            if ($request->param('wonEasy')) {
                $player->{'wins'} = $request->{wins} + 1;
                $player->{'coins'} = $request->{coins} + 1;
                $playerRepository->create($player);
            }

            if ($request->param('wonHard')) {
                $player->{'wins'} = $request->{wins} + 1;
                $player->{'coins'} = $request->{coins} + 2;
                $playerRepository->create($player);
            }

            if ($request->param('lost')) {
                $player->{'losses'} = $request->{losses} + 1;
                $playerRepository->create($player);
            }


            # Check If first visit
            $request->{IfFirstVisit} = sub {
                unless ($username) { 
                    print $request->redirect('https://apps.test/apps/hangman');
                }
    	    };


            # Find theme URL
            if ($themes eq '0') {
                $request->{themeURL} = 'https://i.ibb.co/b2S24W7/Western2-resized-Standard.jpg';
            };

            if ($themes eq 1) {
                $request->{themeURL} = 'https://i.ibb.co/j8mCLqp/Revolution-resized-Guillotine.jpg';
            };

            if ($themes eq 2) {
                $request->{themeURL} = 'https://i.ibb.co/LRmy2gX/Pirate-Theme-night.png';
            };

            if ($themes eq 3) {
                $request->{themeURL} = 'https://i.ibb.co/FqY7X5B/Pot-Boiling.jpg';
            };

            if ($themes eq 4) {
                $request->{themeURL} = 'https://i.ibb.co/RbLnvxd/Fire-Burning.jpg';
            };

            if ($themes eq 5) {
                $request->{themeURL} = 'https://i.ibb.co/JpZvYYz/train-train.jpg';
            };

            if ($themes eq 6) {
                $request->{themeURL} = 'https://i.ibb.co/ZGzJr74/Gladiator-Colloseum.jpg';
            };


            # Create Leaderboard
            $request->{leaderboard} = sub {
                my $count = $playerRepository->count();

                $count = $count->{count};

                if ($count > 3) {
                    $count = 3;
                };

                my $userFirst = undef;

                my $winsFirst = undef;

                my $lossesFirst = undef;

                my $userSecond = undef;

                my $userThird = undef;

                if ($count > 0) {
                    $userFirst = @$highscores[0]->[0];
                }

                if ($count > 1) {
                    $userSecond = @$highscores[1]->[0];
                }

                if ($count > 2) {
                    $userThird = @$highscores[2]->[0];
                }

                $request->{count} = $count;

                $request->{userFirst} = $userFirst;

                $request->{userSecond} = $userSecond;

                $request->{userThird} = $userThird;

                # first
                $request->{winsFirst} = $playerRepository->findByUsername($userFirst, 'getWins');

                $request->{lossesFirst} = $playerRepository->findByUsername($userFirst, 'getLosses');

                my $skinsFirst = $playerSkinsRepository->total($userFirst);

                my $skinsFirstSum = 0;

                foreach my $element (@$skinsFirst) {
                    $skinsFirstSum += $element;
                }

                $request->{skinsFirst} = $skinsFirstSum;

                my $hatsFirst = $playerHatsRepository->total($userFirst);

                my $hatsFirstSum = 0;

                foreach my $element (@$hatsFirst) {
                    $hatsFirstSum += $element;
                }

                $request->{hatsFirst} = $hatsFirstSum;

                my $themesFirst = $playerThemesRepository->total($userFirst);

                my $themesFirstSum = 0;

                foreach my $element (@$themesFirst) {
                    $themesFirstSum += $element;
                }

                $request->{themesFirst} = $themesFirstSum;

                # second
                $request->{winsSecond} = $playerRepository->findByUsername($userSecond, 'getWins');

                $request->{lossesSecond} = $playerRepository->findByUsername($userSecond, 'getLosses');

                my $skinsSecond = $playerSkinsRepository->total($userSecond);

                my $skinsSecondSum = 0;

                foreach my $element (@$skinsSecond) {
                    $skinsSecondSum += $element;
                }

                $request->{skinsSecond} = $skinsSecondSum;

                my $hatsSecond = $playerHatsRepository->total($userSecond);

                my $hatsSecondSum = 0;

                foreach my $element (@$hatsSecond) {
                    $hatsSecondSum += $element;
                }

                $request->{hatsSecond} = $hatsSecondSum;

                my $themesSecond = $playerThemesRepository->total($userSecond);

                my $themesSecondSum = 0;

                foreach my $element (@$themesSecond) {
                    $themesSecondSum += $element;
                }

                $request->{themesSecond} = $themesSecondSum;

                # third
                $request->{winsThird} = $playerRepository->findByUsername($userThird, 'getWins');

                $request->{lossesThird} = $playerRepository->findByUsername($userThird, 'getLosses');

                my $skinsThird = $playerSkinsRepository->total($userThird);

                my $skinsThirdSum = 0;

                foreach my $element (@$skinsThird) {
                    $skinsThirdSum += $element;
                }

                $request->{skinsThird} = $skinsThirdSum;

                my $hatsThird = $playerHatsRepository->total($userThird);

                my $hatsThirdSum = 0;

                foreach my $element (@$hatsThird) {
                    $hatsThirdSum += $element;
                }

                $request->{hatsThird} = $hatsThirdSum;

                my $themesThird = $playerThemesRepository->total($userThird);

                my $themesThirdSum = 0;

                foreach my $element (@$themesThird) {
                    $themesThirdSum += $element;
                }

                $request->{themesThird} = $themesThirdSum;
            };


            return &$next($request);
        },

    ],

}, sub {

    # Routes within this scope require the visitor to be signed in.

    Http::Route::group({

        # The prefix of the http route.
        prefix => '/apps/hangman',

        # The prefix of the route name.
        as => 'apps.hangman.',

    }, sub {

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/shop',

            # The prefix of the route name.
            as => 'shop.',

        }, sub {

            Http::Route::get('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopSkins(
                    $request,
                );

            }),

            Http::Route::post('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopSkinsBought(
                    $request,
                );

            }),

            Http::Route::get('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopHats(
                    $request,
                );

            }),

            Http::Route::post('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopHatsBought(
                    $request,
                );

            }),

            Http::Route::get('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopThemes(
                    $request,
                );

            }),

            Http::Route::post('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopThemesBought(
                    $request,
                );

            }),

        });

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/inventory',

            # The prefix of the route name.
            as => 'inventory.',

        }, sub {

            Http::Route::get('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventorySkins(
                    $request,
                );

            }),

            Http::Route::post('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventorySkinsEquipped(
                    $request,
                );

            }),

            Http::Route::get('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryHats(
                    $request,
                );

            }),

            Http::Route::post('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryHatsEquipped(
                    $request,
                );

            }),

            Http::Route::get('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryThemes(
                    $request,
                );

            }),

            Http::Route::post('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryThemesEquipped(
                    $request,
                );

            }),

        });

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/play',

            # The prefix of the route name.
            as => 'play.',

        }, sub {

            Http::Route::get('/easy', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playEasy(
                    $request,
                );

            }),

            Http::Route::post('/easy', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playEasyPost(
                    $request,
                );

            }),

            Http::Route::get('/hard', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playHard(
                    $request,
                );

            }),

            Http::Route::post('/hard', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playHardPost(
                    $request,
                );

            }),

        });
        
        Http::Route::get('/', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->welcome(
                $request,
            );

        }),

        Http::Route::post('/', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->welcome(
                $request,
            );

        }),

        Http::Route::get('/play', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->play(
                $request,
            );

        }),

        Http::Route::post('/play', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->playPost(
                $request,
            );

        }),

        Http::Route::get('/inventory', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->inventory(
                $request,
            );

        }),

        Http::Route::get('/shop', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->shop(
                $request,
            );

        }),

        Http::Route::get('/profile', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->profile(
                $request,
            );

        }),

        Http::Route::get('/messages/{id}', sub {

            my $request = shift;

            return Hangman::Http::Controllers::Controller->new()->showMessage(
                $request,
            );

        }),

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/admin',

            # The prefix of the route name.
            as => 'admin.',

            middlewares => [

                sub {
                    my $request = shift;
                    my $next = shift;
                    
                    unless (user()->isHangmanAdmin()) {
                        abort('Unauthorized.', 403);
                    }

                    return &$next($request); 
                },

            ],

        }, sub {
            
            Http::Route::get('/', sub {

                my $request = shift;

                return Hangman::Http::Controllers::Controller->new()->dashboard(
                    $request,
                );

            }),

        });

    });

});
