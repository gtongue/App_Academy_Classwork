require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

# feed_me_a_fruit
year = 1
name = ''
fav_pastime = ''

begin

  sam = BestFriend.new(name, year, fav_pastime)
rescue YearError
  year = 5
  retry
rescue NameError
  name = "bob"
  retry
rescue PastimeError
  fav_pastime = "baseball"
  retry
# ensure
#   sam = BestFriend.new(name, year, fav_pastime)
end



sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet
