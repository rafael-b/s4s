class UserController < ApplicationController
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
  
  layout "user"
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def index
    @objects = User.all
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def show
    @id  = params[:id]
    @object = User.first(:conditions=>{:id=>@id})
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  [:blog,:forum,:store,:school].each do |field|

    define_method(field.to_s) do
      @id  = params[:id]
      @object = User.first(:conditions=>{:id=>@id})
    end

  end
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
