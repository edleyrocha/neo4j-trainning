MATCH (ator:Person)-[papel:ACTED_IN]->(filme:Movie)
WHERE filme.title = "The Matrix"
RETURN distinct ator.name, papel.roles

MATCH ()-[r]-()
return distinct type(r)

MATCH (ator:Person)-[r:ACTED_IN]->(filme:Movie)
where ator.name = "Kevin Bacon"
return distinct filme.title, filme.released
order by filme.released desc
limit 2

MATCH (a)-[:ACTED_IN]->(f)<-[:DIRECTED]-(d)
return distinct a.name, f.title, d.name

MATCH (a)-[:ACTED_IN]->
      (f)<-[:DIRECTED]-(d)
return distinct a.name, f.title, d.name
order by f.title

MATCH (a)-[:ACTED_IN]->(f),
      (d)-[:DIRECTED]->(f)
return distinct a.name, f.title, d.name
order by f.title

MATCH p = (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d) 
RETURN p;

MATCH (a)-[:ACTED_IN]->(f), 
      (d)-[:DIRECTED]->(f) 
where a.name = d.name
RETURN distinct a.name, f.title, d.name;

MATCH (d)-[:DIRECTED]->(m), 
      (m)<-[:ACTED_IN]->(d) 
RETURN distinct d.name, m.title;
				 
MATCH (p)-[r]->(m)
where m.title = "Robocop"
return p.name, r.roles, m.title

MATCH (p)-[r]->(m)
where m.title = "Robocop" or m.title = "Tropa de Elite"
RETURN distinct p.name, type(r), m.title

MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d) 
RETURN a.name, d.name, collect(m.title)

MATCH (ator:Person)-[:ACTED_IN]->(filme:Movie) 
RETURN ator.name, count(filme.title) AS `Quant`
ORDER BY `Quant` desc
limit 3

MATCH (ator)-[r:ACTED_IN]->(filme) 
WHERE "Neo" IN r.roles
RETURN distinct filme.title

MATCH (g)-[:ACTED_IN]->(movie)<-[:ACTED_IN]-(n) 
WHERE g.name = "Gene Hackman" AND (n)-[:DIRECTED]->() 
RETURN n.name

MATCH p = shortestPath( (k)-[*]-(t) )  
WHERE k.name = "Keanu Reeves" AND t.name = "Tom Hanks" 
RETURN length(p), nodes(p)

MATCH (k)-[:KNOWS*2]->(c)
where k.name = "Keanu Reeves" and   
      not((k)-[:KNOWS]-(c))
	  and c <> k
RETURN distinct c
