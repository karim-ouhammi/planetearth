-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 12 Mai 2020 à 19:08
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `agence`
--

-- --------------------------------------------------------

--
-- Structure de la table `continent`
--

CREATE TABLE IF NOT EXISTS `continent` (
  `continent` varchar(20) NOT NULL,
  PRIMARY KEY (`continent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `continent`
--

INSERT INTO `continent` (`continent`) VALUES
('Afrique'),
('Amérique'),
('Asie'),
('Europe'),
('Océanie');

-- --------------------------------------------------------

--
-- Structure de la table `destination`
--

CREATE TABLE IF NOT EXISTS `destination` (
  `destination` varchar(20) NOT NULL,
  `continent` varchar(20) NOT NULL,
  PRIMARY KEY (`destination`),
  KEY `fk_continent` (`continent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `destination`
--

INSERT INTO `destination` (`destination`, `continent`) VALUES
('Botswana', 'Afrique'),
('Cameron', 'Afrique'),
('Egypte', 'Afrique'),
('Maroc', 'Afrique'),
('Seychelles', 'Afrique'),
('Tanzanie', 'Afrique'),
('Tunisie', 'Afrique'),
('Alaska', 'Amérique'),
('Argentine', 'Amérique'),
('Canada', 'Amérique'),
('Colombie', 'Amérique'),
('Pérou', 'Amérique'),
('USA', 'Amérique'),
('Japon', 'Asie'),
('Maldives', 'Asie'),
('Allemagne', 'Europe'),
('Autriche', 'Europe'),
('Espagne', 'Europe'),
('Finlande', 'Europe'),
('France', 'Europe'),
('Groenland', 'Europe'),
('Hollande', 'Europe'),
('Italie', 'Europe'),
('Norvège', 'Europe'),
('Australie', 'Océanie');

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `idMessage` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `nomPrenom` varchar(30) NOT NULL,
  `adresseEmail` varchar(60) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `date` datetime NOT NULL,
  `vu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idMessage`),
  KEY `fk_email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `message`
--

INSERT INTO `message` (`idMessage`, `email`, `nomPrenom`, `adresseEmail`, `titre`, `message`, `date`, `vu`) VALUES
(1, NULL, 'OUHAMMI Karim', 'ouhammikarim@gmail.com', 'Titre d''un message d''un visiteur', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus ex.', '2020-05-09 16:15:27', 0),
(2, 'ouhammik@gmail.com', 'OUHAMMI Karim', 'ouhammik@gmail.com', 'Titre d''un message d''un utilisateur connecté', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut elit mauris. Vestibulum non fermentum est, sed mattis lacus. Morbi laoreet ut neque porttitor molestie. Praesent elit lectus, aliquet mattis pretium eget, elementum a tortor. Vestibulum feugiat dictum volutpat. Mauris fringilla est eros, sed tempus diam faucibus eu. Suspendisse ut sem euismod, cursus odio eget, dapibus ex. ', '2020-05-09 16:16:16', 0),
(3, 'rachidiali@gmail.com', 'RACHIDI Ali', 'rachidiali@gmail.com', 'J''aimerais bien savoir vos prochaines destinations.', 'Bonjour,\r\nd''abord je vous remercier pour vos services incroyable, bon courage pour la suite.\r\nJ''aimerais bien savoir vos prochaines destinations? Et merci d''avance.', '2020-05-09 16:19:48', 1);

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

CREATE TABLE IF NOT EXISTS `panier` (
  `idPanier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPanier`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `panier`
--

INSERT INTO `panier` (`idPanier`) VALUES
(1),
(3),
(4),
(15),
(16);

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE IF NOT EXISTS `theme` (
  `idTheme` int(11) NOT NULL AUTO_INCREMENT,
  `idType` int(11) NOT NULL,
  `nomTheme` varchar(200) NOT NULL,
  `descriptionTheme` text NOT NULL,
  PRIMARY KEY (`idTheme`),
  KEY `fk_type` (`idType`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Contenu de la table `theme`
--

INSERT INTO `theme` (`idTheme`, `idType`, `nomTheme`, `descriptionTheme`) VALUES
(1, 3, 'Voyages à pied', 'Vivre une aventure en famille et transmettre la passion de la marche à ses enfants.'),
(2, 3, 'Voyages découverte', 'Donnes à ses enfants le goût du voyage, de la découverte d''un pays et de ses habitants.'),
(3, 3, 'Voyages multi-activités', 'Pratiquer dans un environnement naturel exceptionnel des activités de plein air avec ses enfants.'),
(4, 3, 'Voyages à vélo', 'Rouler en famille et façonner son voyage au gré des étapes, chacun a son rythme.'),
(5, 1, 'Randonnée et trek', 'Randonnée, Randonnée avec animaux de bât et trek.'),
(6, 1, 'Découverte d''animaux', 'Safari et Observation animaux.'),
(7, 1, 'Activités de montagne', 'Alpinisme et trail.'),
(8, 1, 'Croisières et navigation', 'Croisières et navigation.'),
(9, 1, 'Activités neige', 'Raquette, Ski de fond / ski nordique, Ski de randonnée / Freeride, traîneau a chiens et multi-activités neige.'),
(10, 2, 'Voyagez en individuel et en privatif', 'Privilégier le voyage individuel en privatif, c''est prendre le temps de s''attarder devant un paysage, de rencontrer la population locale, de vivre son voyage à son rythme et de l''apprécier encore plus !'),
(11, 2, 'Voyages en couple', 'Rien de tel qu’un séjour romantique pour se retrouver à deux, loin de tout et libres comme l’air… Avec TUI, vivez votre séjour en amoureux sous le signe de la découverte, de la zénitude ou du sable chaud selon vos désirs : c’est votre moment.');

-- --------------------------------------------------------

--
-- Structure de la table `titre`
--

CREATE TABLE IF NOT EXISTS `titre` (
  `idTitre` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  PRIMARY KEY (`idTitre`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Contenu de la table `titre`
--

INSERT INTO `titre` (`idTitre`, `titre`) VALUES
(10, 'Destinations sélectionnées et approuvées par nos soins, qui méritent d’être découvertes'),
(11, 'Lumières d''Egypte'),
(13, 'En kayak, des fjords à la calotte polaire');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE IF NOT EXISTS `type` (
  `idType` int(11) NOT NULL AUTO_INCREMENT,
  `nomType` varchar(200) NOT NULL,
  `descriptionType` text NOT NULL,
  PRIMARY KEY (`idType`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `type`
--

INSERT INTO `type` (`idType`, `nomType`, `descriptionType`) VALUES
(1, 'Circuit accompagné', 'En petit groupe (de 5 à 15 personnes), vous partez avec un accompagnateur spécialiste ou un guide de montagne diplômé. Une équipe dédiée et un transport des bagages assuré vous permettent de profiter pleinement des randonnées'),
(2, 'Circuit individuel', 'Vous n''aimez pas faire comme tout le monde, ne supportez pas les contraintes et aimez plus que tout voyager à votre rythme pour vivre des expériences uniques ? Alors notre collection de circuits individuels est faite pour vous ! Hébergements soigneusement sélectionnés, véhicule particulier avec chauffeur et guide à votre disposition, services et avantages privilégiés, etc.'),
(3, 'Voyages en famille', 'Parce que chaque famille est unique, nos voyages ont été imaginés pour répondre à toutes les envies. Randonner au grand air, découvrir le monde, vivre de multiples aventures ou pédaler en toute liberté, petits et grands y trouveront leur compte ! A travers les valeurs qui nous animent, nous nous engageons à vous offrir la meilleure expérience de voyage possible : des moments forts à partager en famille, des itinéraires qui respectent le rythme de vos enfants, des vacances résolument actives et des découvertes qui ont du sens, le tout en assurant votre sécurité et votre tranquillité d’esprit.');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `email` varchar(60) NOT NULL,
  `idPanier` int(11) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `motDePasse` char(56) NOT NULL,
  `age` int(2) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `dateInscription` datetime NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`),
  KEY `fk_id_panier_utilisateur` (`idPanier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`email`, `idPanier`, `nom`, `prenom`, `motDePasse`, `age`, `telephone`, `dateInscription`, `isAdmin`) VALUES
('admin@planetearth.com', 1, 'OUHAMMI', 'ADMIN', 'EVipWanHi49JkjMnjPSVLZ5hu1wUVim5/W23L+5RXQHBaug0T0I1mQ==', 27, '0642176568', '2020-04-18 15:36:51', 1),
('elalaouiahmed@gmail.com', 3, 'EL ALAOUI', 'Ahmed', 'XJz1Gw4F8OOWu3bhfXG3LYUHQ+kApx4cKRQ9FnZy6JDUX8S7P+1AgA==', 23, '0678567874', '2020-04-18 15:37:27', 0),
('ouhammik@gmail.com', 4, 'OUHAMMI', 'Karim', '0/Iq6Pkc48e80nP82tQ7ShTmfi/HsS/y6VzeYyevUrwTSBZJhJ95ng==', 27, '0642176568', '2020-04-20 16:23:59', 0),
('rachidiali@gmail.com', 15, 'RACHIDI', 'Ali', 'x/BT481IGgxBs9tN51m5rKkSk0Y0mNlXbyDj1dugQTKYt98O0tUewQ==', 36, '0632412513', '2020-04-26 23:24:14', 0);

-- --------------------------------------------------------

--
-- Structure de la table `voyage`
--

CREATE TABLE IF NOT EXISTS `voyage` (
  `idVoyage` int(11) NOT NULL AUTO_INCREMENT,
  `destination` varchar(20) NOT NULL,
  `idTheme` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `date` datetime NOT NULL,
  `prix` decimal(11,0) NOT NULL,
  `duree` int(2) NOT NULL,
  `description` text NOT NULL,
  `difficulte` int(1) NOT NULL,
  `altitude` int(1) NOT NULL,
  `hebergement` varchar(200) NOT NULL,
  PRIMARY KEY (`idVoyage`),
  KEY `fk_destination` (`destination`),
  KEY `fk_theme` (`idTheme`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Contenu de la table `voyage`
--

INSERT INTO `voyage` (`idVoyage`, `destination`, `idTheme`, `titre`, `date`, `prix`, `duree`, `description`, `difficulte`, `altitude`, `hebergement`) VALUES
(1, 'Allemagne', 9, 'Raquette et bien-être au cœur de la Forêt Noire', '2020-12-18 01:00:00', '18850', 6, 'Votre itinéraire en raquettes à travers la forêt noire passe à travers de vastes étendues de neige vierge, hors sentiers. Mais pas de contrainte de portage ! Vous partez pour l''exploration des grands espaces de l''Allemagne de l''Est, de ses forêts enneigées et de ses lacs gelés, dans les régions les plus sauvages de Kainuu et Hossa. Vous profiterez de la chaleur du sauna, des bons repas traditionnels, de l''hospitalité finlandaise et du charme des hébergements, allant de l''ancienne station des gardes frontaliers au chalet, le tout dans une nature immaculée.', 2, 1, 'En hôtel *** (5)'),
(2, 'Allemagne', 5, 'De Munich à Venise : Bavière, Tyrol, Dolomites', '2020-08-08 01:00:00', '19930', 14, 'Des châteaux de Louis II de Bavière au charme de Venise, nous vous invitons à un voyage complet à travers les Alpes et trois pays : l''Allemagne, l''Autriche et l''Italie. Ce magnifique parcours de randonnée traverse les massifs alpins préservés et prestigieux de l''Ammergau et du Wetterstein (Allemagne, Bavière), du Karwendel et du Venediger (Autriche, Tyrol) et toutes les Dolomites (Italie), du nord au sud. De refuge en refuge, vous pourrez saisir toute la diversité et la beauté unique des Alpes.', 3, 3, 'En refuge (7), en hôtel (6)'),
(3, 'Autriche', 4, 'Le Danube en famille : de Passau à Linz à vélo', '2020-10-09 01:00:00', '5700', 7, 'En partant de la ville baroque de Schärding, vous pédalerez à la découverte de l’histoire et des paysages uniques de cette route millénaire. Les flots clairs et transparents de ce fleuve mythique vous accompagneront sur la voie cyclable la plus fréquentée et appréciée d’Europe jusqu’à votre but : Linz. Le retour se fera en bateau ! Majestueux, apaisant et surprenant, un voyage en famille inoubliable avec des activités ludiques tous les jours !', 1, 1, 'Roadbook, Equipe locale'),
(5, 'Hollande', 4, 'La Hollande à vélo : plages et châteaux en famille', '2021-02-19 01:00:00', '5700', 8, 'Chaque jour les courtes balades à vélo vous permettent de profiter de chaque moment en famille et prendre le temps de découvrir la région en toute sérénité. Les hébergements sont parfaitement adaptés aux enfants dans des auberges familiales imaginées pour plaire aux grands et aux petits. Ce séjour est un condensé parfait entre nature, culture, activités et détente, idéal pour des vacances inoubliables en famille.', 1, 1, 'Roadbook, Equipe locale'),
(7, 'Tanzanie', 2, 'Savane, lodge et plages en Tanzanie', '2020-09-19 01:00:00', '37995', 14, 'Venez parcourir la Terre masaï à l’ouest du Kilimandjaro, les pistes des grands parcs du nord de la Tanzanie, les grandes plaines du Serengeti, leTarangire et ses grands troupeaux d''éléphants et le cratère du Ngorongoro, à la densité animalière impressionnante. Vous vous envolerez ensuite pour Zanzibar, l’île aux épices, où a vécu Livingstone avant sa dernière expédition. De la steppe masaï aux grandes plages bordées de cocotiers de Zanzibar, un melting pot dépaysant avec le confort des lodges africains.', 1, 2, 'En hôtel (4), en lodge (4), en avion (2), en camp de toile (2), sous tente (1)'),
(8, 'Seychelles', 2, 'Echappée belle aux Seychelles', '2020-08-21 01:00:00', '25990', 9, 'Une découverte riche et variée de l’archipel seychellois, constitué d''îles toutes aussi différentes par leur géographie que leur origine. Vous apprécierez ces paysages paradisiaques, cette eau chaude et transparente bordée de blocs de granit polis par l''érosion. Découvrez les Seychelles au cours d’activités variées : balades à pied et en bateau, baignades, kayak, vélo… Dans l’océan Indien, équipés de votre masque et de votre tuba, vous croiserez des tortues et des poissons tropicaux et admirerez la délicatesse des coraux. De quoi vous mettre en appétit et céder aux mille et une saveurs créoles.', 1, 1, 'En guesthouse (7), en avion (1)'),
(9, 'Italie', 1, 'Apprentis vulcanologues en Sicile !', '2021-04-16 00:00:00', '15400', 8, 'Un voyage inoubliable qui ravira à coup sûr l''ensemble de la famille ! Si proche de la France et pourtant si dépaysante, la Sicile offre la possibilité d''admirer les seuls volcans actifs d''Europe. Au programme, le plus haut volcan d''Europe, l''Etna et ses 3300m d''altitude, et les îles-volcans de l''archipel des Eoliennes, Vulcano et Stromboli. Entre la puissance dégagée par les fréquentes éruptions du Stromboli, les effluves odorants et sulfurés de Vulcano ainsi que les paysages lunaires de l''Etna, le terrain d''exploration pour vos apprentis vulcanologues est tout simplement unique ! A ce tableau, il faut ajouter les baignades en mer et dans la piscine de l''hébergement à Vulcano... Un cadre parfait pour des vacances uniques et explosives !', 2, 1, 'En refuge (3), en appartement (2), en hôtel (2)'),
(10, 'France', 1, 'Queyras et piémonts, les Alpes du Soleil', '2020-09-01 01:00:00', '6999', 7, 'Venez vous ressourcer en famille dans ce joyau des Alpes du Sud et admirer les lacs d’altitude du parc régional du Queyras de St Véran à la vallée du Haut Guil en passant par les hautes vallées piémontaises, le mont Viso le col Agnel. Accompagnés par une mule ou un cheval, merveilleux compagnons de route pour petits et grands, partez à la découverte de ces miroirs des cimes, véritables sources de vie en équilibre fragile.', 2, 3, 'En refuge (4), sous tente (1), en gîte (1)'),
(11, 'Groenland', 5, 'En kayak, des fjords à la calotte polaire', '2020-07-25 01:00:00', '44000', 17, 'Une côte bien découpée, une multitude de petites îles, l''inlandsis tout proche déversant ses icebergs, les vestiges des premiers Vikings, la pêche, voici les ingrédients d''une randonnée en kayak qui vous permettra de découvrir les multiples aspects du Groenland.\r\nMoins fréquenté par les touristes, le Groenland oriental n’en est que plus attrayant : les glaces se distinguent par leur couleur bleutée et l’on y approche aussi de très près la calotte polaire. Les Inuit sont souvent plus abordables, et le découpage des côtes donne un secteur idéal pour les randonnées, aussi bien à pied qu’en kayak. Bienvenue au sein d’une expérience kayak inédite !', 2, 1, 'En bivouac (11), en auberge (3), en guesthouse (2)'),
(12, 'Canada', 5, 'De Whitehorse à Dawson sur le Yukon', '2020-08-13 01:00:00', '46999', 22, 'Partez pagayer sur la rivière la plus iconique du Yukon et retracez la route des milliers de chercheurs d’or. En canoë, accompagné de votre guide, vous parcourez en deux semaines, au gré du courant, les 730km qui séparent Whitehorse de Dawson City. Au cœur d’une nature sauvage, vous appréciez les paysages du Grand Nord canadien dans toute leur splendeur.\r\nVous passez vos soirées autour d’un feu de camp, et vos nuits seront bercées par le bruit de la nature au bord de la rivière. Seule la nuit à Carmacks sera en hôtel, l’occasion au milieu de votre séjour de vous réapprovisionner et de prendre une douche avant de repartir pour Dawson. Entre visites de villes fantômes et panoramas à couper le souffle, vous aurez le temps de découvrir cette magnifique région et son histoire au rythme de votre descente en canoë.', 3, 1, 'Sous tente (16), en hôtel (4), en avion (1)'),
(13, 'Groenland', 5, 'Kayak et randonnée entre icebergs et glaciers', '2020-09-24 01:00:00', '39000', 10, 'Cette région du Groenland est idéale pour une randonnée en kayak en autonomie au milieu des fjords et des icebergs. Depuis Narsaq, vous partez en bateau pour rejoindre le départ du raid en kayak qui durera 6 jours. Vous aurez le privilège d''explorer plusieurs fjords et de découvrir le labyrinthe d''îles et d''îlots. Une fois le campement établi, vous randonnez sur des petits sommets afin d''embrasser le panorama fait de fjords, de glaciers et d’icebergs. Une marche spectaculaire sur la calotte polaire glaciaire vous permettra de réaliser l''immensité et la magie de la plus grande île de l''hémisphère Nord.', 1, 1, 'En bivouac (5), en auberge (2), en guesthouse (2)'),
(14, 'Finlande', 9, 'Raquette à travers la taïga finlandaise', '2020-12-19 01:00:00', '18500', 7, 'Votre itinéraire en raquettes à travers la taïga finlandaise passe à travers de vastes étendues de neige vierge, hors sentiers. Mais pas de contrainte de portage ! Vous partez pour l''exploration des grands espaces de Finlande de l''Est, de ses forêts enneigées et de ses lacs gelés, dans les régions les plus sauvages de Kainuu et Hossa. Vous profiterez de la chaleur du sauna, des bons repas traditionnels, de l''hospitalité finlandaise et du charme des hébergements, allant de l''ancienne station des gardes frontaliers au chalet, le tout dans une nature immaculée.', 2, 1, 'En chalet (6)'),
(15, 'Pérou', 5, 'Balade péruvienne', '2020-09-07 01:00:00', '34950', 15, 'Le Pérou est une destination incroyablement riche. On y trouve des paysages époustouflants, de la forêt tropicale aux sommets andins enneigés, en passant par la côte. Une histoire où se croisent de nombreux peuples, dont l’héritage culturel est encore bien vivant aujourd’hui, des sites archéologiques superbes datant de l’époque inca, une gastronomie exceptionnelle et qui commence à faire parler d’elle dans le monde.\r\nCet itinéraire nous conduit aux sites les plus marquants du Pérou. Après la visite d’Arequipa, la ville blanche, nous poursuivons par le canyon de Colca, démesuré, qui offre aux regards ses à-pics vertigineux et ses terrasses agricoles, que survolent les majestueux condors. Sur l''Altiplano, le lac Titicaca abrite les villages quechuas de l’île de Taquile et les communautés aymaras. A Cusco, nous partons randonner dans la vallée Sacrée, à travers villages et sites historiques, pour atteindre le Machu Picchu, splendeur de la civilisation inca qui conclut merveilleusement ce périple andin.', 2, 4, 'En hôtel (7), chez l''habitant (5), en avion (2)'),
(16, 'Maroc', 5, 'Les montagnes rouges de la Tessaout', '2020-07-21 01:00:00', '7990', 8, 'Le cœur de l’Atlas central cache jalousement des plateaux d’altitude et de nombreux villages à la beauté surprenante. Niché entre les majestueux djebel Andghomer, Mt M''Goun ou djebel Ghat, vers l’oued Tessaout vous découvrirez l’une de nos randonnées d''été les plus originales, et les très beaux villages de Taniwilt, Aït Bouwahi et Tizloutine aux couleurs rouge et ocre. L''oued Tessaout, pour sa beauté, et sa région, sont les plus chantés dans la tradition orale des Berbères. Une randonnée immersion dans les temps anciens et les traditions de l’Atlas.', 2, 3, 'Sous tente (5), en hôtel *** (1), en hôtel (1)'),
(17, 'Botswana', 6, 'Botswana : safari authentique', '2020-08-12 01:00:00', '50500', 11, 'A travers ce circuit de 11 jours au Botswana vous pourrez découvrir les merveilles naturelles du parc de Moremi situé au cœur de l''Okavango, delta d’eau isolé au milieu du désert du Kalahari. C''est un écosystème unique regorgeant d''une faune abondante avec plus de 400 espèces d''oiseaux ainsi qu''un grand nombre de reptiles, d’antilopes et de prédateurs tels que lions, léopards, hyènes, lycaons et bien d''autres. Au fil du voyage vous découvrirez également le parc de Chobe au large éventail de paysages aussi variés que spectaculaires. On y trouve également l''une des plus grosses concentrations d''éléphants d''Afrique. Le soir venu, votre camp de brousse vous attendra. Vous pourrez profiter d''un agréable moment pour prendre une douche chaude sous un ciel étoilé. Vous serez très confortablement installés dans des tentes équipées de lits de camps pour une nuit aux sons de la brousse.', 1, 1, 'Sous tente avec lit (8), en avion (2)'),
(18, 'Argentine', 7, 'Aconcagua (6962m) et Cerro Bonete (5000m)', '2020-09-05 01:00:00', '63999', 22, 'Point culminant de la cordillère des Andes, l''Aconcagua (6962m), colosse de l''Amérique, domine la province de Mendoza. Gigantesque massif couronné de reliefs volcaniques, les flancs hérissés de pénitents de glace et battus par un vent, souvent très violent, défendu au sud par une paroi haute de 3000 mètres, l''Aconcagua trouve son talon d''Achille sur la face nord-ouest. L''absence de difficulté technique est compensée par une météorologie fantasque, qui peut rapidement décourager les moins motivés. La haute altitude, le froid, le vent et parfois la pluie ou la neige, constituent une véritable épreuve pour celles et ceux qui désirent approcher leurs limites physiques et de résistance à l''isolement. La conquête du géant des Andes dès 1897 par l''alpiniste suisse Zübriggen a donné le feu vert à une suite ininterrompue de tentatives et réussites de très nombreuses expéditions. L''esprit des premiers explorateurs a rapidement succombé au nationalisme et à la véritable compétition. Aujourd''hui l''ascension de l''Aconcagua par sa voie normale représente un véritable challenge pour les randonneurs expérimentés, montagnards avertis et endurants, tentés par l''expérience de la très haute altitude.', 5, 5, 'Sous tente (16), en hôtel (3), en avion (2)'),
(19, 'France', 7, 'Mont Blanc (4810m) - Voie normale', '2021-08-04 01:00:00', '21000', 6, 'En 1760, lors de son "premier voyage" à Chamonix, le naturaliste genevois H. B. de Saussure fait publier dans les trois paroisses de la vallée une promesse de récompense à qui trouverait une "route praticable" pour atteindre la cime du mont Blanc. Vingt-six ans plus tard, le 8 août 1786, M.-G. Paccard et J. Balmat percent enfin le secret du toit des Alpes et sont les premiers à atteindre son sommet. Il faut encore une année à H. B. de Saussure pour réaliser son rêve et effectuer à son tour la fameuse ascension du mont Blanc. Aujourd’hui, le mont Blanc occupe l’imaginaire de milliers d’alpinistes qui, chaque année, partent à l’assaut de son sommet. 3 jours de préparation pour 3 jours d’ascension avec un guide, la haute montagne est à votre portée.', 3, 4, 'En refuge (3), en hôtel (2)'),
(20, 'Italie', 7, 'Trek du Grand Paradis et son sommet (4061m)', '2020-10-16 01:00:00', '9990', 7, 'Premier parc naturel d’Italie et d’Europe, le parc national du Grand Paradis offre un panorama sublime sur les montagnes. Créé en 1922, il fait encore aujourd’hui référence en matière de protection de la nature : chamois, bouquetins, marmottes, renards, gypaètes. Vous pourrez observer une large variété d''animaux. Nous vous proposons ici un circuit original, empruntant quelques-uns des plus beaux cols d’altitude, entre Valgrisenche et Valsavarenche. En objectif final de ce beau trek, l’ascension du sommet du Grand Paradis permet d’embrasser tout le massif, en franchissant la barre mythique des 4000m. Un parcours complet, entre alpages et haute montagne, pour découvrir un des joyaux des Alpes italiennes.', 2, 3, 'En refuge (5), en gîte (1)'),
(21, 'Italie', 4, 'Découverte à vélo de la lagune de Venise', '2020-08-02 01:00:00', '9990', 7, 'Venise… son carnaval, ses canaux, ses gondoles… sans oublier le charme de sa lagune ! Nous vous proposons de découvrir cette région mythique de manière originale. A vélo, nous roulerons à travers le parc naturel de la rivière Sile, le long de la lagune et sur les rives de la mer Adriatique, en bateau, nous nous faufilerons entre les îles de la lagune et la multitude de canaux de la cité des Doges, à pied enfin, nous partirons à la découverte des innombrables trésors de Venise et Murano. Ce voyage à la fois dynamique, ludique et pédagogique, saura satisfaire tous les membres de la famille, petits et grands !', 1, 1, 'En hôtel *** (3), en hôtel **** (3)'),
(22, 'Tanzanie', 6, 'Safari d''antan', '2020-10-17 01:00:00', '24950', 9, 'L’Afrique des grands fauves déploie toute sa majesté au cœur des vastes paysages tanzaniens. Nous vous proposons un voyage complet, intégrant des safaris en véhicule 4x4 dans les grands parcs du nord tanzanien, du Serengeti au Tarangire. Nous avons privilégié un hébergement de charme en campement de toile et en lodge, pour retrouver ainsi l''ambiance des safaris d''autrefois. De décembre à juin, la grande migration des gnous est en mouvement dans les plaines du Serengeti, des scènes animalières inoubliables.', 1, 2, 'En lodge (4), en camp de toile (2), en avion (2)'),
(23, 'Egypte', 8, 'Lumières d''Egypte', '2020-10-07 01:00:00', '22990', 11, 'Ce voyage vous permettra de découvrir des lieux incontournables d''Egypte : la ville mythique du Caire, le merveilleux temple d''Abu Simbel et la région du Nil, le fleuve roi.\r\nVous pourrez profiter de deux journées complètes de visite guidée de la ville par un égyptologue vivant au Caire, comprenant les pyramides de Gizeh, le musée des Antiquités égyptiennes et les sites historiques de la communauté copte.\r\nPuis changement de cap et direction Assouan "l''africaine" et Abu Simbel à la découverte de la Nubie et d''Abu Simbel. Vous remonterez ensuite sur Assouan et poursuivrez votre découverte de l''Egypte lors d''une descente du Nil à bord des felouques, embarcations traditionnelles spécialement aménagées pour la nuit. Votre guide vous fera partager ses connaissances, entre visite et navigation. Un programme complet !', 1, 1, 'En hôtel (5), en bateau (3), en train (1), en guesthouse (1)'),
(24, 'Norvège', 8, 'La côte sauvage, Tromsø', '2020-08-19 01:00:00', '28000', 8, 'L''espace maritime que nous vous invitons à explorer se trouve à proximité de la petite île de Sommarøy, en Norvège du nord, un espace privilégié à la limite des fjords et du large. C''est une région magnifique encore vierge et préservée qu''il nous tient à cœur de vous faire découvrir. La côte à cet endroit comporte de nombreux récifs, îles et îlots qui constituent un vaste plan d''eau protégé de couleur turquoise. Ces îles sauvages offrent, sur plus de 150 km, un choix extrêmement varié d''escales, de bivouacs et de balades. La plupart sont désertes, certaines sont habitées, mais aucune n''est reliée à la route, et les rotations de bateaux sont peu nombreuses. Cette authenticité conservée et la beauté des paysages font de cette région une véritable perle de la nature qui mérite d''être découverte. Nos séjours ouvrent l''accès à des coins isolés et sauvages, loin des sentiers battus, mais permettent également de découvrir la vie de la petite communauté de pêcheurs de Sommarøy et Hillesøy, dernier bastion avant le large. Dépaysement garanti sous le soleil de minuit.', 2, 1, 'En bateau (6), en hôtel (1)'),
(25, 'France', 3, 'Les montagnards des Aravis', '2020-08-28 01:00:00', '4999', 7, 'Un programme original adapté à tous les âges ! Découvrez une multitude d''activités "montagne" en famille, au cœur du massif préservé des Aravis. Les adultes pourront randonner chaque jour, en demi-journée ou la journée entière, pendant que leurs enfants (p''tits loups 4/5 ans, trappeurs 6/11 ans ou ados 12/16 ans) partiront pour des activités ludiques adaptées à leur âge. Le cadre est idéal pour partager cette expérience en famille : un accès via Annecy, un hébergement confortable et chaleureux, un encadrement professionnel et la proximité du Grand-Bornand pour des moments à vous. C''est parti pour une semaine inoubliable !', 2, 2, 'En auberge (6)'),
(26, 'Finlande', 3, 'Au pays des aurores boréales', '2020-12-15 01:00:00', '28990', 8, 'Dans un panorama féerique, ce voyage adapté aux familles vous permettra d''expérimenter des activités à la journée avec vos enfants ! A travers la cani-rando où vous serez tracté par les chiens mais également grâce aux traîneaux à chiens, aux balades en raquettes ou ski de fond, vous vous évaderez à la conquête des territoires du Grand Nord et pénétrerez au cœur de la forêt boréale. Ce voyage, idéal pour une première approche en famille du Grand Nord en hiver, ne présente pas de véritables difficultés techniques mais vous permet de profiter d''un circuit authentique et sauvage.', 1, 1, 'En chalet (7)'),
(27, 'Colombie', 10, 'Colombie Coloniale', '2020-09-12 01:00:00', '35454', 15, 'Après avoir succombé aux charmes surannés des villages de Barichara et Villa de Leyva, véritable livre ouvert sur le passé, puis avoir goûté les saveurs de la région du café, c''est à Carthagène des Indes que vous profiterez de la douceur de vivre de cette folle Colombie.', 1, 2, 'En hôtel (13), en guesthouse (2)'),
(28, 'Espagne', 11, 'Hôtel Gavimar Cala Gran - Choix Flex', '2020-07-23 01:00:00', '4199', 7, 'Sa situation idéale au calme, à quelques pas de Cala d''Or. Un bon rapport qualité/prix. La formule tout inclus optionnelle. Services et équipements : Animation, parcours de Golf, terrains de Tennis, centre de plongée et encore plus.', 1, 1, 'En hôtel *** (6)');

-- --------------------------------------------------------

--
-- Structure de la table `voyagepanier`
--

CREATE TABLE IF NOT EXISTS `voyagepanier` (
  `idVoyage` int(11) NOT NULL,
  `idPanier` int(11) NOT NULL,
  `nbPersonne` int(2) NOT NULL,
  PRIMARY KEY (`idVoyage`,`idPanier`),
  KEY `fk_panier` (`idPanier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `voyagepanier`
--

INSERT INTO `voyagepanier` (`idVoyage`, `idPanier`, `nbPersonne`) VALUES
(10, 4, 6),
(16, 4, 2),
(17, 1, 1),
(22, 4, 3),
(28, 1, 1);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `destination`
--
ALTER TABLE `destination`
  ADD CONSTRAINT `fk_continent` FOREIGN KEY (`continent`) REFERENCES `continent` (`continent`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES `utilisateur` (`email`) ON DELETE SET NULL;

--
-- Contraintes pour la table `theme`
--
ALTER TABLE `theme`
  ADD CONSTRAINT `fk_type` FOREIGN KEY (`idType`) REFERENCES `type` (`idType`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `fk_id_panier_utilisateur` FOREIGN KEY (`idPanier`) REFERENCES `panier` (`idPanier`);

--
-- Contraintes pour la table `voyage`
--
ALTER TABLE `voyage`
  ADD CONSTRAINT `fk_destination` FOREIGN KEY (`destination`) REFERENCES `destination` (`destination`),
  ADD CONSTRAINT `fk_theme` FOREIGN KEY (`idTheme`) REFERENCES `theme` (`idTheme`);

--
-- Contraintes pour la table `voyagepanier`
--
ALTER TABLE `voyagepanier`
  ADD CONSTRAINT `fk_id_voyage` FOREIGN KEY (`idVoyage`) REFERENCES `voyage` (`idVoyage`),
  ADD CONSTRAINT `fk_panier` FOREIGN KEY (`idPanier`) REFERENCES `panier` (`idPanier`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
