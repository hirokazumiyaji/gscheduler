FROM ruby:2.3-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev git gcc g++ make

RUN echo "gem: --no-document" > /root/.gemrc

RUN mkdir -p /root/app

VOLUME /root/app

EXPOSE 3000

WORKDIR /root/app
