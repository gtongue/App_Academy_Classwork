def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where(actors:{name: those_actors})
    .group(:id)
    .having('COUNT(movies.id) = ?', those_actors.length)
end

def golden_age
    Movie
      .select('AVG(score), (yr / 10) * 10 AS decade')
      .group('decade')
      .order('avg(score) DESC')
      .first
      .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movie_ids = Movie
    .select(:id)
    .joins(:actors)
    .where(actors:{ name: name })
    .pluck(:id)

  Actor
    .select(:name).distinct
    .joins(:movies)
    .where(movies:{id: movie_ids})
    .where.not(name: name)
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .select('COUNT(*) AS count')
    .joins("LEFT OUTER JOIN castings ON castings.actor_id = actors.id")
    .where('castings.actor_id IS NULL')
    .group('actors.id')
    .having('COUNT(actors.id) = 0')
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

end
