package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)
func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}
type Order struct {
	id			uint64
	customer 	string
	reply		chan *Order
	preparedBy  string
}
var nextID atomic.Uint64
var waiter chan *Order

func cook(name string) {
	log.Println(name, "starting work")
	for {
		order := <-waiter
		do(10, name, "cooking order", order.id, "for", order.customer)
		order.preparedBy = name
		order.reply <- order
	}
}
func customer(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	mealsEaten := 0
	for mealsEaten < 5 {
		orderID := nextID.Add(1)
		order := &Order{
			id:		  orderID,
			customer: name,
			reply: 	  make(chan *Order),
		}
		log.Println(name, "placed order", order.id)
		select {
		case waiter <- order:
			meal := <-order.reply
			do(2, name, "eating cooked order", meal.id, "prepared by", meal.preparedBy)
			mealsEaten++
		case <-time.After(7 * time.Second):
			do(5, name, "waiting too long, abandoning order", order.id)
		}
	}
	log.Println(name, "going home")
}
func main() {
	rand.Seed(time.Now().UnixNano())
	customers := []string{
		"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai",
	}
	waiter = make(chan *Order, 3)
	go cook("Remy")
	go cook("Colette")
	go cook("Linguini")
	var wg sync.WaitGroup
	wg.Add(len(customers))
	for _, c := range customers {
		go customer(c, &wg)
	}
	wg.Wait()
	log.Println("Restaurant closing")
}