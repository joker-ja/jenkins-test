FROM golang


RUN pwd && ls -alh
RUN ls -alh src
RUN go mod init go_test && go mod tidy

RUN go build -o go_test