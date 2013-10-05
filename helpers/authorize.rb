# encoding: utf-8
module Authorize

  def teacher?
    redirect(to('/login')) unless (session[:role] == "teacher")
  end

  def admin?
  	redirect(to('/login')) unless (session[:role] == "admin")
  end

end
