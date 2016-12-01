// 8
MATCH (pessoa:Person)-[r]->(filme:Movie) 
WHERE filme.title = "Top Gun"
RETURN pessoa.name as Nome, type(r) as Cargo
order by Cargo, Nome

// Resposta CSV:
//Nome,Cargo
//Anthony Edwards,ACTED_IN
//Kelly McGillis,ACTED_IN
//Meg Ryan,ACTED_IN
//Tom Cruise,ACTED_IN
//Tom Skerritt,ACTED_IN
//Val Kilmer,ACTED_IN
//Tony Scott,DIRECTED
//Jim Cash,WROTE


// 9
CREATE (:Person {name: "Barry Pepper", born: 1970 } )
  
MATCH (pessoa:Person {name: "Barry Pepper"}),
      (filme:Movie {title: "The Green Mile"})
CREATE (pessoa)-[:ACTED_IN {roles:["Dean Stanton"]}]->(filme)


// 10
MATCH (tom:Person {name: "Tom Hanks"})-[:ACTED_IN]->()<-[:ACTED_IN]-(pessoas:Person),
      (oPessoas:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(pessoas)
WHERE not((tom)-[:KNOWS]-(oPessoas)) 
      and oPessoas <> tom
RETURN oPessoas.name, count(oPessoas.name) as Quant
order by Quant desc
limit 3

// Resposta CSV:
//oPessoas.name,Quant
//Tom Cruise,5
//Zach Grenier,5
//Cuba Gooding Jr.,4


// 11

MATCH p = shortestPath( (k)-[*]-(t) )
WHERE k.name = "Wagner Moura" AND t.name = "Demi Moore"
RETURN length(p), nodes(p)

// Resposta JSON:
length(p),nodes(p)
5,"[{""born"":1976,""name"":""Wagner Moura""},{""born"":1967,""name"":""Jose Padilha""},{""born"":1954,""name"":""Zach Grenier""},{""born"":1963,""name"":""Helen Hunt""},{""born"":1937,""name"":""Jack Nicholson""},{""born"":1962,""name"":""Demi Moore""}]"
