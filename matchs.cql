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

CREATE (:Movie { title:"Robocop", 
                 released:2014, 
				 tagline:"Dead or alive you're coming with me" } )

CREATE (:Movie { title:"Tropa de Elite", 
                 released:1997,
                 tagline = "Pede para sair!" } )
				 
MATCH (filme:Movie {title:"Tropa de Elite"})
SET filme.tagline = "Pede para sair!"
return filme

MATCH (p:Person {name: "Zach Grenier"}),
      (m:Movie {title: "Robocop"})
CREATE (p)-[:ACTED_IN {roles:["Dreyfuss"]}]->(m)

MATCH (p)-[r]->(m)
where m.title = "Robocop"
return p.name, r.roles, m.title

CREATE (:Person {name:"Jose Padilha", 
                 born:1967 } )

CREATE (:Person {name: "Wagner Moura", 
                 born: 1976 })
				 
MATCH (p:Person {name: "Wagner Moura"}),
      (m:Movie {title: "Tropa de Elite"})
CREATE (p)-[:ACTED_IN {roles:["Capitão Nascimento"]}]->(m)

MATCH (p:Person {name: "Jose Padilha"}),
      (m:Movie {title: "Tropa de Elite"}),
      (n:Movie {title: "Robocop"})
CREATE (p)-[:DIRECTED]->(m)
CREATE (p)-[:DIRECTED]->(n)

MATCH (p)-[r]->(m)
where m.title = "Robocop" or m.title = "Tropa de Elite"
RETURN distinct p.name, type(r), m.title

MATCH (p)-[r]->(m)
where m.name = "Wagner Moura" and m.title = "Tropa de Elite"
set r.roles = ["Cap. Nascimento"]

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

MATCH (a)-[:ACTED_IN|:DIRECTED]->()<-[:ACTED_IN|:DIRECTED]-(b)
CREATE (a)-[:KNOWS]->(b)

MATCH p = shortestPath( (k)-[*]-(t) )  
WHERE k.name = "Keanu Reeves" AND t.name = "Tom Hanks" 
RETURN length(p), nodes(p)

MATCH (k)-[:KNOWS*2]->(c)
where k.name = "Keanu Reeves" and   
      not((k)-[:KNOWS]-(c))
	  and c <> k
RETURN distinct c
