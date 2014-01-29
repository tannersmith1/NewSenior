drop table Player;
CREATE TABLE Player(
	playerid mediumint not null auto_increment,
	partyid mediumint,
	player_password varchar(50) not null,
	username varchar(255) not null unique,
	primary key (playerid)
);


drop table if exists Party;
#create table Party(
#	partyid mediumint not null auto_increment,
#	leaderid mediumint not null,
#	primary key (partyid),
#	foreign key (leaderid) references Player(playerid)
#);


