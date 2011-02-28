s = %q{content: Fixtures::Application.routes.draw do
  resources :users}

marker = 'routes.draw do'

puts "esc marker: #{Regexp.escape(marker.to_s)}"
  
puts (s =~ /#{Regexp.escape(marker.to_s)}/)