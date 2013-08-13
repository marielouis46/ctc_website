require 'bundler'
Bundler.require



class HomePage < Sinatra::Base

  def get_actor_list
    ["adam_sandler", "chris_rock", "cuba_gooding_jr", "jhonny_depp", "kevin_hart", "emma_stone", "reese_witherspoon"]
  end

  def get_actor
    actor_list = get_actor_list
    actor = actor_list.sample
    @@current_actor = {:imgs => ["/images/Actors/#{actor}/hint1.jpg", "/images/Actors/#{actor}/hint2.jpg", "/images/Actors/#{actor}/hint3.jpg"], 
    :answer => actor}
    @@current_actor
  end

  get '/' do
    erb :index
  end
  get '/mode' do
    erb :index_f
  end

  get '/actors' do
      erb :index_a, :locals => {:actor => get_actor}
  end

  post '/actors' do
    answer = @@current_actor[:answer].gsub("_"," ")
    guess = params["answer"]
    if guess.nil?
      erb :index_a, :locals => {:actor => @@current_actor, :guess => guess, :answer => answer}
    elsif guess != answer
      alert = "you got it wrong!"
      erb :index_a, :locals => {:actor => @@current_actor, :guess => guess, :answer => answer}
    else guess == answer
      alert = "you got it right!"
      erb :index_a, :locals => {:actor => get_actor, :guess => guess, :answer => answer}
    end
  end
end
