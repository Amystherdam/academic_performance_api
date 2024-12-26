# Academic Performance API

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)![Postgres](https://img.shields.io/badge/postgresql-4169e1?style=for-the-badge&logo=postgresql&logoColor=white)

Olá! Obrigado por disponibilizar um pouco do seu tempo. Abaixo estão todas as informações que você precisa sobre o projeto, desde testar manualmente até a documentação geral. Se trata de uma API que

- Cadastra notas para estudantes em disciplinas previamente existentes
- Lista os melhores estudantes
- Lista o histórico de notas dos estudantes
- Trás os fechamentos mensais dos estudantes por disciplina e o geral

Agora vamos falar um pouco sobre a estrutura do projeto. Aliás, esse projeto é apenas a API e ela é complementada por uma interface visual que está [nesse outro repositório](https://github.com/Amystherdam/academic_performance) que contém seu próprio README.

## Gestão do projeto

Todas as issues do projeto foram inseridas e ligeiramente documentadas no github projects através de descrições de problemas e checklists de resolução. Acesse o [board aqui](https://github.com/users/Amystherdam/projects/7/views/2)

## Versões

- Ruby 3.3.5
- Rails 7.2.1
- rspec-rails 7.1
- PostgreSQL 17.2
- Mais informações de versões no `Gemfile` e no `Gemfile.lock`

## Diagrama do banco de dados

O diagrama do banco foi feito na parte de levantamento de requisitos e melhorado e pensado ao longo do projeto. Existe um arquivo chamado `database.dbml` que guarda esse diagrama. A sua versão visual mais intuitiva pode ser feita em qualquer ferramenta que abra DBML (database markup language). Minha escolhida é o [dbdiagram](https://dbdiagram.io/), o [diagrama também já está público aqui](https://dbdiagram.io/d/academic_performance_api-675b4e0d46c15ed479375142) para visualização.

A visão é basicamente a que está abaixo

<img width="1046" alt="Image" src="https://github.com/user-attachments/assets/698f95ca-8ab2-44c3-b392-a63e89316aeb" />

### Tabelas / Modelos

Existem 6 tabelas no projeto

- `cicles`
- `grades`
- `overall_student_grades`
- `students`
- `students_subjects_cicles`
- `subjects`

#### Cicle

A tabela `cicles` guarda informações referentes aos meses e aos anos daqueles meses. Ela é importante para que os fechamentos sejam computados nos meses corretor é para que não hajam duplicidades no mesmo período.

#### Grade

A tabela `grades` guarda informações gerais de notas de todos os alunos, ela também é o histórico de notas, montando uma associação entre um estudante, um assunto / matéria e a nota.

#### OverallStudentGrade

A tabela `overall_student_grades` guarda a nota geral do aluno, criando uma relação entre um aluno e um ciclo, registrando essa nota com base na nota final das disciplinas do aluno. Essa tabela também é a fonte do ranking dos melhores alunos.

#### Student

A tabela `students` guarda informações do estudante. Como esse projeto não tem login, que aliás, poderia ser facilmente implementado com mais tempo, foi guardado apenas o nome dos estudantes, para poder vincular as notas a alguma entidade.

#### StudentSubjectCicle

A tabela `students_subjects_cicles` guarda informações das notas finais das disciplinas do aluno. É basicamente uma relação many-to-many entre essas 3 entidades e tem uma coluna que registra uma nota para cada disciplina

#### Subject

A tabela `subjects` guarda as matérias / assuntos dos estudantes e dos ciclos. Ela tem duas colunas muito importantes, que são `calculation_type` e `days_interval`. `calculation_type` guarda qual vai ser a fórmula que o cálculo daquela disciplina vai funcionar. Pode ser `:last_days_average` que guia o cálculo para apurar a média com base é um intervalo de dias.

Esse intervalo é o `calculation_type`. Esse campo pode ser um número inteiro entre 90 e 365. Quanto maior a quantidade de dias, mais antigas as notas que podem entrar no cálculo da nota final por disciplina.

Caso o  `calculation_type` seja preenchido para seguir o `last_value`, invés de pegar as ultimas notas de um intervalo, pegará apenas o último valor para a nota final.

## Regra de negócio

Bom, a explicação das tabelas já diz muita coisa, mas, existem outros dois arquivos muito importantes que vale a pena comentar. 

### ClosingAcademicPeriodJob

O `closing_academic_period_job.rb` guarda a classe `ClosingAcademicPeriodJob` essa classe é chamada através de uma cron que é configurada pela gem `sidekiq-cron`. Essencialmente esse job roda uma vez no primeiro dia de cada mês e vai fazer o fechamento das notas das matérias / temas para o mês anterior. 

Ele consome a tabela de grades, passa por todos os alunos e por todas as matérias calculando e salvando em `StudentSubjectCicle`, o que depois será a nota final para cada disciplina.

Além disso, ele calcula a nota final dos alunos com base justamente nas notas que foram salvas em `StudentSubjectCicle` para cada disciplina de cada aluno. Salvando o valor final por aluno na tabela correspondente ao modelo `OverallStudentGrade`.

Um job para cada tabela, que são

- `calculate_final_subject_grades_by_student`
- `calculate_students_final_grade`

Outra informação importante sobre esse job é que o fato de ele só rodar uma vez no primeiro dia de cada mês, implica que você terá que executar o job manualmente para poder concluir os testes de todos os endpoints, pois, se não eles estarão vazios. 

### seeds.rb

Assim como o `ClosingAcademicPeriodJob` o arquivo `seeds.rb` tem justamente as informações que o job vai utilizar, como `grades`, `students` e etc. Ao subir o container, ele já vai rodar junto com as dependencias

## API

A API conta com um arquivo chamado `academic_performance_api.postman_collection.json`, ele tem todas as variáveis e os endpoints já montados para você conferir se utilizar o [Postman](https://www.postman.com/), talvez o [Insomnia](https://insomnia.rest) também leia esse arquivo, não tenho certeza.

Os endpoints estão divididos em

- `/students`
- `/grades`

Os outros controllers não necessitaram de exposição, achei melhor trazer o rankin e as notas no endpoint `/students`, já que essas informações são referentes aos estudantes.

Em `/grades` foi exposto apenas o endpoint de criação de nota no momento

## Docker

A aplicação está rodando com docker. Existem dois arquivos `.yml`, o próprio `docker-compose.yml` e o `docker-compose.test.yml`

O último roda justamente os testes, decidi separar para não rodar a suite de teste toda vez que o projeto iniciar.
O compose principal tem todas as configurações pertinente como `redis`, `sidekiq`, banco de dados e etc

### Rodando o projeto

Para rodar a API web basta executar o docker-compose.yml

```
docker-compose up --build
```

Ou com flag `-d` para segundo plano

Para rodar a suite de testes, você pode executar

```
docker-compose -f docker-compose.test.yml up --build --exit-code-from rspec
```

Rode em primeiro plano para ver a CI executando

## Adicionais

Foi implementado um arquivo de CI para o github actions que roda linters, testes e verifica saúde da aplicação a cada PR enviado e também na branch `main`

## Agradecimento

Foi um prazer escrever essa doc pra você, obrigado por ler até aqui, estou a disposição para o que precisar! 💎🎉🙂
