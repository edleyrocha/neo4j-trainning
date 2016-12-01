
CREATE (:Movie { title:"Robocop", 
                 released:2014, 
				 tagline:"Dead or alive you're coming with me" } )

CREATE (:Movie { title:"Tropa de Elite", 
                 released:1997,
                 tagline = "Pede para sair!" } )
				 
MATCH (p:Person {name: "Zach Grenier"}),
      (m:Movie {title: "Robocop"})
CREATE (p)-[:ACTED_IN {roles:["Dreyfuss"]}]->(m)

MATCH (filme:Movie {title:"Tropa de Elite"})
SET filme.tagline = "Pede para sair!"
return filme

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
where m.name = "Wagner Moura" and m.title = "Tropa de Elite"
set r.roles = ["Cap. Nascimento"]

MATCH (a)-[:ACTED_IN|:DIRECTED]->()<-[:ACTED_IN|:DIRECTED]-(b)
CREATE (a)-[:KNOWS]->(b)
