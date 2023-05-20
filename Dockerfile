FROM ruby:latest
RUN echo 'deb-src http://deb.debian.org/debian buster main' >> /etc/apt/sources.list
RUN apt update && apt install jq -y && apt build-dep jq -y
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle -j9
COPY ./ ./
ENV PORT=5000
EXPOSE 5000
ENV RACK_ENV=production
CMD ruby app.rb -p $PORT -o 0.0.0.0
