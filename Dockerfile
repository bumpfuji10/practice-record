FROM ruby:3.1
ARG RUBYGEMS_VERSION=3.3.20
RUN mkdir /practice-record
WORKDIR /practice-record
COPY Gemfile /practice-record/Gemfile
COPY Gemfile.lock /practice-record/Gemfile.lock
RUN bundle install
COPY . /practice-record

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
