require 'bundler'
Bundler.require



class HomePage < Sinatra::Base

	def get_movie_list
		["django", "friday", "home_alone", "smart_house", "spy_kids", "the_blind_side", "the_color_purple"]
	end

	def get_movie
		movie_list = get_movie_list
		movie = movie_list.sample
		@@current_movie = {:imgs => ["/images/Movies/#{movie}/hint1.jpg", "/images/Movies/#{movie}/hint2.jpg", "/images/Movies/#{movie}/hint3.jpg"], 
		:answer => movie}
		@@current_movie
	end

	get '/' do
		erb :index
	end
	get '/mode' do
		erb :index_f
	end

	get '/movies' do
		erb :index_m, :locals => {:movie => get_movie}
	end

	post '/movies' do
		answer = @@current_movie[:answer].gsub("_"," ")
		guess = params["answer"]
		if guess.nil?
			erb :index_m, :locals => {:movie => @@current_movie, :guess => guess, :answer => answer}
    elsif guess.downcase != answer.downcase
      alert = "you got it wrong!"
      erb :index_m, :locals => {:movie => @@current_movie, :guess => guess, :answer => answer}
    else guess.downcase == answer.downcase
			alert = "you got it right!"
			erb :index_m, :locals => {:movie => get_movie, :guess => guess, :answer => answer}
		end
	end
end
