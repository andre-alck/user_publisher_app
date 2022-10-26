# p_user_publisher

Projeto Flutter que:

1. cria uma base de dados;
2. cria uma tabela 'user' na base de dados;
3. adiciona informações incompletas de um usuário na tabela;
4. envia sinal via AMQP na RK = user.name;
5. recebe sinal via AMQP na RK = user.name e
6. completa informações na tabela.

## Getting Started

Para executar o projeto, em sua pasta, execute:

```
flutter run
```
