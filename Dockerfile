# Используем образ Ruby 3.1.0
FROM ruby:3.1.0

# Обновляем список пакетов и устанавливаем необходимые зависимости
RUN apt-get update -qq && \
    apt-get install -y build-essential apt-utils libpq-dev nodejs postgresql-client yarn tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app 

# Копируем Gemfile и Gemfile.lock и выполняем установку гемов
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копируем остальные файлы проекта
COPY . /app

# Делаем исполняемыми скрипты в папке bin
RUN chmod +x /app/bin/*

# Открываем порт 3000 для приложения Rails
EXPOSE 3000

CMD bundle exec rails db:create && bundle exec rails db:migrate && ./bin/rails server -b 0.0.0.0
