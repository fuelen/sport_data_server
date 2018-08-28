# API Documentation

  * [SportDataServerWeb.LeagueSeasonPairController](#sportdataserverweb-leagueseasonpaircontroller)
    * [index](#sportdataserverweb-leagueseasonpaircontroller-index)
  * [SportDataServerWeb.RecordController](#sportdataserverweb-recordcontroller)
    * [index](#sportdataserverweb-recordcontroller-index)

## SportDataServerWeb.LeagueSeasonPairController
### <a id=sportdataserverweb-leagueseasonpaircontroller-index></a>index
#### index .json
##### Request
* __Method:__ GET
* __Path:__ /league_season_pairs.json

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "league_season_pairs": [
    {
      "season": "season2",
      "league": "league3"
    },
    {
      "season": "season1",
      "league": "league1"
    }
  ]
}
```

## SportDataServerWeb.RecordController
### <a id=sportdataserverweb-recordcontroller-index></a>index
#### index .json
##### Request
* __Method:__ GET
* __Path:__ /league_season_pairs/league1/season1/records.json

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "records": [
    {
      "league_season_pair": {
        "season": "201617",
        "league": "SP1"
      },
      "htr": "D",
      "hthg": 0,
      "htag": 0,
      "home_team": "Malaga",
      "ftr": "D",
      "fthg": 1,
      "ftag": 1,
      "date": {
        "year": 2016,
        "month": 8,
        "day": 19
      },
      "away_team": "Osasuna"
    },
    {
      "league_season_pair": {
        "season": "201617",
        "league": "SP1"
      },
      "htr": "D",
      "hthg": 0,
      "htag": 0,
      "home_team": "La Coruna",
      "ftr": "H",
      "fthg": 2,
      "ftag": 1,
      "date": {
        "year": 2016,
        "month": 8,
        "day": 19
      },
      "away_team": "Eibar"
    }
  ]
}
```

