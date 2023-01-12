FROM ruby:3.1.3
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /komik
COPY Gemfile /komik/Gemfile
COPY Gemfile.lock /komik/Gemfile.lock
RUN bundle install

COPY . .
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
