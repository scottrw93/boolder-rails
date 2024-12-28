FROM ruby:3.3.6

COPY . /boolder


RUN     gem install rails && \ 
        gem install rails bundler && \
        gem install foreman

RUN     apt update && \
        apt install -y libvips && \
        apt install -y libvips-tools

WORKDIR /boolder/app

RUN bundle install

RUN rake assets:precompile

EXPOSE 8080
CMD ["/boolder/bin/rails", "server", "-b", "0.0.0.0", "-p", "8080" ]
