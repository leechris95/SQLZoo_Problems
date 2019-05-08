##########
# More Join #
##########

#Question 1
/*
List the films where the yr is 1962 [Show id, title] 
*/

SELECT id, title
FROM movie
WHERE yr=1962

#Question 2
/*
Give year of 'Citizen Kane'.
*/

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

#Question 3
/*
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
*/

SELECT id, title, yr
FROM movie 
WHERE title LIKE '%Star Trek%'
ORDER BY yr DESC

#Question 4
/*
What id number does the actor 'Glenn Close' have? 
*/

SELECT id
FROM actor
WHERE name = 'Glenn Close'

#Question 5
/*
What is the id of the film 'Casablanca' 
*/

SELECT id
FROM movie
WHERE title = 'Casablanca'

#Question 6
/*
Obtain the cast list for 'Casablanca'.
what is a cast list?

Use movieid=11768, (or whatever value you got from the previous question) 
*/

SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 11768

#Question 7
/*
Obtain the cast list for the film 'Alien' 
*/

SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Alien'

#Question 8
/*
List the films in which 'Harrison Ford' has appeared 
*/

SELECT movie.title
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE actor.name = 'Harrison Ford'

#Question 9
/*
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
*/

SELECT movie.title
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE actor.name = 'Harrison Ford'
  AND casting.ord != 1

#Question 10
/*
List the films together with the leading star for all 1962 films. 
*/

SELECT movie.title, actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE casting.ord = 1
  AND movie.yr = 1962

#Question 11
/*
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
*/

SELECT movie.yr, COUNT(actor.name)
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE actor.name = 'John Travolta'
GROUP by movie.yr
HAVING COUNT(actor.name) > 2

#Question 12
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
*/

SELECT movie.title, actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE casting.ord = 1 
  AND movie.id IN 
  (SELECT casting.movieid
    FROM actor JOIN casting ON actor.id = casting.actorid         
    WHERE actor.name = 'Julie Andrews' )

#Question 13
/*
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
*/

SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(casting.ord = 1) >= 30
ORDER BY actor.name ASC

#Question 14
/*
 List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
*/

SELECT movie.title, COUNT(actor.id)
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(actor.id) DESC,movie.title

#Question 15
/*
List all the people who have worked with 'Art Garfunkel'. 
*/

SELECT DISTINCT actor.name
FROM casting JOIN actor ON casting.actorid = actor.id
WHERE actor.name != 'Art Garfunkel'
  AND casting.movieid IN
  (SELECT casting.movieid
    FROM casting JOIN actor ON casting.actorid = actor.id
    WHERE actor.name = 'Art Garfunkel') 