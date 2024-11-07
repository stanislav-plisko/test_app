1. Рефакторинг класса Users::Create с использованием ActiveInteraction
  # app/interactions/users/create.rb

2. Исправление опечатки Skil
  Путь 1: Переименовать класс Skil в Skill и обновить все ссылки на него. (используется в проекте)
  Путь 2: Если переименование невозможно, можно использовать псевдоним в модели User:
    class User < ApplicationRecord
      has_many :interests
      has_many :skills, class_name: 'Skil', foreign_key: 'skil_id'
    end
    В модели Skill:
      class Skill < ApplicationRecord
        self.table_name = 'skils' # указыважем существующее имя таблицы
        has_and_belongs_to_many :users
      end

3. Исправление связей
  Использовал has_and_belongs_to_many для связи между User и Interest, а также User и Skill.

4. Поднятие Rails приложения и использование класса Users::CreateUser
  Users::CreateUser используется в контроллере UsersController.

  тестирование:
  1. запускаем rails s
  2. с помощью postman отправляем POST запрос на http://localhost:3000/users
  {
    "user": {
      "name": "John",
      "patronymic": "Doe",
      "surname": "Smith",
      "email": "john.doe@example.com",
      "age": 30,
      "nationality": "American",
      "country": "USA",
      "gender": "male",
      "interests": "coding",
      "skills": "Rails"
    }
  }

  либо
  curl -X POST http://localhost:3000/users \
     -H "Content-Type: application/json" \
     -d '{
           "user": {
             "name": "John",
             "patronymic": "Doe",
             "surname": "Smith",
             "email": "john.doe@example.com",
             "age": 30,
             "nationality": "American",
             "country": "USA",
             "gender": "male",
             "interests": "coding",
             "skills": "Rails"
           }
         }'

5. Написание тестов
  rspec
  open coverage/index.html

