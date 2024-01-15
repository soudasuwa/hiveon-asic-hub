# Base image
FROM ubuntu:latest

# Dependencies
RUN apt update
RUN apt install -y curl

# Copy everything
WORKDIR /app
COPY . .

# Run installer
WORKDIR /app/installer/
RUN bash ./install.sh

# Remove installer
WORKDIR /app
RUN rm -r ./installer/

CMD [ "/app/entrypoint.sh" ]
EXPOSE 8800
