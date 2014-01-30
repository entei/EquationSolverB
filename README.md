EquationSolverB
===============

Backend sinatra part of equations solver

Test it locally:

$ bundle install
$ bundle exec rackup -p 4567 config.ru &
$ curl http://localhost:4567

```json
curl -X POST -H "Content-Type: application/json" -d '{"equation":{ "type":"linear","a":"1","b":"2"}}' http://localhost:4567/solve
```
