class CategoriesController < ApplicationController

before_action :authenticate, except: [:index, :show]


def authenticate
  @shoonga = authenticate_or_request_with_http_basic do |username, password|
    username == "trevor" && password == "trevor"
  end
end
 
 
def index
  @cats = Category.all
  @categories = Category.all.paginate(page: params[:page])
end

def show
  @cats = Category.all
  @category = Category.find(params[:id])
  #@items = @user.items.paginate(page: params[:page])
  #debugger
end
    
 
 
 
 def new
  @category = Category.new
  @cats = Category.all
 end
  
 def create
   @cats = Category.all
  @category = Category.new(category_params)
  if params[:title].nil?
    if @category.save
      flash[:success] = "category created!"
      render 'edit'
    else
      redirect_to root_path
    end
  end
end
  
  
def edit
  @cats = Category.all
  @category = Category.find(params[:id])
end

def update
  @category = Category.find(params[:id])
  if @category.update_attributes(category_params)
    # Handle a successful update.
    flash[:success] = "cat updated"
    redirect_to categories_path
  else
    render 'edit'
  end
end
  
def destroy
  @cats = Category.all
  Category.find(params[:id]).destroy
  flash[:success] = "photo deleted"
  redirect_to root_url
end


private

def category_params
      params.require(:category).permit(:name)
    end

end