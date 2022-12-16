#1. Selecione as informações da faculdade que tem como IdDiretor 1
SELECT *
from Faculdade
where IdDiretor = 1;

#2. Liste as Informações de Professor e a disciplina que ele ensina
SELECT Professor.ID, Professor.Nome, CPF, Disciplina.Nome
FROM Professor
INNER JOIN Disciplina on Professor.ID = IdProfessor
WHERE Professor.ID IN(
	SELECT IdProfessor 
	FROM Ensina
	WHERE Professor.ID = IdProfessor);
            
#3. Liste o nome dos professores e a quantidade de avaliações que ele aplicou
SELECT Nome, count(*)  as AvaliacoesAplicadas
FROM Professor
RIGHT JOIN Aplica on ID = IdProfessor
group by Nome;

#4. Liste os Professores que estão na UEPE ou na UPFE
Select Professor.ID, Professor.Nome, Faculdade.Nome
FROM Professor
RIGHT JOIN Ensina on ID = IdProfessor
RIGHT JOIN Faculdade on Faculdade.CNPJ = Ensina.CNPJ
GROUP BY Professor.ID  HAVING Faculdade.Nome = 'UEPE' or Faculdade.NOME = 'UPFE';

#5. Liste os alunos ordenados pela quantidade de avaliações que ele realizou
SELECT Nome, count(*) as AvaliacoesRealizadas 
FROM Aluno
RIGHT JOIN Realiza on ID = IdAluno
group by Nome
Order by count(*)desc;      

#6 Liste a media das notas medias das avaliacoes realizadas por cada aluno (pega a media das avaliacoes realizadas por cada aluno e faz uma media geral)
SELECT Nome, Round(AVG(NotaMedia),2) as MediaAvaliacoes
FROM Aluno
RIGHT JOIN Realiza on ID = IdAluno
RIGHT JOIN Avaliacao on IdAvaliacao = Avaliacao.ID
GROUP BY Aluno.ID;

#7 Liste em um só select o nome e a disciplina de cada professor no formato Professor -> Disciplina
SELECT CONCAT(Professor.Nome," -> ",Disciplina.Nome) as ProfessorDisciplina
FROM Professor
INNER JOIN Disciplina on Professor.ID = IdProfessor; 

#8 Liste a distancia da ultima avaliacao e os dados dos alunos que fizerma essa ultima avaliacao
SELECT Aluno.ID, Nome, Matricula, DATEDIFF(CURDATE(), DiaProva) as DiferençaDias
FROM Aluno
INNER JOIN Realiza on  Aluno.ID = IdAluno
INNER JOIN Avaliacao on Avaliacao.ID = IdAvaliacao
ORDER BY DiaProva DESC LIMIT 1; 

#9 Liste os Professores e alunos que participaram da avaliacao 4
SELECT Nome 
FROM Professor
INNER JOIN Aplica on Professor.ID = IdProfessor
where IdAvaliacao = 4
UNION
SELECT Nome
FROM Aluno
INNER JOIN Realiza on Aluno.ID = IdAluno
where IdAvaliacao = 4;

#10 Liste a Interseção das Disciplinas das faculdades que possuem a Disciplina de Projetos e as que possuem Infra de comunicação 
SELECT DISTINCT Faculdade.Nome, Disciplina.Nome
From Faculdade
INNER JOIN Possui on Faculdade.CNPJ = Possui.CNPJ 
INNER JOIN Disciplina on IdDisciplina = ID
where Faculdade.CNPJ in (
	SELECT CNPJ FROM Possui WHERE IdDisciplina = 1
)
and Faculdade.CNPJ in (
	SELECT CNPJ FROM Possui WHERE IdDisciplina = 6
);

