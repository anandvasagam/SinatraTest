require 'sinatra'
require 'sinatra/activerecord'
require './model/User'
require './model/Section'
require './helpers/User_helper'
require './helpers/Section_helper'

get '/user/all' do
  display_all()
end

get '/user/create' do
  create_user()
end

get '/user/modify' do
  modify_user()
end
  
get '/user/delete' do
  delete_user()
end

get '/section/create' do
    create_section()
end

get '/section/all' do
  view_all_sections()
end

get '/section/viewuser' do
  view_section_for_user()
end

get '/section/modify' do
  modify_section()
end

get '/section/delete' do
  delete_section() 
end









