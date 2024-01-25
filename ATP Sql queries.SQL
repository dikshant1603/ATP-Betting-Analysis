#Player Height vs Win prob
Select b.player_id,b.player_name,b.No_of_wins,a.No_of_loses,c.player_ht, round(b.No_of_wins/(b.No_of_wins+a.No_of_loses),2) as winprob  from ((Select player_name, player_id, count(winner_id) as No_of_wins from(Select * from player_info join atpMatch natural join tournament_info on player_id = winner_id ) as a group by player_name)as b 
inner join (Select player_name, player_id, count(loser_id) as No_of_loses from(Select * from player_info join atpMatch natural join tournament_info on player_id = loser_id) as a group by player_name)as a inner join (Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=winner_id
union
Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=loser_id)as c) where b.player_id = a.player_id and c.player_id = a.player_id and c.player_ht is not NULL;

#Grouped by win prbability calculated average height
Select z.player_ht,z.winprob, round(avg(player_ht),0) as avgHeight from(Select c.player_ht, round(b.No_of_wins/(b.No_of_wins+a.No_of_loses),2) as winprob  from ((Select player_name, player_id, count(winner_id) as No_of_wins from(Select * from player_info join atpMatch natural join tournament_info on player_id = winner_id ) as a group by player_name)as b 
inner join (Select player_name, player_id, count(loser_id) as No_of_loses from(Select * from player_info join atpMatch natural join tournament_info on player_id = loser_id) as a group by player_name)as a inner join (Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=winner_id
union
Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=loser_id)as c) where b.player_id = a.player_id and c.player_id = a.player_id) as z where z.player_ht is not NULL group by z.winprob;

#Rafael Nadal Matches won on different types of surfaces of tennis ground for matches between 2010,2012 and round in F,QF,SF
Select round,surface,count(winner_id), sum(w_svpt), sum(w_bpFaced), sum(w_SvGms), avg(w_ace) from tournament_info natural join atpMatch join player_info on player_id = winner_id where player_name like "%Rafael%Nadal%" and MatchDate between "2010%" and "2012%" and round in("F", "QF" , "SF") group by surface;

#David Ferrer Matches won on different types of surfaces of tennis ground for matches between 2010,2012 and round in F,QF,SF
Select round,surface,count(winner_id), sum(w_svpt), sum(w_bpFaced), sum(w_SvGms), avg(w_ace) from tournament_info natural join atpMatch join player_info on player_id = winner_id where player_name like "%David%Ferrer%" and MatchDate between "2010%" and "2012%" and round in("F", "QF" , "SF") group by surface;

#Rafael Nadal Matches lost on different types of surfaces of tennis ground for matches between 2010,2012 and round in F,QF,SF
Select round,surface,count(loser_id), sum(l_svpt), sum(l_bpFaced), sum(l_SvGms), avg(l_ace) from tournament_info natural join atpMatch join player_info on player_id = loser_id where player_name like "%Rafael%Nadal%" and MatchDate between "2010%" and "2012%" and round in("F", "QF" , "SF") group by surface;

#David Ferrer Matches lost on different types of surfaces of tennis ground for matches between 2010,2012 and round in F,QF,SF
Select round,surface,count(loser_id), sum(l_svpt), sum(l_bpFaced), sum(l_SvGms), avg(l_ace) from tournament_info natural join atpMatch join player_info on player_id = loser_id where player_name like "%David%Ferrer%" and MatchDate between "2010%" and "2012%" and round in("F", "QF" , "SF") group by surface;

#win percent of Rafael Nadal on hard surface for a round in F,QF,SF
Select b.player_name,b.No_of_wins,a.No_of_loses, (b.No_of_wins/(b.No_of_wins+a.No_of_loses))*100 as winperc  from ((Select player_name, player_id, count(winner_id) as No_of_wins from(Select * from player_info join atpMatch natural join tournament_info on player_id = winner_id where MatchDate between "2010%" and "2012%" and player_name like "%Rafael%Nadal%" and surface like "hard" and round in ("F", "QF" , "SF")) as a group by player_name)as b 
inner join (Select player_name, player_id, count(loser_id) as No_of_loses from(Select * from player_info join atpMatch natural join tournament_info on player_id = loser_id where MatchDate between "2010%" and "2012%" and player_name like "%Rafael%Nadal%" and surface like "hard" and round in ("F", "QF" , "SF")) as a group by player_name)as a inner join (Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=winner_id
union
Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=loser_id)as c) where b.player_id = a.player_id and c.player_id = a.player_id ;

#win percent of David Ferrer on hard surface for a round in F,QF,SF
Select b.player_name,b.No_of_wins,a.No_of_loses, round((b.No_of_wins/(b.No_of_wins+a.No_of_loses))*100,0) as winperc  from ((Select player_name, player_id, count(winner_id) as No_of_wins from(Select * from player_info join atpMatch natural join tournament_info on player_id = winner_id where MatchDate between "2010%" and "2012%" and player_name like "%David%Ferrer%" and surface like "hard" and round in ("F", "QF" , "SF")) as a group by player_name)as b 
inner join (Select player_name, player_id, count(loser_id) as No_of_loses from(Select * from player_info join atpMatch natural join tournament_info on player_id = loser_id where MatchDate between "2010%" and "2012%" and player_name like "%David%Ferrer%" and surface like "hard" and round in ("F", "QF" , "SF")) as a group by player_name)as a inner join (Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=winner_id
union
Select player_name, player_id, player_ht  from player_info join atpMatch natural join tournament_info on player_id=loser_id)as c) where b.player_id = a.player_id and c.player_id = a.player_id ;

# David ferrer vs Rafael nadal BNP Paribas Masters betting odds.
Select * from (Select a.winner_name,b.player_name  as loser_name,a.NewDate,a.Round,a.Tournament,a.WRank,a.Lrank,a.PSL, a.PSW, a.B365L,a.B365W from(Select *,player_name as winner_name,LID as loser_id from(Select * from  bettingDatat join tournament_info on TID= tourney_id where NewDate like "2013%" and Tournament like "BNP%" )as p, player_info as t where p.WID= t.player_id) as a, player_info as b where a.loser_id= b.player_id) as z where z.winner_name in ("David Ferrer", "Rafael Nadal") or z.loser_name in ("David Ferrer", "Rafael Nadal") ;