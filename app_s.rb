require 'bundler'
Bundler.require



class HomePage < Sinatra::Base

  def get_sport_list
    ["archery", "basketball", "biathlon", "cricket", "football", "ice_hockey", "lacrosse", "golf", "ultamite_frisbe"]
  end

  def get_sport
    sport_list = get_sport_list
    sport = sport_list.sample
    @@current_sport = {:imgs => ["/images/Sports/#{sport}/hint1.jpg", "/images/Sports/#{sport}/hint2.jpg", "/images/Sports/#{sport}/hint3.jpg"], 
    :answer => sport}
    @@current_sport
  end

  get '/' do
    erb :index
  end
  get '/mode' do
    erb :index_f
  end

  get '/sports' do
    erb :index_s, :locals => {:sport => get_sport}
  end

  post '/sports' do
    answer = @@current_sport[:answer].gsub("_"," ")
    guess = params["answer"]
    if guess.nil?
      erb :index_s, :locals => {:sport => @@current_sport, :guess => guess, :answer => answer}
    elsif guess != answer
      alert = "you got it wrong!"
      erb :index_s, :locals => {:sport => @@current_sport, :guess => guess, :answer => answer}
    else guess == answer
      alert = "you got it right!"
      erb :index_s, :locals => {:sport => get_sport, :guess => guess, :answer => answer}
    end
  end
end
