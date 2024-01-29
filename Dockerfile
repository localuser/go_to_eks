# Very minimal golang source image built on alpine
FROM golang:1.19.13-alpine3.18

# Add the project go file:
COPY main.go .

# Set working dir to access project code
WORKDIR /go

# Expose port 8080 to the wide world
EXPOSE 8080

# Run the go app
ENTRYPOINT ["go", "run", "main.go"]

