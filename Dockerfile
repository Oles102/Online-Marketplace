FROM ruby:3.1.0

RUN apt-get update -qq && \
     apt-get install -y build-essential apt-utils libpq-dev nodejs postgresql yarn tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



WORKDIR /project
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

RUN chmod +x /project/bin/*

EXPOSE 3000
CMD ["./bin/rails", "server"]
