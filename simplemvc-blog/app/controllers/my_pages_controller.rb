class MyPagesController < Simplemvc::Controller
  attr_reader :name
  
  def about
    render :about, name: "Rem", last_name: "Zolotykh"
  end

  def tell_me
    @name = "Rem"
  end
end
