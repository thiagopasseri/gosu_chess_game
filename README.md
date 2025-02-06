# gosu_chess_game

A game of chess written in Ruby using Gosu as graphic library

-> próximos passos

- implementar save/load com o objeto board inteiro
  - fazer distinção no load, se vai ser arquivo JSON (apenas array) ou YAML (objeto inteiro - pesquisar no chatGPT além do claude)
- colocar botao save game ou teclado ('s' para save)
- implementar "cmd + Z" para voltar um movimento e "cmd + shift + Z" para avançar um movimento

hoje é dia 05 de fevereiro de 2025. Acredito que fiquei os últimos 10 a 15 dias nesse projeto do Xadrez.
claro que outras coisas atrapalharam, mas acabei demorando bastante.

Aqui vão alguns próximos passos:

1. a inicialização do board ainda tá estranha.
2. isso de initial_condition (sendo array e hash) poderia ser melhor unificado
3. com o hash da board -> temos o estado da board mas não temos histórico nem nada
4. fazer um método que converta entre um e outro:

- dado um jogo -> exporto o board hash + histórico (ou só com o histórico mais um metodo de jogar -> tenho o estado do board final)
- conversao entre board e um hash -> [coord] -> piece name / cor

5. implementar melhor o crtl + Z
6. implementar save game
