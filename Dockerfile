FROM ruby:3.3.6

COPY . /boolder


RUN     gem install rails && \ 
        gem install rails bundler && \
        gem install foreman

RUN     apt update && \
        apt install -y libvips && \
        apt install -y libvips-tools

WORKDIR /boolder

RUN bundle install

RUN rake assets:precompile

EXPOSE 8080
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]
