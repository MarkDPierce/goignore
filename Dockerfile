# Stage 1
FROM golang:1.23-alpine AS build

# Work from a clean locations
WORKDIR /app

COPY go.mod ./

# Download requirements
RUN go mod download

# Copy the rest of the source
COPY . .

# Build our application
RUN go build -o main .

## Stage 2
FROM alpine:3.20.2

# Copy the built application
COPY --from=build /app/main .

EXPOSE 8080

CMD ["./main"]