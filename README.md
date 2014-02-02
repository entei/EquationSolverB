EquationSolverB
===============

Backend sinatra part of equations solver

Test it:
```json
curl -X POST -H "Content-Type: application/json" -d '{"equation":{ "type":"linear","a":"1","b":"2"}}' http://equation-solver-backend.herokuapp.com/solve
```

Test it locally:
```
$ bundle install
$ bundle exec rackup -p 4567 config.ru
```

```json
curl -X POST -H "Content-Type: application/json" -d '{"equation":{ "type":"linear","a":"1","b":"2"}}' http://localhost:4567/solve
```
