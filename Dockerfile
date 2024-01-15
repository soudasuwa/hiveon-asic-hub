FROM ubuntu:latest
RUN apt update
RUN apt install -y curl
WORKDIR /app
COPY . .
RUN bash install.sh --yes
WORKDIR /opt/asic-hub/
CMD [ "/app/entrypoint.sh" ]
EXPOSE 8800
