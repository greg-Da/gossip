require_relative 'gossip'
require_relative 'comment'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'  
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params['id']), id: params['id'], comments: Comment.get_all_related_comments(params['id'])}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.find(params['id']), id: params['id']}
  end

  post '/gossips/:id/edit/' do
    gossip = Gossip.find(params['id'])
    gossip.update(params["gossip_author"], params["gossip_content"])
    redirect "/gossips/#{params['id']}"  
  end

  post '/gossips/:id/comment/' do
    Comment.new(params['id'], params["comment_author"], params["comment_content"]).save
    redirect "/gossips/#{params['id']}"
  end

end