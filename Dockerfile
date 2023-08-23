FROM golang

RUN go mod init go_test && go mod tidy

WORKDIR /opt/test/
COPY . .

RUN go build -o go_test