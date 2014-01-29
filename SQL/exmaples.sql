******List of players and their parties
select player.username, party.partyname
from player
inner join player_party on player.playerID = player_party.playerID
inner join party on party.partyid = player_party.partyID
where player.username = "Tanner";

*******Create team procedure
DELIMITER $$
drop procedure if exists new_party;
create procedure new_party( ipartyname VARCHAR(45), ileader VARCHAR(45), ipassword VARCHAR(45), iisprivate TINYINT(1))
begin
insert into party (partyName, leader, passphrase, isprivate) values (ipartyname, ileader, ipassword, iisprivate);
call join_party(ileader, ipartyname);
end $$
DELIMITER ;

******Join Team procedure
DELIMITER $$
drop procedure if exists join_party;
create procedure join_party( ileader VARCHAR(45), ipartyname VARCHAR(45))
begin
select @playerID := playerid from player where player.username = ileader;
select @partyID := partyid from party where party.partyname = ipartyname;
insert into player_party (playerID, partyID) values (@playerID, @partyID);
end $$
DELIMITER ;