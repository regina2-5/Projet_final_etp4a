# Roles de base
%w[student company trainer admin].each { |name| Role.find_or_create_by!(name: name) }

# Categories d'exemple
["Developpement Web", "Reseaux", "Data", "Design"].each do |name|
  Category.find_or_create_by!(name: name, kind: "job")
end

# Competences d'exemple
["Ruby on Rails", "JavaScript", "PostgreSQL", "React", "Linux"].each do |name|
  Skill.find_or_create_by!(name: name)
end

puts "Seed termine."
