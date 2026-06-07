package main

import (
	"log"
	"net/http"
	"os"

	"github.com/nishchayranjan_1/real-time-money-mov/internal/db"
	"github.com/nishchayranjan_1/real-time-money-mov/internal/handler"
)

func main() {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		dsn = "postgres://postgres:postgres@localhost:5432/money_mov?sslmode=disable"
	}

	pool, err := db.Connect(dsn)
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}
	defer pool.Close()

	mux := http.NewServeMux()
	h := handler.New(pool)
	h.Register(mux)

	addr := ":8080"
	log.Printf("server listening on %s", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
