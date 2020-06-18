class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    new_pet = Pet.new(params[:pet])
    unless params[:owner][:name]==""
      new_pet.owner = Owner.create(params[:owner])
    end
    new_pet.save
    redirect to "pets/#{new_pet.id}"
  end


  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    the_pet = Pet.find(params[:id])
    the_pet.update(params[:pet])
    unless params[:owner][:name]==""
      new_owner = Owner.create(params[:owner])
      the_pet.update(owner_id: new_owner.id)
      # the_pet.owner = Owner.create(params[:owner])
    end
    # binding.pry
    redirect to "pets/#{the_pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end