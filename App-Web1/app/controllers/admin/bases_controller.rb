class Admin::BasesController < ApplicationController
  before_action :ensure_admin_user!

  def ensure_admin_user!
    begin
      if current_user and current_user.admin?
        return true
      else
        redirect_to root_path, danger: "you don't belong there."
      end
    rescue => e
      redirect_to root_path, danger: "you don't belong there."
    end
  end
end