SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :home, 'Home', "/"
    primary.item :teachers, 'Teachers', "/teachers"
    primary.item :students, 'Students', "/students"
  end
end