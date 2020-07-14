# Ressaca Trainee

### 1. Descrição

- Projeto final do processo trainee da empresa júnior Struct do semestre 1/2020.
- Plataforma web de e-commerce de bebidas com as seguintes funcionalidades:
  - Cadastro, remoção e edição de produtos e tipos de pordutos.
  - Busca de produtos por meio de filtros ou do nome desejado.
  - Sistema de cadastro e login de usuário.
  - Sistema de dinheiro permitindo compras e a adição de fundos.
  - Sistema de carrinho e de compras de produtos.
  - Sistema de múltiplos endereços de envio por usuário.
  - Restrição de idade para usuários que desejam comprar produtos alcoolicos.

### 2. Versões utilizadas

- Ruby 2.7.1
- Rails 5.2.4.3

### 3. Gems adicionais utilizadas

- Jquery Rails
- Jquery Mask Rails
- Pagy
- Figaro
- Sorcery
- Bootstrap 4.5.0
- Owl Carousel Rails
- Font-Awesome Rails

### 4. Instalação

1. Clone o repositório utilizando o comando:
   * `git clone https://github.com/Nandosts/Ressaca-trainee.git`
2. Configure o arquivo 'config/database.yml' de acordo com o banco de dados instalado em sua máquina.
3. Inicialize o banco de dados usando o comando: 
   - `rails db:create`.
4. Faça as migrações do banco de dados com o seguinte comando:
   - `rails db:migrate`
5. Adicione, ao banco de dados, o perfil do admin utilizando o comando:
   - `rails db:seed`
6. Ligue o servidor usando:
   - `rails s`

### 5. Observações

- Para se utilizar o perfil de admin, é necessaŕio utilizar o comando `rails db:seed` e logar no site usando o login admin@admin e a senha 123.
- Apenas o admin pode criar, editar ou apagar um produto ou tipo de produto.

### 6. Desenvolvedores

- André Macedo
- Arthur Mota 
- Felipe Lima
- Fernando Jorge